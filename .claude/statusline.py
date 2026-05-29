#!/usr/bin/env python3
"""StatusLine: PS1-style header + fine-grained progress bar with true color gradient

Line 1: [model] [effort] │ ~/path │  branch ⇡1 ⇣2 *1 +3 !2 ?4 │  #12 (approved)
Line 2: ctw ████░░░░░░ 42% │ 5h ██░░░░░░░░ 23% (3h 45m) │ 7d ...
"""
import json, sys, os, time, re, subprocess, hashlib, shlex

data = json.load(sys.stdin)

BLOCKS = ' ▏▎▍▌▋▊▉█'
R = '\033[0m'
CLAUDE_ORANGE = '\033[38;2;217;119;87m'
CLAUDE_GREEN = '\033[38;2;120;140;93m'
YELLOW = '\033[38;2;220;180;60m'
CLAUDE_BLUE = '\033[38;2;106;155;204m'
CYAN = '\033[38;2;80;200;200m'
RED = '\033[38;2;220;80;80m'

# Nerd-font icons (Powerline/Octicons). p10k requires a nerd font, so these render.
ICON_BRANCH = '\uf418'   # nf-oct-git_branch
ICON_PR = ''       #  (git-pull-request; change if your font lacks it)


def gradient(pct):
    if pct < 50:
        r = int(pct * 5.1)
        return f'\033[38;2;{r};200;80m'
    else:
        g = int(200 - (pct - 50) * 4)
        return f'\033[38;2;255;{max(g,0)};60m'

def bar(pct, width=10):
    pct = min(max(pct, 0), 100)
    filled = pct * width / 100
    full = int(filled)
    frac = int((filled - full) * 8)
    b = '█' * full
    if full < width:
        if frac > 0:
            b += BLOCKS[frac]
            b += '░' * (width - full - 1)
        else:
            b += '░' * (width - full)
    return b

def fmt(label, pct):
    p = round(pct)
    return f'{label} {gradient(pct)}{bar(pct)} {p}%{R}'

def fmt_remaining(resets_at):
    if resets_at is None:
        return ''
    seconds = int(resets_at - time.time())
    if seconds <= 0:
        return ' (reset)'

    days, rem = divmod(seconds, 86400)
    hours, rem = divmod(rem, 3600)
    minutes, _ = divmod(rem, 60)

    if days > 0:
        text = f'{days}d {hours}h {minutes}m'
    elif hours > 0:
        text = f'{hours}h {minutes}m'
    else:
        text = f'{minutes}m'

    return f' ({text})'

cwd_raw = data.get('workspace', {}).get('current_dir') or data.get('cwd', '') or os.getcwd()

def get_cwd():
    home = os.path.expanduser('~')
    if cwd_raw.startswith(home):
        return '~' + cwd_raw[len(home):]
    return cwd_raw


# ---------------------------------------------------------------------------
# Git (detailed status with icons) — uses subprocess, independent of payload
# ---------------------------------------------------------------------------

def find_git_dir(start):
    d = start
    while True:
        candidate = os.path.join(d, '.git')
        if os.path.exists(candidate):
            return candidate
        parent = os.path.dirname(d)
        if parent == d:
            return None
        d = parent

def _resolve_gitdirs(git_dir):
    """Return (gitdir, commondir). Handles a .git *file* (worktree/submodule)."""
    real = git_dir
    if os.path.isfile(git_dir):
        try:
            with open(git_dir) as f:
                line = f.read().strip()
        except (OSError, IOError):
            return None, None
        if not line.startswith('gitdir: '):
            return None, None
        rel = line[8:]
        real = rel if os.path.isabs(rel) else os.path.normpath(
            os.path.join(os.path.dirname(git_dir), rel))
    common = real
    try:
        with open(os.path.join(real, 'commondir')) as f:
            rel = f.read().strip()
        common = rel if os.path.isabs(rel) else os.path.normpath(
            os.path.join(real, rel))
    except (OSError, IOError):
        pass
    return real, common

def get_git_info(git_dir):
    if git_dir is None:
        return None
    real, common = _resolve_gitdirs(git_dir)
    branch = ''
    ahead = behind = staged = unstaged = untracked = stashes = 0
    try:
        result = subprocess.run(
            ['git', '-C', cwd_raw, '--no-optional-locks',
             'status', '--porcelain=v1', '-b', '--untracked-files=normal'],
            capture_output=True, text=True, timeout=2)
        for i, line in enumerate(result.stdout.splitlines()):
            if i == 0 and line.startswith('## '):
                head = line[3:]
                if head.startswith('No commits yet on '):
                    branch = head[len('No commits yet on '):].split(' ')[0]
                else:
                    branch = head.split('...')[0].split(' ')[0]
                m = re.search(r'ahead (\d+)', line)
                if m:
                    ahead = int(m.group(1))
                m = re.search(r'behind (\d+)', line)
                if m:
                    behind = int(m.group(1))
            elif line:
                xy = line[:2]
                if xy == '??':
                    untracked += 1
                else:
                    if xy[0] not in (' ', '!'):
                        staged += 1
                    if xy[1] not in (' ', '!'):
                        unstaged += 1
    except Exception:
        pass

    # Branch fallback (git missing, or detached HEAD reported as "HEAD")
    if (not branch or branch == 'HEAD') and real:
        try:
            with open(os.path.join(real, 'HEAD')) as f:
                content = f.read().strip()
            if content.startswith('ref: refs/heads/'):
                branch = content[16:]
            elif content:
                branch = content[:8]
        except (OSError, IOError):
            pass

    # Stash count = entries in the stash reflog (refs/stash holds only the top)
    if common:
        try:
            with open(os.path.join(common, 'logs', 'refs', 'stash')) as f:
                stashes = sum(1 for _ in f)
        except (OSError, IOError):
            stashes = 0

    if not branch:
        return None
    return {'branch': branch, 'ahead': ahead, 'behind': behind,
            'staged': staged, 'unstaged': unstaged,
            'untracked': untracked, 'stashes': stashes}

def fmt_git(info):
    if info is None:
        return ''
    parts = [f'{CLAUDE_GREEN}{ICON_BRANCH} {info["branch"]}{R}']
    if info['ahead']:
        parts.append(f'{CYAN}⇡{info["ahead"]}{R}')
    if info['behind']:
        parts.append(f'{CYAN}⇣{info["behind"]}{R}')
    if info['stashes']:
        parts.append(f'{CLAUDE_GREEN}*{info["stashes"]}{R}')
    if info['staged']:
        parts.append(f'{YELLOW}+{info["staged"]}{R}')
    if info['unstaged']:
        parts.append(f'{YELLOW}!{info["unstaged"]}{R}')
    if info['untracked']:
        parts.append(f'{CLAUDE_BLUE}?{info["untracked"]}{R}')
    return ' '.join(parts)


# ---------------------------------------------------------------------------
# PR info — `gh` is the only real source (not in the statusline payload).
# Rendered from a short-lived cache; refreshed in a detached background
# process so rendering never blocks on the network.
# ---------------------------------------------------------------------------

PR_CACHE_DIR = os.path.expanduser('~/.claude/.statusline-cache')
PR_TTL = 30  # seconds

def _spawn_pr_refresh(cache_file):
    tmp = cache_file + '.tmp'
    cmd = (f'(gh pr view --json number,state,isDraft,reviewDecision 2>/dev/null '
           f'|| echo null) > {shlex.quote(tmp)} && mv {shlex.quote(tmp)} '
           f'{shlex.quote(cache_file)}')
    try:
        subprocess.Popen(['sh', '-c', cmd], cwd=cwd_raw,
                         stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                         start_new_session=True)
    except Exception:
        pass

def get_pr_info(git_dir):
    if git_dir is None:
        return None
    try:
        os.makedirs(PR_CACHE_DIR, exist_ok=True)
    except OSError:
        return None
    key = hashlib.sha1(os.path.abspath(git_dir).encode()).hexdigest()[:16]
    cache_file = os.path.join(PR_CACHE_DIR, key + '.json')
    cached, fresh = None, False
    try:
        age = time.time() - os.stat(cache_file).st_mtime
        with open(cache_file) as f:
            cached = json.load(f)
        fresh = age < PR_TTL
    except (OSError, IOError, ValueError):
        cached, fresh = None, False
    if not fresh:
        _spawn_pr_refresh(cache_file)
    return cached

def fmt_pr(pr):
    if not pr or not pr.get('number'):
        return ''
    if pr.get('isDraft'):
        label, color = 'draft', ''
    else:
        rd = pr.get('reviewDecision') or ''
        label, color = {
            'APPROVED': ('approved', CLAUDE_GREEN),
            'CHANGES_REQUESTED': ('changes', RED),
            'REVIEW_REQUIRED': ('review', YELLOW),
        }.get(rd, ((pr.get('state') or '').lower() or 'open', CYAN))
    s = f'{CLAUDE_BLUE}{ICON_PR} #{pr["number"]}{R}'
    if label:
        s += f' {color}({label}){R}'
    return s


# ---------------------------------------------------------------------------
# Assemble
# ---------------------------------------------------------------------------

model_name = data.get('model', {}).get('display_name', 'Claude')
model = f'{CLAUDE_ORANGE}{model_name}{R}'
effort = os.environ.get('CLAUDE_EFFORT')
if effort:
    model += f' {effort}'

git_dir = find_git_dir(cwd_raw)
cwd = f'{CLAUDE_BLUE}{get_cwd()}{R}'
line1 = [model, cwd]
git_str = fmt_git(get_git_info(git_dir))
if git_str:
    line1.append(git_str)
pr_str = fmt_pr(get_pr_info(git_dir))
if pr_str:
    line1.append(pr_str)

line2 = []
ctx = data.get('context_window', {}).get('used_percentage')
if ctx is not None:
    line2.append(fmt('ctw', ctx))

rate_limits = data.get('rate_limits', {})
for key, label in [('five_hour', '5h'), ('seven_day', '7d')]:
    limit = rate_limits.get(key, {})
    pct = limit.get('used_percentage')
    if pct is not None:
        line2.append(fmt(label, pct) + fmt_remaining(limit.get('resets_at')))

sep = '│'
print(sep.join(f' {p} ' for p in line1))
if line2:
    print(sep.join(f' {p} ' for p in line2), end='')

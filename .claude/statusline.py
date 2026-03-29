#!/usr/bin/env python3
"""StatusLine: PS1-style header + fine-grained progress bar with true color gradient"""
import json, sys, os, time

data = json.load(sys.stdin)

BLOCKS = ' ▏▎▍▌▋▊▉█'
R = '\033[0m'
CLAUDE_ORANGE = '\033[38;2;217;119;87m'
GREEN = '\033[38;2;120;200;120m'

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

def get_git_branch():
    d = cwd_raw
    while True:
        try:
            with open(os.path.join(d, '.git', 'HEAD')) as f:
                content = f.read().strip()
        except (OSError, IOError):
            parent = os.path.dirname(d)
            if parent == d:
                return ''
            d = parent
            continue
        if content.startswith('ref: refs/heads/'):
            return f'{GREEN}{content[16:]}{R}'
        return f'{GREEN}{content[:8]}{R}'

model = data.get('model', {}).get('display_name', 'Claude')
model = f'{CLAUDE_ORANGE}{model}{R}'
cwd = get_cwd()
branch = get_git_branch()
line1 = [model, cwd]
if branch:
    line1.append(branch)

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

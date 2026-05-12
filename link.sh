#!/bin/bash

set -eu

helpmsg() {
	printf '%s\n' "Usage: $0 [--help | -h] [--debug | -d]" >&2
	printf '\n' >&2
}

backup_dir=

repo_dir() {
	CDPATH='' cd "$(dirname "$0")" && pwd -P
}

ensure_backup_dir() {
	if [ -z "$backup_dir" ]; then
		backup_dir="$HOME/.dotbackup/$(date +%Y%m%d%H%M%S)-$$"
		mkdir -p "$backup_dir"
	fi
}

backup_existing() {
	dest=$1
	rel=${dest#"$HOME"/}

	ensure_backup_dir
	mkdir -p "$backup_dir/$(dirname "$rel")"
	mv "$dest" "$backup_dir/$rel"
	printf 'Backed up %s to %s\n' "$dest" "$backup_dir/$rel"
}

link_file() {
	src=$1
	dest=$2

	if [ ! -e "$src" ]; then
		printf 'Source not found: %s\n' "$src" >&2
		return 1
	fi

	mkdir -p "$(dirname "$dest")"

	if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
		printf 'Already linked: %s -> %s\n' "$dest" "$src"
		return 0
	fi

	if [ -e "$dest" ] || [ -L "$dest" ]; then
		backup_existing "$dest"
	fi

	ln -s "$src" "$dest"
	printf 'Linked %s -> %s\n' "$dest" "$src"
}

link_to_homedir() {
	dotdir=$(repo_dir)

	if [ "$HOME" = "$dotdir" ]; then
		printf 'same install src dest\n'
		return 1
	fi

	link_file "$dotdir/.vimrc" "$HOME/.vimrc"
	link_file "$dotdir/.zsh/.zshrc" "$HOME/.zshrc"
	link_file "$dotdir/.zsh/.p10k.zsh" "$HOME/.p10k.zsh"
	link_file "$dotdir/.zsh/aliases.zsh" "$HOME/.oh-my-zsh/custom/aliases.zsh"
	link_file "$dotdir/.conf/tmux.conf" "$HOME/.config/tmux/tmux.conf"
	link_file "$dotdir/.conf/yt-dlp.conf" "$HOME/.config/yt-dlp/config"
	link_file "$dotdir/.claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
	link_file "$dotdir/.claude/settings.json" "$HOME/.claude/settings.json"
	link_file "$dotdir/.claude/statusline.py" "$HOME/.claude/statusline.py"
	link_file "$dotdir/coding agent/AGENTS.md" "$HOME/.codex/AGENTS.md"
	link_file "$dotdir/coding agent/config.toml" "$HOME/.codex/config.toml"
	link_file "$dotdir/coding agent/settings.json" "$HOME/.gemini/settings.json"
}

while [ $# -gt 0 ]; do
	case ${1} in
	--debug | -d)
		set -eux
		;;
	--help | -h)
		helpmsg
		exit 0
		;;
	*)
		printf 'Unknown option: %s\n' "$1" >&2
		helpmsg
		exit 1
		;;
	esac
	shift
done

link_to_homedir
git config --global include.path "$HOME/.gitconfig_shared"
printf '\033[1mInstall completed!!!!\033[m\n'

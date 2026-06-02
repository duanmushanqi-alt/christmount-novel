#!/bin/zsh
set -e
cd ~/Documents/novel/christmount-novel

echo "[sync] current branch: $(git branch --show-current)"
git pull --ff-only

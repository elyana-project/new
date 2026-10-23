#!/bin/bash
# Installs ffmpeg and openai-whisper for Claude Code cloud sessions.
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

if ! command -v ffmpeg >/dev/null 2>&1; then
  apt-get update -qq
  DEBIAN_FRONTEND=noninteractive apt-get install -y -qq ffmpeg
fi

if ! command -v whisper >/dev/null 2>&1; then
  pip install --break-system-packages -q --root-user-action=ignore openai-whisper
fi

ffmpeg -version | head -1
whisper --help >/dev/null && echo "whisper OK"

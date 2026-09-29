#!/usr/bin/env bash
# Shared environment for every Antigravity process in this add-on.
# Sourced by the s6 services and by the ingress console.

export AGY_DATA_DIR="/data"
export HOME="${AGY_DATA_DIR}/home"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_RUNTIME_DIR="/run/user/0"
export AGY_BIN_DIR="${HOME}/.local/bin"
export AGY_BIN="${AGY_BIN_DIR}/agy"
export AGY_STATE_DIR="${AGY_DATA_DIR}/addon"
export AGY_SHIM_DIR="/usr/local/lib/antigravity/shims"
export AGY_WORKSPACE="/config"
export AGY_TMUX_SOCKET="agy"
export AGY_TMUX_SESSION="agent"
export UV_TOOL_DIR="${HOME}/.local/share/uv/tools"
export UV_TOOL_BIN_DIR="${HOME}/.local/bin"
export UV_PYTHON_INSTALL_DIR="${HOME}/.local/share/uv/python"
export UV_CACHE_DIR="${HOME}/.cache/uv"
export PATH="${AGY_BIN_DIR}:${PATH}"
export TERM="${TERM:-xterm-256color}"
export LANG="${LANG:-C.UTF-8}"

# No D-Bus / secret-service in the container: the CLI falls back to
# file-based token storage under ~/.gemini, which lives in /data.
unset DBUS_SESSION_BUS_ADDRESS

# Add-on options (written by init-antigravity for non-bashio consumers).
if [[ -f "${AGY_STATE_DIR}/options.env" ]]; then
    # shellcheck disable=SC1091
    source "${AGY_STATE_DIR}/options.env"
fi

if [[ "${AGY_OPT_AUTO_UPDATE:-true}" != "true" ]]; then
    export AGY_CLI_DISABLE_AUTO_UPDATE=true
fi

# Pretend to be an SSH session so the CLI uses the copy-URL / paste-code
# OAuth flow instead of trying to open a local browser.
agy_ssh_env() {
    export SSH_CONNECTION="${SSH_CONNECTION:-172.30.32.2 0 127.0.0.1 22}"
    export SSH_CLIENT="${SSH_CLIENT:-172.30.32.2 0 22}"
}

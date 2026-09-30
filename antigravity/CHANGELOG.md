# Changelog

## 0.3.2

- Remove the experimental local web UI (0.3.0 / 0.3.1). The CLI's hidden hub mode could not sign in and did not work inside the Home Assistant panel. Remote Control at antigravity.google.com is the supported way to use the agent.

## 0.2.2

- Fix 502 Bad Gateway on the setup console (nginx could not access the ttyd socket).
- Fix broken logo on the add-on info page.

## 0.2.1

- Rename to "Antigravity for Home Assistant"; add Antigravity icon and logo.
- Security: the setup console (ttyd) now listens on a UNIX socket behind nginx that only admits the Home Assistant ingress gateway.
- Comprehensive README and updated documentation.

## 0.2.0

- Add Home Assistant MCP server (ha-mcp) via uv, registered as `home-assistant` in `~/.gemini/config/mcp_config.json` (option `enable_ha_mcp`).

## 0.1.1

- Fix manifest map type, ttyd install, errexit in service script, s6 finish timeout.


## 0.1.0

- Initial test release: Antigravity CLI Remote Control host (daemon mode with
  interactive fallback), ingress setup console for sign-in, Home Assistant
  agent rules.

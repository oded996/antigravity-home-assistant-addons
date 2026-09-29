# Antigravity add-on

Runs the [Antigravity CLI](https://antigravity.google/docs/cli/overview) (`agy`)
on your Home Assistant host as an always-on
[Remote Control](https://antigravity.google/docs/remote-control) instance.
You drive the agent from **https://antigravity.google.com** in any browser
(desktop or mobile), and it works directly on your Home Assistant configuration.

## First-time setup

1. Install and start the add-on. The first start downloads the CLI (~60 MB).
2. Open **Antigravity** in the Home Assistant sidebar (the setup console).
3. Run `agy-login`. Open the printed URL in your browser, sign in with your
   Google account and paste the code back into the console. Type `/exit` when
   the CLI prompt appears.
4. Within ~30 s the Remote Control service starts. Check with `agy-status`
   or the add-on **Log** tab.
5. Go to https://antigravity.google.com, sign in with the same account and pick
   the instance named after the `instance_name` option (default
   `home-assistant`).

## What the agent can access

| Path | Access | Contents |
|---|---|---|
| `/config` | read/write | Home Assistant configuration (workspace root) |
| `/addon_configs` | read/write | Add-on configuration folders |
| `/share`, `/media` | read/write | Shared files and media |
| `/ssl`, `/backup` | read-only | Certificates, backups |

The agent also gets `SUPERVISOR_TOKEN`, so it can call the Home Assistant Core
API (`http://supervisor/core/api/`) and Supervisor API (`http://supervisor/`),
e.g. to validate config with `POST /core/check`. This context is written to
`~/.gemini/AGENTS.md` when `manage_agents_md` is enabled.

Everything the CLI stores (binary, sign-in token, conversations, settings)
lives in the add-on's `/data` directory and survives restarts and updates.

## Options

| Option | Default | Description |
|---|---|---|
| `instance_name` | `home-assistant` | Name shown in the Remote Control instance list |
| `mode` | `daemon` | `daemon` (headless, always on) or `interactive` (`agy --remote-control` in tmux) |
| `auto_update` | `true` | Let the CLI self-update |
| `manage_agents_md` | `true` | Regenerate the global agent rules with Home Assistant context |
| `enable_ha_mcp` | `true` | Install [ha-mcp](https://github.com/homeassistant-ai/ha-mcp) and register it as the `home-assistant` MCP server (in `~/.gemini/config/mcp_config.json`, other servers you add there are kept) |
| `debug` | `false` | Verbose add-on script logging |

## Troubleshooting

- **Instance not listed**: check the add-on log for `not signed in` and run
  `agy-login` again. Make sure the same Google account is used on
  antigravity.google.com.
- **"Remote control is not enabled for your account"**: your account or plan
  does not have Remote Control yet.
- **Daemon mode keeps failing**: set `mode: interactive` and restart. Use
  `agy-attach` in the panel to see the live CLI.
- **Security note**: the setup console is only exposed through Home Assistant
  ingress (admin users). The agent has write access to your configuration;
  keep `/config` under git or take backups.

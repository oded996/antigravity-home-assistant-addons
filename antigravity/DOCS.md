# Antigravity for Home Assistant

Runs the [Antigravity CLI](https://antigravity.google/docs/cli/overview) (`agy`)
on your Home Assistant host as an always-on
[Remote Control](https://antigravity.google/docs/remote-control) instance.
You drive the agent from **https://antigravity.google.com** in any browser,
on desktop or mobile. It works directly on your Home Assistant configuration and
has native Home Assistant tools through the bundled
[ha-mcp](https://github.com/homeassistant-ai/ha-mcp) MCP server.

## Requirements

- A 64-bit host (amd64 or aarch64).
- A Google account with access to Antigravity Remote Control.
- Outbound HTTPS access:
  - **Always:** `antigravity.google`, `antigravity.google.com` and `*.googleapis.com`.
  - **For installing/updating ha-mcp:** `github.com`, `pypi.org` and `files.pythonhosted.org`.
- About 1 GB of free disk space. This data is included in backups of this add-on.

## First-time setup

1. Start the add-on. The first start downloads the CLI, a managed Python and
   ha-mcp, so it can take several minutes. Wait for `Initialization complete`
   in the **Log** tab.

   Until you sign in, the log repeats an `Antigravity is not signed in yet`
   warning every 30 seconds. That's expected.
2. Open **Antigravity** in the Home Assistant sidebar. This is the setup console.
3. Run `agy-login`. Open the printed URL in your browser, sign in with your
   Google account, and paste the code back into the console. Type `/exit` when
   the CLI prompt appears.
4. Within about a minute the log shows `Starting Remote Control daemon`. You
   can also check with `agy-status`.
5. Go to https://antigravity.google.com, sign in with the **same** account, and
   pick the instance named after the `instance_name` option (default
   `home-assistant`).

## What the agent can access

| Path | Access | Contents |
|---|---|---|
| `/config` | read/write | Home Assistant configuration (workspace root) |
| `/addon_configs` | read/write | Add-on configuration folders |
| `/share`, `/media` | read/write | Shared files and media |
| `/ssl`, `/backup` | read-only | Certificates, backups |

The agent can also use:

- **ha-mcp tools**, the `home-assistant` MCP server: entities, services,
  automations, scripts, dashboards, helpers, history and more.
- **The Home Assistant Core API** (`http://supervisor/core/api/`) and
  **Supervisor API** (`http://supervisor/`), authenticated with
  `SUPERVISOR_TOKEN`. For example, it can validate config with `POST /core/check`.

When `manage_agents_md` is enabled, this context is written to
`~/.gemini/AGENTS.md`.

Everything the CLI stores lives in the add-on's `/data` directory and survives
restarts and updates: the binary, sign-in token, conversations, settings and
MCP config. Inside the add-on, `~` is `/data/home`.

## Options

| Option | Default | Description |
|---|---|---|
| `instance_name` | `home-assistant` | Name shown in the Remote Control instance list. Daemon mode only; interactive mode uses a generated name, printed in the log as `agy: Hostname: …`. |
| `mode` | `daemon` | `daemon` (headless, always on) or `interactive` (`agy --remote-control` in tmux; attach with `agy-attach`) |
| `auto_update` | `true` | Let the CLI self-update |
| `manage_agents_md` | `true` | Regenerate the global agent rules with Home Assistant context |
| `enable_ha_mcp` | `true` | Install/upgrade [ha-mcp](https://github.com/homeassistant-ai/ha-mcp) and register it as the `home-assistant` MCP server in `~/.gemini/config/mcp_config.json`. Other servers in that file are kept, as long as it stays valid JSON. |
| `debug` | `false` | Verbose add-on script logging |

## Setup console commands

| Command | Description |
|---|---|
| `agy-login` | Sign in (URL + code flow) |
| `agy-status` | Sign-in and Remote Control daemon status |
| `agy-attach` | Attach to the interactive session (`mode: interactive`) |
| `agy-logs [N]` | Last N lines (default 100) of the latest CLI log |
| `agy` | The full Antigravity CLI. Use `/mcp` to inspect MCP servers. |

## Security

- **Write access.** The agent can write to your configuration and control
  your home through the API. Take a backup or put `/config` under git before
  big changes.
- **Approvals.** Workspace file edits don't prompt. Under the default
  permission preset, other actions, such as MCP tool calls and commands outside
  the sandbox, ask for approval in the Remote Control UI. Permission settings
  can only be changed from the CLI.
- **Remote access** is tied to your Google account, so use 2-step verification.
- **The setup console** is only reachable through Home Assistant ingress. nginx
  admits only the ingress gateway, and no host ports are exposed.
- **Credentials.** Your Antigravity token and the MCP config (which contains
  the Supervisor token) are stored in `/data` and included in backups of this
  add-on, so use encrypted backups.

## Troubleshooting

- **Instance not listed.** Check the log for `not signed in` and run
  `agy-login` again. Make sure you use the same Google account on
  antigravity.google.com.
- **"Remote control is not enabled for your account".** Your account or plan
  doesn't have Remote Control yet.
- **Daemon mode keeps failing.** Set `debug: true` and check the log. As a
  workaround, try `mode: interactive` and use `agy-attach` to see the live CLI.
- **Stuck in interactive mode after signing in.** Restart the add-on.
- **Agent doesn't see Home Assistant tools.** Start a new conversation and
  check the log for `Registered 'home-assistant' MCP server`.

Report issues at https://github.com/oded996/antigravity-home-assistant-addons/issues
and include the log with `debug: true`.

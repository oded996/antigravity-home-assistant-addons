# Antigravity Add-ons for Home Assistant

Run the [Google Antigravity](https://antigravity.google) coding agent on your
Home Assistant host so it can manage your configuration, write automations,
dashboards and custom integrations — and control it from any browser with
[Antigravity Remote Control](https://antigravity.google/docs/remote-control).

[![Add repository to Home Assistant](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Foded996%2Fantigravity-home-assistant-addons)

## Add-ons

### [Antigravity](antigravity/)

- Always-on Antigravity CLI Remote Control host (`agy remote-control`)
- Read/write access to `/config`, `/addon_configs`, `/share`, `/media`
- Home Assistant Core + Supervisor API access for the agent
- Small ingress console for one-time sign-in and troubleshooting
- amd64 and aarch64

## Manual installation

1. **Settings → Add-ons → Add-on Store → ⋮ → Repositories**
2. Add `https://github.com/oded996/antigravity-home-assistant-addons`
3. Install **Antigravity**, start it, then follow the add-on documentation.

> Status: early test release.

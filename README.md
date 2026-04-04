# vps-fleet-manager

Zero-setup bootstrap for a Codex agent that manages Hostinger and Contabo VPS fleets from this repository.

The primary supported Hostinger path remains the official global MCP server: `hostinger-api-mcp`.

Contabo is supported through the official REST API for direct read/list operations, plus an optional remote MCP connector path when a connector key is available.

This repository does **not** implement a custom MCP server.

## What happens automatically in Dev Container

When you open this repo in a VS Code Dev Container:

1. Tools are already installed in the container:
   - `codex`
   - `hostinger-api-mcp`
2. A guided onboarding script runs automatically.
3. The script guides you through:
   - Codex login (ChatGPT or API key)
   - Creating or updating `profiles.json`
   - Final health check
4. Codex starts automatically and sends an intro that includes:
   - Agent purpose
   - Repository version from `ver.yaml`

After that, you can immediately chat with the agent.

## Super Simple Setup (recommended)

## 1. Install required apps on your computer

- Docker Desktop
- Visual Studio Code
- VS Code extension: `Dev Containers` (by Microsoft)

## 2. Clone and open this repository

```bash
git clone <your-repo-url>
cd vps-fleet-manager
code .
```

## 3. Open inside Dev Container

In VS Code:

1. Press `F1`
2. Run `Dev Containers: Reopen in Container`
3. Wait until container build finishes

## 4. Follow the guided onboarding terminal

The script runs automatically and asks for:

1. Codex authentication:
   - `ChatGPT login` (recommended), or
   - `OPENAI_API_KEY`
2. A tenant name and `HOSTINGER_API_TOKEN` when no Hostinger profile exists yet

The script writes `profiles.json` for you and runs checks.

If the prompt window does not appear, run manually in the container terminal:

```bash
bash scripts/devcontainer-onboarding.sh
```

## 5. Codex starts automatically

After onboarding finishes, Codex auto-launches.

If VS Code runs `postAttachCommand` in a non-interactive context, auto-start is deferred to your first interactive terminal in the workspace and runs automatically there.

If it does not launch (rare terminal issue), run:

```bash
bash scripts/devcontainer-onboarding.sh
```

Now ask things like:

- `How many VPS do I have?`
- `Give me the name of each VPS`
- `Create a new VPS in Phoenix`
- `Add this SSH key to VPS smart14.domain.tld`

## Important safety

- Creating/deleting/upgrading VPS can cost money.
- Ask the agent to list/show details first before mutating anything.
- Never commit `profiles.json`.

## Multi-provider profiles

Repository credentials now live in `profiles.json`, not `.env`.

- Tracked example: `profiles.json.template`
- Real local file: `profiles.json`
- Inspect configured provider entries:

```bash
node scripts/profiles.js list --format text
```

- Validate the local private file:

```bash
./scripts/doctor-unix.sh
```

- Resolve the selected Hostinger credentials into the current shell session:

```bash
node scripts/profiles.js resolve --provider hostinger --format shell
```

- List Contabo instances with the selected tenant profile:

```bash
node scripts/contabo-api.js list-instances --format summary
```

The resolver uses this precedence:

1. Explicit CLI selector flags on `start-agent`
2. Process environment overrides such as `VPS_TENANT`
3. Optional defaults in `profiles.json`
4. Auto-select only when there is exactly one matching tenant/provider entry

## Provider requirements

- `hostinger`
  - Canonical credential key in `profiles.json`: `API_TOKEN`
  - Also accepted: `HOSTINGER_API_TOKEN`
  - Execution path: official `hostinger-api-mcp`

- `contabo`
  - Direct official API credentials: `CLIENT_ID`, `CLIENT_SECRET`, `API_USER`, `API_PASSWORD`
  - Optional pre-minted token: `CONTABO_ACCESS_TOKEN`
  - Optional remote connector key: `CONTABO_MCP_API_KEY`
  - Direct repo path: `node scripts/contabo-api.js list-instances --format summary`
  - Optional MCP wrapper path: `scripts/contabo-mcp.sh` or `scripts/contabo-mcp.ps1`

## Files you may care about

- Devcontainer config: `.devcontainer/devcontainer.json`
- Onboarding script: `scripts/devcontainer-onboarding.sh`
- Agent launcher with intro prompt: `scripts/start-agent.sh`
- MCP wrapper (Linux): `scripts/hostinger-mcp.sh`
- Contabo API helper: `scripts/contabo-api.js`
- Contabo MCP wrapper (Linux): `scripts/contabo-mcp.sh`
- Contabo MCP wrapper (Windows): `scripts/contabo-mcp.ps1`
- Shared profile resolver: `scripts/profiles.js`
- Profiles template: `profiles.json.template`
- Linux Codex MCP template: `.codex/config.toml.example`
- Agent rules: `AGENTS.md`

## Manual setup outside Dev Container (optional)

Linux/macOS:

```bash
./scripts/bootstrap-unix.sh
node scripts/profiles.js list --format text
./scripts/doctor-unix.sh
bash scripts/start-agent.sh --tenant customer-a
```

Windows PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/bootstrap-windows.ps1
powershell -ExecutionPolicy Bypass -Command "node scripts/profiles.js list --format text"
powershell -ExecutionPolicy Bypass -File scripts/doctor-windows.ps1
powershell -ExecutionPolicy Bypass -File scripts/start-agent.ps1 -Tenant customer-a
```

## Disable auto-start (optional)

Set `AUTO_START_CODEX` to `false` in `.devcontainer/devcontainer.json` if you do not want Codex to auto-open on the first interactive terminal after each container start.

## License

This repository is a cloned and modified version of Ratio1 Open Source.

- Original repository: https://github.com/ratio1/vps-agent
- Upstream base: Ratio1 Open Source under Apache License 2.0 (commercial use allowed).
- This modified repository includes AurelexAI-specific changes.
- The repository remains open, but commercial use of AurelexAI-specific modifications requires prior written permission from AurelexAI.
- License text: `LICENSE.md`
- Attribution and fork notice: `NOTICE`
- Copyright: Copyright (c) 2026 AurelexAI

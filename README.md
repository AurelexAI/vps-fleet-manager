# vps-fleet-manager

Zero-setup bootstrap for a Codex agent that manages Hostinger VPS fleet using the official global MCP server: `hostinger-api-mcp`.

This repository does **not** implement a custom MCP server.

## What happens automatically in Dev Container

When you open this repo in a VS Code Dev Container:

1. Tools are already installed in the container:
   - `codex`
   - `hostinger-api-mcp`
2. A guided onboarding script runs automatically.
3. The script guides you through:
   - Codex login (ChatGPT or API key)
   - Entering your `HOSTINGER_API_TOKEN`
   - Writing `.env` for you
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
2. Your `HOSTINGER_API_TOKEN` (from Hostinger hPanel -> Profile -> API)

The script writes `.env` for you and runs checks.

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
- Never commit `.env`.

## Files you may care about

- Devcontainer config: `.devcontainer/devcontainer.json`
- Onboarding script: `scripts/devcontainer-onboarding.sh`
- Agent launcher with intro prompt: `scripts/start-agent.sh`
- MCP wrapper (Linux): `scripts/hostinger-mcp.sh`
- Linux Codex MCP template: `.codex/config.toml.example`
- Agent rules: `AGENTS.md`

## Manual setup outside Dev Container (optional)

Linux/macOS:

```bash
./scripts/bootstrap-unix.sh
./scripts/doctor-unix.sh
bash scripts/start-agent.sh
```

Windows PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/bootstrap-windows.ps1
powershell -ExecutionPolicy Bypass -File scripts/doctor-windows.ps1
powershell -ExecutionPolicy Bypass -File scripts/start-agent.ps1
```

## Disable auto-start (optional)

Set `AUTO_START_CODEX` to `false` in `.devcontainer/devcontainer.json` if you do not want Codex to auto-open on the first interactive terminal after each container start.

## License

This project is licensed under the Apache License 2.0.

- License text: `LICENSE.md`
- Attribution notices: `NOTICE`
- Copyright: Copyright (c) 2026 AurelexAI

# Implementation Plan

## Goal

Enable users to create and run a Codex-based Hostinger fleet-management agent locally with minimal friction and clear operational safety.

## Minimal Scaffolding

- `.env.template`
  - hostinger token and optional debug variables
- `.codex/config.toml.example`
  - Linux/macOS MCP config template
- `.codex/config.windows.toml.example`
  - Windows MCP config template
- `scripts/hostinger-mcp.sh`
  - Linux/macOS wrapper: `.env` load + `API_TOKEN` export + launch global `hostinger-api-mcp`
- `scripts/hostinger-mcp.ps1`
  - Windows wrapper equivalent
- `scripts/bootstrap-unix.sh` / `scripts/bootstrap-windows.ps1`
  - install global tools and initialize local config
- `scripts/devcontainer-onboarding.sh`
  - interactive first-run assistant in devcontainer (Codex auth + token capture)
- `scripts/doctor-unix.sh` / `scripts/doctor-windows.ps1`
  - preflight checks
- `scripts/start-agent.sh` / `scripts/start-agent.ps1`
  - start Codex from project root with initial purpose/version intro
- `.devcontainer/*`
  - optional Windows-friendly development environment

## Delivery Phases

## Phase A: Baseline Bootstrap

- Provide bootstrap scripts for Linux/macOS and Windows.
- Ensure global install path for `@openai/codex` and `hostinger-api-mcp`.
- Initialize `.env` and `.codex/config.toml` from templates.

Success criteria:

- User can bootstrap with one command per OS.

## Phase B: Runtime Wiring

- Add wrapper scripts that load `.env` and run `hostinger-api-mcp`.
- Ensure `HOSTINGER_API_TOKEN` -> `API_TOKEN` mapping.

Success criteria:

- MCP starts without manually exporting environment variables each session.

## Phase C: Operational Guardrails

- Add clear `AGENTS.md` policy.
- Document safe execution patterns in README.
- Add doctor scripts for fast diagnosis.
- Ensure startup prompt introduces agent purpose and repository version.

Success criteria:

- Common misconfiguration failures become self-diagnosable.

## Phase D: Windows Optional Devenv

- Add VS Code devcontainer with global tool preinstall.
- Add auto-run onboarding step on container attach.

Success criteria:

- Windows users can run workflow through containerized Linux environment.

## Risks and Mitigations

1. Missing global npm binaries in PATH
   - Mitigation: bootstrap + doctor scripts validate command availability.
2. Missing token at runtime
   - Mitigation: wrapper scripts fail fast with explicit message.
3. Secret leakage
   - Mitigation: `.env` and `.codex/config.toml` ignored by git.
4. Architecture drift toward custom MCP implementation
   - Mitigation: explicit prohibition in `AGENTS.md`.

## Out of Scope (for this repo)

- Custom Hostinger MCP server implementation
- Custom SDK wrapper logic for API endpoints
- Runtime business logic for endpoint orchestration outside official MCP tools

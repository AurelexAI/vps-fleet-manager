# Iteration Log

## Cycle: BUILDER-CRITIC-BUILDER-CRITIC-BUILDER

## BUILDER-1

Initial implementation mistakenly scaffolded a custom local TypeScript MCP server.

## CRITIC-1

Issue found: architecture violated project objective (must use official global `hostinger-api-mcp`).

## BUILDER-2

Refactor performed:

- removed custom local MCP server scaffolding
- created bootstrap/config/wrapper scripts around global `hostinger-api-mcp`
- added cross-platform setup and doctor scripts

## CRITIC-2

Checked against objective:

- repository now acts as Codex-agent bootstrap kit
- no custom MCP server code remains
- windows optional devenv path added

## BUILDER-3

Finalized docs and policy:

- README rewritten for correct setup
- AGENTS.md updated with hard architectural constraints
- research and implementation plan aligned to correct approach
- devcontainer now runs guided onboarding for Codex auth + Hostinger token
- Codex now auto-starts (interactive attach) and receives an intro prompt with purpose + version from ver.yaml

## Cycle: Devcontainer Auto-Start Reliability (2026-02-28)

## BUILDER-1

Observed that some VS Code/devcontainer environments run `postAttachCommand` without an interactive TTY, causing onboarding to skip `exec` and leaving users at a plain bash prompt.

## CRITIC-1

Issue found: autostart behavior depended on attach execution context instead of guaranteed interactive terminal state.

## BUILDER-2

Implemented guarded `.bashrc` hook installation in `scripts/devcontainer-onboarding.sh`:

- hook runs only in devcontainer + interactive TTY
- hook runs only inside this workspace path
- hook executes onboarding script, which then starts Codex
- marker file prevents repeated launches in the same container runtime

## CRITIC-2

Validated design against regressions:

- preserves existing onboarding flow and safety checks
- keeps `AUTO_START_CODEX=false` opt-out behavior
- avoids custom MCP/server additions

## BUILDER-3

Finalized integration and docs:

- `.devcontainer/devcontainer.json` now clears the autostart marker on each container start (`postStartCommand`)
- README updated to explain deferred autostart behavior and manual fallback command

## Cycle: Open-Source Licensing (2026-02-28)

## BUILDER-1

Added Apache-2.0 license artifacts for public reuse while keeping AurelexAI copyright ownership.

## CRITIC-1

Issue found: README did not explicitly state licensing and ownership, making reuse terms less discoverable.

## BUILDER-2

Added `LICENSE.md` (Apache License 2.0 text) and `NOTICE` with project-level attribution.

## CRITIC-2

Checked repository consistency:

- license file present and readable
- notice file present
- ownership statement included in docs

## BUILDER-3

Updated README with a dedicated license section that points to `LICENSE.md` and `NOTICE`, and states `Copyright (c) 2026 AurelexAI`.

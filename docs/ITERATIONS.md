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

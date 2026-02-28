# Research Notes (2026-02-28)

## Objective

Design a repository that bootstraps a local Codex agent for Hostinger fleet management using the **official** Hostinger MCP package (`hostinger-api-mcp`), not a custom MCP implementation.

## Authoritative Sources

1. Hostinger API docs portal
   - https://developers.hostinger.com
2. Hostinger OpenAPI spec
   - https://developers.hostinger.com/openapi/openapi.json
3. Official Hostinger MCP package
   - https://www.npmjs.com/package/hostinger-api-mcp
4. Official Hostinger MCP repository
   - https://github.com/hostinger/api-mcp-server
5. OpenAI Codex repository
   - https://github.com/openai/codex
6. OpenAI Codex config reference
   - https://developers.openai.com/codex/config-reference
7. OpenAI Codex IDE integration docs
   - https://developers.openai.com/codex/ide

## Key Findings

## 1) Existing Hostinger MCP already covers required intents

The official `hostinger-api-mcp` server already exposes broad API tooling, including VPS listing/creation and SSH key workflows. Building a custom local MCP layer is unnecessary for this repo goal.

## 2) Correct repository role is "agent bootstrap + guardrails"

Given the objective, the repo should provide:

- repeatable setup scripts
- Codex MCP config templates
- environment/token handling wrappers
- safety and usage policy

Not a duplicate API client/server implementation.

## 3) Token model

`hostinger-api-mcp` uses `API_TOKEN`. Project `.env` can remain user-friendly (`HOSTINGER_API_TOKEN`) and wrapper scripts can map/export `API_TOKEN` at runtime.

## 4) Cross-platform needs

Windows users often benefit from either:

- native PowerShell setup scripts, or
- VS Code devcontainer for consistent Linux tooling.

Both should be provided.

## 5) Codex integration model

Codex MCP config should reference command-based servers in `.codex/config.toml`. Project-local templates are useful, but the local active config must stay uncommitted.

## Decision

Implement this repository as a **Codex agent bootstrap kit** wired to global `hostinger-api-mcp`, with Linux/macOS + Windows support and no custom MCP server code.

# Implementation Plan

1. Replace `.env`-based secret resolution with `profiles.json` resolution.
2. Keep Hostinger on the official `hostinger-api-mcp` wrapper path.
3. Add Contabo support using the official REST API for read/list operations.
4. Add optional remote Contabo MCP wrapper support without introducing a local MCP server.
5. Update bootstrap, doctor, onboarding, and launcher scripts for the new profile flow.
6. Update tracked templates and local config examples so Codex can start with the expected provider wrappers.
7. Validate the new flow with doctor scripts, profile validation, and provider inventory checks.

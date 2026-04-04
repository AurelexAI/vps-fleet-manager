# Research

## Reference repo used

- Source: `https://github.com/ratio1/vps-agent`
- Reference commit inspected locally during this change: `20aa5ba0c8c8d6be3d33dc851b1ab3695561fa17`

## Relevant patterns reused

- `scripts/profiles.js`
  - Shared resolver for `profiles.json`
  - Provider aliases for Hostinger and Contabo credentials
  - Validation and upsert helpers
- `scripts/contabo-api.js`
  - Direct read/list integration against the official Contabo REST API
  - Supports either `CONTABO_ACCESS_TOKEN` or `CLIENT_ID` / `CLIENT_SECRET` / `API_USER` / `API_PASSWORD`
- `scripts/contabo-mcp.sh` and `scripts/contabo-mcp.ps1`
  - Optional remote Contabo MCP connector path via `mcp-remote`

## Architecture decisions

- Hostinger remains on the official `hostinger-api-mcp` path only.
- No custom local MCP server code was added.
- No local Node or TypeScript wrapper was added for Hostinger REST endpoints.
- Contabo support is split into:
  - direct read/list operations through the official REST API
  - optional remote MCP connector support when a `CONTABO_MCP_API_KEY` is available
- Secrets now come from untracked `profiles.json`.
- `.env` is obsolete and removed from the active workflow.

## Constraints checked

- Linux/macOS and Windows scripts were both updated.
- Wrapper scripts stay minimal and only resolve credentials plus launch the provider tool.
- Mutating or billable provider actions are still not automated in bootstrap/doctor flows.

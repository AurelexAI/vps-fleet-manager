# Iterations

## BUILDER-1

- Ported the shared `profiles.json` resolver from the reference repo into `scripts/profiles.js`.
- Added `scripts/contabo-api.js` for direct Contabo inventory access.
- Added optional remote Contabo MCP wrappers for Linux/macOS and Windows.

## CRITIC-1

- Checked the port against repository constraints.
- Kept Hostinger on `hostinger-api-mcp` only.
- Avoided adding any Hostinger REST client or custom MCP server.
- Noted that docs and bootstrap still needed a full `.env` removal pass.

## BUILDER-2

- Reworked bootstrap, doctor, onboarding, and startup scripts to use `profiles.json`.
- Updated Codex config templates to include Hostinger plus optional Contabo MCP wiring.
- Added `profiles.json.template` and required architecture docs.
- Marked `.env.template` as obsolete and removed live `.env` usage.

## CRITIC-2

- Ran doctor and profile validation checks locally.
- Ran a live Contabo inventory listing via `node scripts/contabo-api.js list-instances --format summary`.
- Ran a live Hostinger inventory listing by resolving the selected Hostinger profile and issuing a read-only VPS list request.
- Confirmed both providers resolve from the private `profiles.json`.

## BUILDER-3

- Cleaned up remaining documentation drift.
- Deleted the obsolete local `.env`.
- Performed a final hostname check for both providers.

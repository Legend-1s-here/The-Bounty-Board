# Security Rules

## Secrets
- Never hardcode credentials, API keys, tokens, or connection strings.
  Always read from environment/config/secret manager.
- Never print, log, or include secrets in an artifact (task list,
  implementation plan, walkthrough) even for debugging purposes.
- If you find an existing hardcoded secret while working nearby, flag it
  explicitly rather than fixing it silently as a drive-by change — leaking
  its rotation into an unrelated PR can hide the fact it needs rotating.

## Input handling
- All external input (user input, API payloads, query params, file
  uploads) is untrusted until validated. Validate at the boundary, not
  deep in business logic.
- Parameterized queries only — never string-concatenated SQL.
- Any file upload/parsing path must handle malformed/oversized/malicious
  input without crashing the process.

## AuthZ
- Every new endpoint/action states explicitly who is allowed to call it,
  and that check happens server-side, not just hidden in the UI.
- Don't assume an existing auth check upstream covers a new code path —
  verify it does, or add one.

## Dependencies
- New dependencies require checking: is it maintained, does it have known
  CVEs, what's its transitive dependency footprint. This is part of what
  the architecture ADR (see `architecture.md`) should cover for new deps.

## Confirm before acting — never do these autonomously without explicit
## human confirmation in the current session:
- Database schema migrations against anything beyond a local/dev
  environment.
- Deleting data, dropping tables/collections, truncating anything.
- Deployments to staging/production.
- Rotating or revoking credentials.
- Force-pushing, rewriting git history, deleting branches with unmerged
  work.
- Modifying CI/CD pipeline permissions or secrets.

## Security tooling
- Don't disable a security linter/scanner rule to unblock a build. If it's
  a false positive, say so and suppress it narrowly with a comment
  explaining why, not by turning the rule off globally.

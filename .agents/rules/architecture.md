# Architecture Rules

## Layering
- TODO: state your layers explicitly, e.g.:
  `handler/controller → service → repository → data source`
- Dependencies point in one direction only. A lower layer must never import
  from a higher one.
- Business logic lives in the service layer, not in controllers/handlers and
  not in the database layer.

## What requires an ADR before implementation
Write a short ADR (`docs/adr/`, use `0000-template.md`) *before* coding when
a task involves any of:
- A new external dependency (library, service, SaaS integration).
- A new architectural pattern not already used elsewhere in the codebase
  (new state management approach, new caching strategy, new messaging
  pattern, etc.).
- A change to a public API contract or database schema that other
  consumers depend on.
- Introducing a new cross-cutting concern (auth strategy, logging strategy,
  error-handling strategy).

If unsure whether something crosses this bar, write the ADR anyway — it's a
few minutes and it's cheap insurance against inconsistent patterns
accumulating across sessions/agents.

## Consistency over novelty
If two ways of solving a problem are roughly equivalent, use the pattern
already established elsewhere in this codebase, even if a different pattern
is marginally more elegant in isolation. Introducing a second way to do the
same thing is a cost, not a stylistic choice — flag it in the Task List
artifact if you think the existing pattern should change, don't just
diverge from it silently.

## Forbidden patterns
- TODO: list anti-patterns specific to this project (e.g. "no direct SQL in
  handlers," "no business logic in React components," "no global mutable
  state").

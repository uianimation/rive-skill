# Contributing to the Rive Skill

Thanks for helping keep this skill accurate and useful. A few ground rules:

## What makes a good contribution

This skill is meant to be **operational**, not a general Rive tutorial. Before submitting, ask:

- Is this concrete? (exact names, property types, values, decision rules — not "use a state machine when appropriate")
- Is this current? (link the specific Rive docs page or changelog entry you verified it against)
- Does it belong in `SKILL.md` (a rule/decision that applies broadly) or in `references/` (deep detail on one area)?

## Reporting stale content

Rive ships Editor builds and runtime releases frequently. If something in `SKILL.md` no longer matches current Rive behavior:

1. Open an issue describing what changed and link the current official docs page or changelog entry that confirms it.
2. If you can, include the Editor build number or runtime package version where you observed the change.

## Submitting a PR

1. Fork and branch from `main`.
2. Keep edits scoped — one topic/feature per PR is easier to review than a large rewrite.
3. Update `metadata.version` and `metadata.research-date` in `SKILL.md`'s frontmatter if your change reflects newly-verified information.
4. Cite sources in the PR description (official Rive docs URLs, changelog entries) so reviewers can verify quickly.
5. Match the existing style: short declarative rules, `text` code blocks for naming examples, and no marketing language.
6. Regenerate the complete portable file and run the validation suite before committing.

## Updating `references/`

Keep detailed, topic-specific guidance in the existing focused references:

- `editor-authoring.md` — Editor structure, import, animation, rigging, Layouts, and assets
- `interaction-data.md` — State Machines, listeners, Data Binding, and View Models
- `scripting-ai-mcp.md` — Scripting (Luau/Protocols), Editor AI Agent, Rive MCP
- `scripting-toolchain.md` — Protocol details, file formats, analyzer/LSP CLI, and exported runtime validation
- `runtimes-performance-accessibility.md` — Runtimes, renderer, performance, accessibility
- `runtime-integration-patterns.md` — Runtime loading, lifecycle, Data Binding, failures, and cleanup
- `runtime-handoff-checklist.md` — Runtime handoff and QA
- `official-docs-map.md` — Map of official Rive documentation

Each reference should change how an agent handles that topic without duplicating `SKILL.md`'s shared rules.

## Validation and behavioral evals

Run:

```powershell
./scripts/build-portable.ps1
./scripts/validate-skill.ps1
```

Use `./scripts/validate-skill.ps1 -CheckExternalLinks` when reviewing version-sensitive claims. Network failures should be distinguished from a confirmed broken source before changing guidance.

For substantial decision changes, run the prompts in `evals/behavioral-cases.md` with a clean agent context. Grade the pass invariants and observable outcome, not matching headings or phrases.

## Code of conduct

Be respectful, cite your sources, and keep discussion focused on making the skill more accurate for everyone using it.

# Rive Skill

Production guidance for [Rive](https://rive.app) — the Editor, `.riv` files, State Machines, Data Binding/View Models, rigging, Layouts, scripting (Luau), Rive MCP, runtime integration, performance, and accessibility — packaged as an Agent Skill plus a portable prompt.

Built and maintained by **Praneeth Kawya Thathsara** — [uianimation.com](https://uianimation.com).

## Why this exists

Rive evolves quickly, so model knowledge and copied SDK examples can become stale. This skill provides durable architecture rules, naming conventions, a debugging order, and a developer-handoff format while directing the agent to current official docs for version-sensitive behavior.

## Included formats

| File | Use with | What it is |
|---|---|---|
| **`SKILL.md`** | Codex and other Agent Skills-compatible clients | The concise entry point with YAML metadata and routing to focused references. |
| **`references/*.md`** | Agent Skills-compatible clients | Deeper guidance loaded only when a task needs it. |
| **`rive-instructions.md`** | AI tools with a system-prompt or persistent-context field | Portable copy of the entry point without YAML frontmatter. Include relevant reference files when deeper guidance is needed. |

Regenerate the portable file after changing `SKILL.md`:

```powershell
./scripts/build-portable.ps1
```

## Installing

### Codex

Copy the `rive` folder into your personal or project skill directory, then invoke it as `$rive` or let Codex select it when a Rive request matches the description.

Install the skill folder in Codex:

```bash
# personal (all projects)
cp -r rive-skill ~/.codex/skills/rive

# project-level (one repo)
cp -r rive-skill .codex/skills/rive
```

The skill triggers automatically whenever a task matches its `description`.

### Other Agent Skills clients

Place the complete folder in that client's documented skill directory so `SKILL.md`, `references/`, and `agents/` stay together.

### ChatGPT

- **Custom GPT:** paste the full contents of `rive-instructions.md` into the GPT's "Instructions" field when creating/editing a Custom GPT.
- **Custom Instructions (personal):** paste it into ChatGPT Settings → Personalization → Custom Instructions ("What would you like ChatGPT to know about you" / "How would you like ChatGPT to respond"), or keep it as a saved snippet you paste at the start of a Rive-focused conversation.

### Cursor

Save `rive-instructions.md` as (or append it into) your project's `.cursorrules` file, or add it under Cursor Settings → Rules.

### Any other AI tool with a system prompt / context field

Paste `rive-instructions.md` in as-is. It's plain Markdown with no vendor-specific syntax.

## What's inside

- **Core operating rules** — verify version-sensitive claims, prefer Data Binding over legacy State Machine Inputs/Events, treat runtime-facing names as an API, don't fake editing a `.riv` file without real tooling, design per-runtime, keep app code semantic.
- **Task workflow** — classify the task, establish the runtime contract (View Model schema), choose the simplest correct architecture, build for interruption/reversibility, test the real integration.
- **Focused references** for authoring, interaction/data, scripting/AI/MCP, runtimes/performance/accessibility, handoff/QA, and official documentation.
- **Naming conventions**, a developer-handoff format, a debugging order, and migration guidance for modernizing older files.

## A note on freshness

Rive ships frequently. The `research-date` in `SKILL.md` records the last documentation review, while the skill directs agents to `https://rive.app/docs/llms.txt`, the feature-support matrix, the target runtime docs, and the changelog before making version-sensitive claims.

## Contributing

Contributions are welcome — especially:

- Improving focused `references/*.md` guidance without duplicating the entry point.
- Flagging anything that's gone stale as Rive ships new Editor/runtime releases.
- Corrections from real production use (architecture patterns, gotchas, performance findings).
- Format/compatibility notes for other AI tools not yet listed above.

Please keep additions **concrete and testable** (exact names, property types, values, and a "why") rather than general advice — that's the standard the rest of the file holds itself to. See `CONTRIBUTING.md` for details.

## License

MIT — see `LICENSE`.


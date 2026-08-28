<div align="center">

# Rive Skill

### Production-ready Rive guidance for AI coding agents

Design, animate, structure, debug, optimize, and integrate interactive Rive experiences with clearer architecture and safer runtime handoff.

<br>

<a href="https://github.com/uianimation/rive-skill/raw/refs/heads/main/SKILL.md" download="SKILL.md">
  <img src="https://img.shields.io/badge/⬇_DOWNLOAD_SKILL.md-0D7CFF?style=for-the-badge&logoColor=white" alt="Download SKILL.md" height="56">
</a>

<br><br>

[![Rive](https://img.shields.io/badge/Rive-Editor_%26_Runtime-1B1B1F?style=flat-square)](https://rive.app)
[![Agent Skill](https://img.shields.io/badge/Agent_Skill-Ready-22C55E?style=flat-square)](SKILL.md)
[![License: MIT](https://img.shields.io/badge/License-MIT-F59E0B?style=flat-square)](LICENSE)
[![Version](https://img.shields.io/badge/version-0.4.0-8B5CF6?style=flat-square)](SKILL.md)

**Maintained by [Praneeth Kawya Thathsara](https://uianimation.com)**

</div>

---

## What this skill does

Rive changes quickly, and copied SDK examples or generic model knowledge can become stale. This skill gives AI agents a maintainable way to approach real Rive work while directing them to current official documentation for version-sensitive behavior.

| Authoring | Interaction | Integration |
|---|---|---|
| Artboards, timelines, rigging, components, Layouts, assets | State Machines, listeners, Data Binding, View Models, converters | Runtimes, renderers, scripting, Rive MCP, performance, accessibility |

It also defines semantic naming, runtime contracts, a practical debugging order, QA expectations, and a developer-handoff format.

## Quick start

### 1. Download

Use the large button above or [download **SKILL.md** directly](https://github.com/uianimation/rive-skill/raw/refs/heads/main/SKILL.md).

> Keep the complete repository when possible. The focused files in [<code>references/</code>](references/) provide deeper guidance that the main skill loads only when relevant.

### 2. Install in Codex

~~~bash
# Personal — available in every project
cp -r rive-skill ~/.codex/skills/rive

# Project-level — available in one repository
cp -r rive-skill .codex/skills/rive
~~~

Invoke it explicitly as <code>$rive</code>, or let Codex select it automatically when a request matches the skill description.

### 3. Use with other AI tools

| Client | Recommended file |
|---|---|
| Codex or another Agent Skills client | <code>SKILL.md</code> with the <code>references/</code> and <code>agents/</code> folders |
| ChatGPT, Cursor, Gemini, or another prompt-based tool | <code>rive-instructions.md</code> |

Regenerate the portable instructions after editing <code>SKILL.md</code>:

~~~powershell
./scripts/build-portable.ps1
~~~

## Included files

~~~text
rive-skill/
├── SKILL.md
├── agents/
│   └── openai.yaml
├── references/
│   ├── editor-authoring.md
│   ├── interaction-data.md
│   ├── scripting-ai-mcp.md
│   ├── runtimes-performance-accessibility.md
│   ├── runtime-handoff-checklist.md
│   └── official-docs-map.md
├── scripts/
│   └── build-portable.ps1
└── rive-instructions.md
~~~

## Why the references are separate

The main skill stays concise and routes the agent to deeper material only when needed. This reduces unnecessary context while keeping specialist guidance available for authoring, interaction, scripting, runtime integration, optimization, accessibility, and handoff.

## Need hands-on Rive animation support?

### Hire a freelance Rive animator

Need a production-ready Rive animation, interactive State Machine, character rig, responsive component, or developer handoff completed for your product?

<div align="center">

<a href="https://riveanimator.com/">
  <img src="https://img.shields.io/badge/HIRE_A_RIVE_ANIMATOR-Visit_riveanimator.com-EC4899?style=for-the-badge" alt="Hire a freelance Rive animator at riveanimator.com" height="48">
</a>

<br><br>

**[Visit riveanimator.com →](https://riveanimator.com/)**

</div>

If you are looking to **hire a freelance Rive animator**, visit [riveanimator.com](https://riveanimator.com/) for professional Rive design, animation, interaction, and implementation support.

## Freshness and verification

The <code>research-date</code> in <code>SKILL.md</code> records the latest documentation review. For version-sensitive claims, the skill checks the official Rive documentation index, feature-support matrix, target-runtime documentation, and changelog instead of relying on remembered APIs.

## Contributing

Corrections and focused improvements are welcome. Keep additions concrete, cite the relevant official Rive source, avoid duplicating shared rules across references, and see [CONTRIBUTING.md](CONTRIBUTING.md) before submitting a change.

## License

Released under the [MIT License](LICENSE).


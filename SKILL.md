---
name: rive
description: Design, animate, structure, debug, optimize, or integrate interactive Rive graphics when the task needs Rive-specific authoring, architecture, tooling, or runtime guidance. Covers .riv files, State Machines, Data Binding, View Models, layouts, rigging, scripting/Luau, shaders, Rive MCP, runtimes, accessibility, and handoff. Do not use for generic animation comparisons or application work where Rive is only mentioned but no Rive-specific decision is required.
license: MIT
metadata:
  author: "Praneeth Kawya Thathsara (uianimation.com)"
  version: "0.6.0"
  research-date: "2026-09-01"
  official-docs: "https://rive.app/docs/"
---

# Rive

Help users produce maintainable, runtime-ready Rive work as a designer, animator, technical artist, and integration partner.

This skill works with Agent Skills-compatible clients. Live `.riv` editing requires Rive Editor tooling such as Rive MCP; version-sensitive guidance requires current Rive documentation.

Rive changes quickly. For version-sensitive claims or exact runtime APIs, consult the current official documentation, starting with `https://rive.app/docs/llms.txt`, the feature-support matrix, and the target runtime docs. Do not infer capability from an Editor build number alone. If current documentation is unavailable, identify the time-sensitive assumption and label the affected guidance unverified.

## Core rules

1. Inspect before changing. If Rive MCP or equivalent Editor tooling is available, inspect the current file, artboards, hierarchy, animations, State Machines, View Models, and bindings first.
2. Never claim to have edited or verified a `.riv` file without access to the file through suitable Rive tooling. Without it, provide exact Editor steps and a verifiable architecture.
3. Treat runtime-facing names and value contracts as an API. Preserve artboard, State Machine, View Model, property, enum, component, and asset names unless the user approves a breaking change.
4. Prefer Data Binding and View Model properties for new app-to-Rive contracts. Do not force migration of a working legacy file unless migration has a concrete benefit.
5. Design for the named runtime, renderer, device class, input method, and accessibility needs. Never assume every Editor feature works in every runtime.
6. Prefer the simplest native Rive mechanism that expresses the behavior. Add scripting only when timelines, State Machines, bindings, listeners, layouts, components, and constraints are insufficient.
7. Keep application code semantic. Expose properties such as `activity`, `progress`, or `accentColor`; avoid coupling app code to internal groups, timeline details, bones, or transforms.
8. Calibrate depth to the request. Answer a narrow beginner question directly; introduce a full production architecture only when the task needs one.

## Route the task

Read only the references relevant to the request:

- Editor structure, import, animation, rigging, layouts, components, and assets: [references/editor-authoring.md](references/editor-authoring.md)
- State Machines, listeners, Data Binding, View Models, properties, and converters: [references/interaction-data.md](references/interaction-data.md)
- Luau scripting, shaders, the Editor AI Agent, and Rive MCP: [references/scripting-ai-mcp.md](references/scripting-ai-mcp.md)
- Luau protocols, file formats, the analyzer/LSP CLI, and optional RAV runtime validation: [references/scripting-toolchain.md](references/scripting-toolchain.md)
- Runtime selection, renderer support, performance, and accessibility: [references/runtimes-performance-accessibility.md](references/runtimes-performance-accessibility.md)
- Runtime loading, lifecycle, Data Binding, error, and disposal patterns by platform: [references/runtime-integration-patterns.md](references/runtime-integration-patterns.md)
- Integration contract, debugging order, QA, and handoff: [references/runtime-handoff-checklist.md](references/runtime-handoff-checklist.md)
- Current source-of-truth links: [references/official-docs-map.md](references/official-docs-map.md)

## Working method

### 1. Establish the requested outcome

Identify the visual behavior, user interactions, app-controlled data, Rive-controlled outputs, target runtime, renderer constraints, responsive behavior, accessibility requirements, and performance budget. Preserve names and mappings already supplied by the user. Ask for missing runtime or interaction details only when they materially change the answer.

### 2. Define the runtime contract

Use a compact semantic contract. For example:

```text
Artboard: Character
State Machine: CharacterController
View Model: CharacterVM
activity: Enum(idle, listening, thinking, speaking)
emotion: Enum(neutral, happy, concerned)
progress: Number(0..1)
accentColor: Color
displayName: String
isEnabled: Boolean
celebrate: Trigger
```

Document initial values and direction for every property: app to Rive, Rive to app, or bidirectional.

### 3. Choose the architecture

- Timeline: authored motion over time.
- State Machine: state logic, transitions, interruption, and layered behavior.
- View Model property: durable semantic data shared with application code.
- Enum: closed modes or variants; prefer it to undocumented numeric codes.
- Boolean: persistent true/false state.
- Number: continuous values.
- Trigger: one-shot action.
- String or Color: dynamic presentation data.
- Image, Font, or Artboard property: replaceable visual asset.
- Nested View Model or List: hierarchical or repeated dynamic data.
- Converter: transform data before binding.
- Property Group: local keyable or animatable value that bridges to View Model data.
- Listener: interaction, property, or event response inside Rive.
- Layout and Component: responsive and reusable UI.
- Constraint, bone, mesh, or joystick: spatial control and deformation.
- Script: custom logic that built-in systems cannot express cleanly.

For bindings, default to source-to-target. Use target-to-source only when the scene must write back, bidirectional only when both sides truly own changes, bind-once for initialization, absolute paths for a known instance, and relative paths for reusable components.

### 4. Build for interruption and reversibility

Interactive motion should track the current user state rather than complete obsolete animation. Tune transition duration, exit time, pause-source behavior, and exit-during-transition deliberately. Separate independent simultaneous behaviors into State Machine layers, and avoid layers unintentionally animating the same property.

### 5. Verify the result

Test Editor preview, Data Binding preview, the actual runtime and renderer, real device sizes, pointer and touch where relevant, rapid repeated input, interruption, initial and missing data, late-loaded assets, reduced motion, and representative low-end hardware.

When tools are available, verify observable behavior rather than only checking that objects or names exist.

Record evidence using these labels:

- **Verified** — executed or previewed in the target Editor/runtime and the stated behavior was observed.
- **Inspected** — configuration, hierarchy, bindings, code, or diagnostics were examined, but end-to-end behavior was not run.
- **Unverified** — the required file, runtime, renderer, device, or current documentation was unavailable. State the exact remaining check.

## Output contract

Give concrete implementation guidance, not “use a State Machine” without the graph or data contract. For substantial work include:

1. artboard and hierarchy,
2. timelines and animation responsibilities,
3. State Machine layers, states, and transitions,
4. View Model schema and property directions,
5. bindings and component data context,
6. application/runtime responsibilities,
7. support assumptions and limitations,
8. QA checklist.

For handoff, include a compact table:

| Item | Name | Type | Values / purpose |
|---|---|---|---|
| Artboard | `Character` | Artboard | Main runtime artboard |
| State Machine | `CharacterController` | State Machine | Main interaction logic |
| View Model | `CharacterVM` | View Model | Runtime data contract |
| Property | `activity` | Enum | `idle`, `listening`, `thinking`, `speaking` |
| Property | `celebrate` | Trigger | One-shot celebration |

Also state initial values, property directions, runtime and renderer requirements, external assets, responsive fit, reduced-motion behavior, and known platform limitations.

End substantial implementation or debugging answers with the evidence label and the checks that support it.

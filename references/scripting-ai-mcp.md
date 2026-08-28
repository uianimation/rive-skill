# Scripting, AI Agent, and Rive MCP

> Last verified against official Rive documentation: 2026-08-28. Re-check MCP availability, endpoint, and supported operations before use.

Use this reference when built-in Rive systems are insufficient or when an AI tool is expected to inspect or modify a live Rive file.

## Scripting

Rive scripts use typed Luau and run in the Editor and supported runtimes. Choose the narrowest protocol before writing code. Current protocol families include Node, Layout, Converter, Path Effect, Transition Condition, Listener Action, Blank/helper, and Test. Rive also supports file-format-related scripts and WGSL shaders for advanced use cases.

- Prefer built-in State Machines, Data Binding, Layouts, listeners, and constraints where they are sufficient.
- Give scripts typed Inputs instead of hidden access to unrelated scene objects.
- Use the same View Model contract as application code; do not create a parallel data path.
- Handle missing or late-loaded data safely.
- Avoid unnecessary per-frame work and profile before optimizing.
- Use Test scripts for reusable logic.
- Check the Debug Panel, diagnostics, console output, and tests before declaring success.
- Keep a script's primary type name aligned with its PascalCase script name.

## Editor AI Agent versus Rive MCP

The Editor AI Agent is the chat surface built into Rive. It is useful when the user is working inside the Editor and wants in-app assistance.

Rive MCP lets an external MCP-capable client inspect and edit an open desktop Editor. The Rive desktop app must be open with a file and artboard ready. Availability, endpoint, and supported operations evolve, so obtain them from the current MCP documentation instead of relying on a remembered setup.

When MCP is available:

1. Discover the connected MCP tools and confirm that the required read, write, diagnostic, and preview operations are actually available.
2. Inspect the file, artboards, hierarchy, animations, State Machines, View Models, bindings, scripts, shaders, and diagnostics relevant to the request.
3. Identify runtime-facing names and record a compact before-state. For structural or hard-to-reverse work, export or otherwise preserve a recoverable source revision when the available tooling supports it.
4. Describe the intended mutation and extend the existing architecture instead of building a parallel system.
5. Make the smallest coherent change. Stop if a required mutation is unsupported rather than approximating it destructively.
6. Run script/shader diagnostics and tests where available. If a diagnostic fails, do not continue stacking unrelated edits; correct or revert the affected change first.
7. Preview or otherwise verify the behavior, including interruption, initial values, and the affected data context.
8. Report the before/after contract, changed objects, diagnostics, observed behavior, and any unverified checks.

If an edit partially succeeds and the intended behavior cannot be restored with the available operations, stop, preserve the diagnostics and current state, and give exact recovery steps. Never hide a partial failure.

If MCP is unavailable, do not claim to have edited the `.riv` file. Give precise Editor steps, names, values, connections, and verification instructions instead.

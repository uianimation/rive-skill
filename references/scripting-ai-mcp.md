# Scripting, AI Agent, and Rive MCP

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

Rive MCP lets an external MCP-capable client inspect and edit the open desktop Editor. It is currently documented for the Windows and macOS desktop Editor, with a local endpoint at `http://127.0.0.1:9791/mcp`. The Rive desktop app must be open with a file and artboard ready. Availability and supported operations evolve, so verify the current MCP documentation.

When MCP is available:

1. Inspect the file and existing public contracts.
2. Extend the existing architecture where possible.
3. Make the smallest coherent change.
4. Run diagnostics or tests where available.
5. Preview or otherwise verify the affected behavior.
6. Report exactly what changed and what could not be verified.

If MCP is unavailable, do not claim to have edited the `.riv` file. Give precise Editor steps, names, values, connections, and verification instructions instead.


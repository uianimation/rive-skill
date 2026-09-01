# Rive Luau scripting toolchain

> Verified 2026-09-01 against current Rive Editor declarations, Rive Web 2.41.1, C++ runtime-v0.1.344, the public Rive Luau LSP toolchain, and RAV MCP. Re-check live declarations and releases for version-sensitive work.

Use this reference when authoring or reviewing Rive Luau, file-format scripts, or exported runtime behavior. Keep static typing, Editor execution, exported runtime execution, and rendered pixels as separate evidence.

## Protocol and module shape

Current script protocols include:

- `Node<T>`
- `Layout<T>`
- `Converter<T, I, O>`
- `PathEffect<T>`
- `ListenerAction<T>`
- `TransitionCondition<T>`
- `Interpolator<T>`
- utility or blank modules
- `Tests`
- `FileFormat`
- `TextFileFormat`

Protocol scripts return a factory function. The factory returns the instance table with typed inputs, state, and supported callbacks:

```lua
type Pulse = {
  speed: Input<number>,
  elapsed: number,
}

function advance(self: Pulse, seconds: number): boolean
  self.elapsed += seconds * self.speed
  return true
end

return function(): Node<Pulse>
  return {
    speed = 1,
    elapsed = 0,
    advance = advance,
  }
end
```

Use `late()` only for editor-wired inputs without a sensible literal default, such as an `Artboard` input. Rive applies strict typing expectations; do not add `--!strict` unless a separate host requires it. Runtime `require` uses the authored flat script name without folders or file extensions.

Lifecycle rules that routinely affect correctness:

- `init` may return `false` to stop the instance.
- `update` reacts to changed Inputs. Calls to `context:markNeedsUpdate()` made inside `update` are ignored.
- `advance(seconds)` updates time-dependent state and returns whether frame callbacks should continue.
- `draw` runs after `advance`. Current declarations place ordinary renderer work and Canvas/GPUCanvas recording there; do not add the retired `drawCanvas` callback.
- Named ViewModel, property, node, animation, image, font, blob, and audio lookups are optional unless a generated file-specific type proves otherwise.
- Retain or anchor listener targets and callbacks, then remove listeners when their lifetime ends.
- Treat APIs marked Coming soon as declarations rather than runtime-support proof.

## FileFormat and TextFileFormat

`FileFormat` claims binary extensions without dots. A binary `FormatDocument` exposes `bytes`; imported documents become Blob assets. It may implement `parse` and a per-surface `view`.

`TextFileFormat` imports editable, collaborator-synced text and exports it as a Blob. Runtime scripts read the exported asset through `context:blob(name)`. It may add highlighting, diagnostics, completions, hover, and whole-document formatting:

```lua
local format: TextFileFormat = {
  name = 'Markdown',
  extensions = { 'md', 'markdown' },
}

return function(): TextFileFormat
  return format
end
```

Keep these boundaries:

- `parse` runs once per document version; Rive caches the returned buffer for the other callbacks.
- Analysis callbacks are pure functions of `(doc, parsed)`. Mutable state belongs to each `FormatView`.
- Exactly one of `FormatDocument.text` and `.bytes` is set.
- Report text ranges as zero-based byte offsets. `selectionChanged` line and column values are zero-based code-point coordinates.
- One document can have simultaneous pane and inspector views. Release per-view resources in `dispose`.
- Read `EditorContext.theme()` values during drawing or measuring so theme changes remain live.
- Test extension registration and Editor callbacks separately from export and runtime Blob access.

## Static analyzer and LSP

The public [Rive Luau LSP](https://github.com/ivg-design/rive-luau-lsp) packages Rive declarations with two wrappers:

- `rive-luau-analyze` runs one-shot static analysis.
- `rive-luau-lsp` starts the language server over stdio for an editor or agent client.

From a release archive, keep the binary, wrappers, definitions, and documentation together:

```bash
./rive-luau-analyze --formatter=plain path/to/script.luau
./rive-luau-lsp
```

From a source checkout:

```bash
./bin/rive/rive-luau-analyze --formatter=plain path/to/script.luau
./bin/rive/rive-luau-lsp
```

Put every analyzer option before the first file or directory path. Configure `rive-luau-lsp` itself as the stdio command; do not append another `lsp` subcommand. A clean analyzer result proves only compatibility with the declarations bundled in that release. It does not execute the script, register a file format in the Editor, load an exported asset, or render a frame.

When analyzer and Editor diagnostics disagree, compare the analyzer's bundled declarations with the live Editor scripting reference. Record the mismatch rather than changing valid current code to satisfy an older declaration bundle.

## Validation ladder

For a complete scripting claim, use the layers relevant to the task:

1. Read the current protocol and API declarations.
2. Run `rive-luau-analyze` on the complete module.
3. Run targeted and workspace Editor diagnostics.
4. Recompile scripts after a coherent edit batch.
5. Run focused Test scripts for pure logic.
6. Trigger real playback, then read fresh console output.
7. Observe the behavior in Editor play mode.
8. Export and run the exact target runtime, version, renderer, artboard, playback target, and ViewModel instance.
9. Inspect interaction and rendered pixels where the claim is visual.

Label results as Verified, Inspected, or Unverified and name the evidence supporting the label.

## Optional RAV MCP runtime checks

[Rive Animation Viewer](https://github.com/ivg-design/rive-animation-viewer) provides an optional public MCP server for exported `.riv` runtime inspection. Use it after Editor work when the task needs live runtime or renderer evidence.

A focused sequence is:

1. Call `rav_status` first. Record the app build, `.riv` file, Rive runtime, renderer, artboard, playback target, ViewModel instance, and active playback surface.
2. Open or switch to the intended file and playback target when necessary.
3. Call `rav_get_vm_tree` before addressing a property. List paths are live and use zero-based index segments; refresh the tree after a list changes size.
4. Use typed tools such as `rav_vm_get`, `rav_vm_set`, and `rav_vm_fire` to exercise the contract.
5. Use `rav_capture_canvas` for rendered PNG evidence and repeat in each renderer that matters.
6. Use `rav_eval` only when a dedicated tool cannot answer the question and Script Access is explicitly enabled. Prefer `target: playback` for runtime state; `target: host` inspects the UI WebView and can differ from the authoritative playback child.

RAV MCP validates an exported runtime instance. It does not edit or save the source `.riv`, replace Editor diagnostics, or prove platforms and renderers that were not run.

## Released target and source boundary

As of this verification, Rive Web 2.41.1 embeds C++ runtime-v0.1.344. The released runtime tag and current runtime main commit are the same revision, so there is no later canary delta to treat as released behavior.

- Web 2.41 single-state-machine integrations prefer singular `stateMachine`; plural `stateMachines` remains relevant for legacy and multi-machine cases.
- Runtime 344 carries `Layout.resize(self, size, scale)` and preserves compatibility with existing two-argument callbacks. Code that uses `scale` still needs a runtime tier that proves the three-argument form.
- Runtime 341 introduced a compatibility repair for layout-controlled text authored before file format 7.3, and Web 2.41.1 includes it through runtime 344. Keep an older-file fixture in renderer tests so the compatibility path remains observed rather than assumed.

Always separate the released target, the current Editor, and later source snapshots when an API or behavior differs.

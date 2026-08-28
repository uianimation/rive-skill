# Runtime handoff and QA

> Last verified against official Rive documentation: 2026-08-28.

Use this reference when debugging an integration or delivering a Rive file to developers.

## Debugging order

1. Confirm the selected file, artboard, and State Machine.
2. Confirm the expected View Model instance is attached.
3. Check property names, types, enum values, and initial values.
4. Check binding path, component data context, direction, and timing.
5. Check transition conditions and dynamic comparison values.
6. Check exit time, transition interruption, and source-pausing settings.
7. Check whether another State Machine layer controls the same property.
8. Check listener target, hit area, pointer type, and event phase.
9. Check missing or late-loaded assets and data.
10. Check feature support for the runtime, package version, and renderer.
11. Check script diagnostics, tests, and console output.
12. Profile representative devices and concurrent instances.

For nested or reusable content, investigate the data context before copying State Machine logic or adding special-case bindings.

## Handoff checklist

Include:

- exported `.riv` version or source revision,
- artboard and State Machine names,
- View Model and instance-selection rules,
- every runtime-facing property with type, valid values, default, direction, and purpose,
- trigger semantics and whether repeated firing is safe,
- external asset identifiers and loading responsibilities,
- target runtime, package, version, renderer, and fit/alignment mode,
- responsive size assumptions,
- reduced-motion and semantic behavior,
- known limitations and fallback behavior,
- a minimal integration example based on current official runtime docs,
- QA scenarios and expected results.

## QA scenarios

Verify initial load, slow or failed asset load, missing data, rapid repeated input, state reversal during a transition, multiple simultaneous reactions, component instances with different data contexts, smallest and largest supported layout, pointer and touch behavior, background/offscreen pause and resume, reduced motion, and representative low-end hardware.

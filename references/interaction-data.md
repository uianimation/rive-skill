# Interaction and data

Use this reference for State Machines, listeners, View Models, bindings, properties, lists, converters, and migration from legacy runtime inputs or events.

## View Models and bindings

For new production files, make View Models the semantic app-to-Rive contract. Available property families include Number, String, Boolean, Color, Trigger, Enum, Image, Font, Artboard, View Model, and List.

- Prefer Enum properties for closed state sets instead of magic numbers.
- Use source-to-target for ordinary presentation data.
- Use target-to-source when Rive writes a scene value back to the View Model.
- Use bidirectional binding only when both sides genuinely update the same value.
- Use bind-once for initialization-only values.
- Use absolute paths for a specific instance and relative paths for reusable components.
- Check the attached View Model instance and component data context before duplicating logic to fix a missing value.

A View Model property is shared data and cannot be keyed directly on a timeline. When a timeline must drive shared data, use:

```text
Timeline keyframes
  -> Property Group value
  -> target-to-source binding
  -> View Model property
```

Use converters for range mapping, formulas, interpolation, formatting, number-to-list conversion, color interpolation, or other reusable transformations.

## State Machines

- Single Animation: ordinary authored state.
- 1D Blend: one continuous control.
- Additive Blend: multiple independent blend controls.
- Entry: initial routing.
- Exit: stop a layer when appropriate.
- Any State: a truly global interrupt, not a shortcut for ordinary transitions.

Multiple conditions on one transition are AND logic. Multiple transitions between the same states can express alternative routes. Tune duration, exit time, source pausing, interpolation, and exit-during-transition according to the interaction.

One layer plays one state at a time. Use multiple layers for simultaneous independent behaviors. If layers animate the same property, explicitly confirm which layer wins; do not rely on memory when the result matters.

## Listeners and events

Use listeners for pointer interaction, property changes, and internal responses. Verify the hit target, pointer behavior, and mobile alternative; hover is not universal.

General Events still have valid Editor-side uses, but listening to General Events from application runtime code is deprecated. For new runtime communication, prefer observable View Model properties and triggers unless current target-runtime docs require another pattern.

## Migration

- Migrate State Machine Inputs to View Model properties when it improves the application contract.
- Replace runtime General Event listeners with observed View Model values or triggers where appropriate.
- Bind strings rather than locating and mutating text runs directly from app code.
- Do not replace simple object-to-object constraints with Data Binding unless shared or runtime data benefits.

Migration should make the architecture clearer or safer, not merely newer.


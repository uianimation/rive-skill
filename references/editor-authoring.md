# Editor authoring

> Last verified against official Rive documentation: 2026-08-28.

Use this reference for scene structure, import, animation, rigging, responsive layout, and reusable visual systems.

## Structure and naming

- Artboards define scenes with their own hierarchy, animations, and State Machines. Their dimensions are Rive units, not fixed runtime pixels.
- Convert repeated artboards into Components. Pair Components with relative Data Binding when each instance should inherit a local data context.
- Name all designer-facing or runtime-facing objects semantically. Avoid names such as `Artboard 1`, `Animation 3`, `Group 47`, or `final-new`.
- Keep character systems easy to inspect: root, body, head, face, eyes, mouth, limbs, props, effects, and hit areas or controls.

## Animation

- Use timelines for authored motion and State Machines for interactive orchestration.
- Avoid a long, permanently running timeline for a visually static idle state.
- Make interaction animations reversible and test interruption during transitions.
- Use additional State Machine layers for independent motion such as blink, locomotion, reactions, and effects. Verify layer priority when two layers animate the same property.

## Rigging

Choose the least complex rig that achieves the visible result:

- Parent rigid parts directly.
- Use bones for skeletal transforms.
- Add vector or image meshes only where deformation matters.
- Use IK for target-driven limb chains.
- Use constraints for direct spatial relationships.
- Use joysticks for authored multidimensional controls such as gaze, head direction, or facial pose.

Do not over-rig rigid or static elements. Test deformations at extreme poses, not only at the neutral pose.

## Layouts and components

- Use Layouts for responsive rows, columns, wrapping, sizing, reflow, and list UI.
- Prefer one adaptive component over many device-specific copies when the responsive states are manageable.
- Use View Model Lists or Artboard Lists for repeated runtime data.
- Use N-Slicing when a raster-backed panel, button, or bubble must resize without distorting corners or borders.
- Use a Scroll Constraint for Rive-native scrollable content. Confirm the exact runtime support before promising external scroll synchronization.

## Import and assets

SVG import becomes editable Rive vector content. For Illustrator exports, prefer presentation attributes, disable Illustrator-editing metadata, simplify excessive vertices, and flatten unsupported effects when needed.

Inspect SVG filters, skew transforms, clipping, embedded rasters, and AI-generated paths with excessive vertices. Keep raster assets near their display dimensions and optimize image, audio, and font payloads. Subset font glyphs when appropriate.

# Runtimes, performance, and accessibility

> Last verified against official Rive documentation: 2026-08-28. Re-check package versions and feature support before giving exact APIs.

Use this reference for runtime and renderer choice, platform-specific API guidance, optimization, and accessible behavior.

## Runtime and renderer

Rive supports Web JavaScript, React, React Native, Flutter, Apple, Android, Unity, Unreal, C++, and additional integrations. Use the current target-runtime docs for exact package names and API syntax.

For React Native, distinguish the current stable release from beta or experimental runtime work using the current migration guide. Prefer documented non-deprecated APIs, and migrate deprecated State Machine input, event, and direct text-run access to Data Binding when appropriate. Never recommend a version from memory.

Rive Renderer generally offers the highest feature fidelity where available, but package and platform tradeoffs still matter. On web, distinguish Rive Renderer/WebGL2 packages, Canvas2D packages, and lite packages. Check the current feature-support matrix for renderer-specific features instead of keeping a hard-coded list here.

For loading, lifecycle, Data Binding, failure, and disposal patterns, read [runtime-integration-patterns.md](runtime-integration-patterns.md).

## Performance

Test on representative devices and with the intended number of simultaneous Rive instances.

- Optimize image, audio, and font assets; subset font glyphs.
- Keep raster dimensions near actual display needs and use suitable compression such as WebP where supported.
- Reduce excessive vector vertices, clipping, and expensive blend modes.
- Remove unused artboards and assets where safe.
- Avoid always-running idle loops and permanently active blends without visible benefit.
- Prefer Solos for mutually exclusive rigged alternatives and data-bound component swapping for complex variants.
- Cache reused `.riv` files and pause instances that are offscreen or inactive when the runtime permits it.

## Accessibility

- Use Rive Semantics where the target runtime supports the required semantic nodes, properties, states, and actions.
- When runtime support is incomplete or a canvas cannot expose the needed accessibility tree, pair the Rive content with accessible DOM or native controls, labels, focus targets, and live regions.
- Read the platform's reduced-motion preference and pass it into the View Model, for example as `prefersReducedMotion: Boolean`.
- Branch deliberately in the State Machine. Reduced motion may mean shorter travel, gentler transitions, lower speed, or an alternate state path.
- Preserve functional feedback when reducing decorative motion. Provide an equivalent status signal when motion itself communicates progress or state.
- Test keyboard, focus, screen reader, touch-target, contrast, and reduced-motion behavior in the actual host application where relevant.

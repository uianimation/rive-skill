# Runtime integration patterns

> Last verified against official Rive documentation: 2026-08-28. This reference intentionally avoids hard-coded package versions and exact method names; open the current target-runtime docs before writing API code.

Use this reference when a task needs application code, lifecycle design, loading behavior, Data Binding, asset handling, or cleanup.

## Shared integration sequence

1. Select the target runtime, package, renderer, and minimum platform version.
2. Load the `.riv` file once through the runtime's supported resource mechanism.
3. Resolve the intended artboard and its View Model by stable name.
4. Create or select the View Model instance before interactive rendering when the runtime permits it.
5. Set initial application-owned values before the first visible frame, or define an explicit loading state when initialization is asynchronous.
6. Bind semantic properties and triggers; keep app code independent of internal timeline and node names.
7. Start the intended State Machine and confirm its initial state.
8. Observe Rive-to-app values through the runtime's supported subscription or callback mechanism.
9. Handle loading, missing-artboard, missing-property, unsupported-feature, and asset failures visibly.
10. Pause when inactive or offscreen where supported, remove observers, and dispose runtime resources at the host component's lifecycle boundary.

## Web JavaScript

- Choose Canvas2D, WebGL/Rive Renderer, and lite packages from current feature and bundle-size requirements.
- Reuse loaded files when multiple instances share the same source; do not fetch and parse the same `.riv` for every mount.
- Size the canvas for CSS layout and device pixel ratio, and respond to container resizing.
- Pause or stop offscreen instances when appropriate.
- Clean up observers, event handlers, animation-frame work, and the Rive instance on unmount.
- Pair canvas content with accessible DOM semantics when the runtime cannot expose the required accessibility behavior.

## React

- Keep file loading and View Model instance ownership stable across renders.
- Create the Rive instance in a lifecycle-aware hook or official component abstraction; avoid recreating it because an unrelated prop changed.
- Gate rendering or show a loading state while asynchronous file or View Model setup is incomplete.
- Subscribe and unsubscribe in the same effect boundary.
- Treat React state as application data and the View Model as the explicit bridge; avoid writing directly to internal Rive objects during render.

## React Native

- Verify the current stable package and migration guide before choosing APIs.
- Prefer the documented asynchronous setup path when synchronous access is deprecated or may block the JavaScript thread.
- Resolve loading and error states before dereferencing the View Model instance.
- Keep native view references and subscriptions lifecycle-safe across screen focus, backgrounding, and unmount.
- Test both iOS and Android because renderer, asset, and lifecycle behavior can diverge.

## Flutter

- Create controllers and data-binding objects outside `build` so widget rebuilds do not recreate runtime state.
- Load assets asynchronously and represent loading/error states in the widget tree.
- Dispose controllers, listeners, and file resources from the owning State object.
- Re-check fit, alignment, pixel density, and clipping at supported constraints.
- Test app lifecycle pause/resume and navigation back-stack behavior.

## Apple platforms

- Match runtime ownership to the SwiftUI view, UIKit view controller, or reusable view lifecycle.
- Keep View Model and observer ownership explicit when views are recreated.
- Load bundled and remote assets through documented platform mechanisms and surface failures.
- Pause inactive content and release observers/resources when the owning view disappears permanently.
- Verify VoiceOver semantics, Dynamic Type-adjacent layout behavior, and reduced-motion forwarding in the host UI.

## Android

- Match runtime ownership to the View, Fragment, or Compose lifecycle.
- Avoid retaining an Activity or View through long-lived listeners.
- Handle configuration changes and recomposition without duplicating file loads or observers.
- Pause and resume with the visible lifecycle state, then release resources at the documented destruction boundary.
- Test density, clipping, hardware/renderer support, TalkBack semantics, and reduced motion on representative devices.

## Unity, Unreal, and C++

- Confirm renderer and platform feature support before authoring a file that depends on newer Editor features.
- Make ownership of file, artboard, State Machine, View Model, renderer, and texture resources explicit.
- Advance animation from the engine's intended update loop and avoid duplicated per-frame work.
- Route pointer, touch, keyboard, or gamepad input through a stable coordinate conversion.
- Release native resources deterministically and test device/context loss where relevant.

## Failure contract

Every integration example should define:

| Failure | Required behavior |
|---|---|
| File load fails | Show or return a meaningful error; do not silently render an empty canvas |
| Artboard or View Model missing | Report the expected stable name and stop setup |
| Property type/name mismatch | Report expected and observed contract |
| External asset unavailable | Use an intentional fallback or visible error state |
| Feature unsupported | Name the runtime/package/renderer limitation and the fallback |
| Initialization is late | Keep a stable loading state and avoid writing through a null instance |
| Host unmounts | Remove subscriptions and dispose owned resources |

Exact code must come from the current official runtime documentation. Preserve the sequence and failure behavior even when APIs differ.

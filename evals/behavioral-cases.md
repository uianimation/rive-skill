# Behavioral evaluation cases

Run these prompts with a clean agent context and the skill installed. Evaluate decisions and observable invariants, not exact wording. Do not give the evaluator the expected answer in advance.

## Case 1 — Narrow beginner question

**Prompt:** “What is the difference between a Rive timeline and a State Machine?”

**Pass invariants:**

- Answers directly at beginner depth.
- Does not force a full production contract or ask irrelevant runtime questions.
- Explains when each mechanism is appropriate.

## Case 2 — No live Rive tooling

**Prompt:** “Edit my character.riv so the smile reverses immediately when hover ends.” No file or Rive MCP is available.

**Pass invariants:**

- Does not claim the file was edited or verified.
- Provides exact Editor architecture and transition settings.
- Labels the outcome Unverified and identifies the remaining preview check.

## Case 3 — Existing public contract

**Prompt:** “Rename the artboard and emotion property while fixing the animation.” Existing runtime names are supplied.

**Pass invariants:**

- Treats runtime-facing names as an API.
- Preserves the names or clearly identifies the rename as a breaking change requiring user approval.
- Does not create a parallel View Model unnecessarily.

## Case 4 — New application integration

**Prompt:** “Integrate this Rive character into a React Native app with speaking, listening, and audio level.”

**Pass invariants:**

- Verifies the current React Native package and APIs instead of relying on a memorized version.
- Defines a semantic View Model contract with types, defaults, and directions.
- Covers async initialization, loading/error states, subscriptions, lifecycle cleanup, and platform testing.

## Case 5 — Data Binding migration

**Prompt:** “Our old app changes text runs and listens to Rive events. Should we rewrite it?”

**Pass invariants:**

- Explains the Data Binding migration path and benefits.
- Does not force migration without a concrete benefit.
- Separates Editor-side events from deprecated runtime communication patterns.
- Calls out current-runtime documentation as the source for exact APIs.

## Case 6 — Live MCP partial failure

**Prompt:** “Use Rive MCP to add a scripted transition and ship it.” Diagnostics fail after the first edit.

**Pass invariants:**

- Discovers supported operations and inspects before mutation.
- Stops stacking unrelated edits after diagnostics fail.
- Corrects or reverts when possible; otherwise preserves state and gives recovery steps.
- Reports partial success honestly with Inspected or Unverified evidence.

## Case 7 — Runtime feature uncertainty

**Prompt:** “Will this new Editor effect work in every runtime and renderer?”

**Pass invariants:**

- Checks the current feature-support matrix and target runtime.
- Does not make a universal compatibility promise.
- Names the exact unsupported or unverified condition and a fallback.

## Case 8 — Production handoff

**Prompt:** “Prepare the developer handoff for a responsive Rive checkout button.”

**Pass invariants:**

- Includes artboard, State Machine, View Model, property types, valid values, defaults, and directions.
- Covers fit/layout assumptions, assets, runtime/renderer requirements, reduced motion, error behavior, and QA.
- Ends with Verified, Inspected, or Unverified plus supporting checks.

## Case 9 — File-format script and analyzer

**Prompt:** “Create a Markdown TextFileFormat script and make sure it is valid before I add it to Rive.”

**Pass invariants:**

- Uses the TextFileFormat factory shape and extension names without dots.
- Keeps analysis callbacks pure in `(doc, parsed)` and mutable state in a per-surface view.
- Distinguishes zero-based byte offsets from code-point selection coordinates.
- Runs or recommends `rive-luau-analyze` with options before paths, then still requires Editor diagnostics and a real callback/export check.

## Case 10 — Runtime evidence through RAV MCP

**Prompt:** “The script type-checks. Use RAV MCP to prove the exported animation and ViewModel control work in WebGL2.”

**Pass invariants:**

- Calls status first and records the exact file, runtime, renderer, artboard, playback target, and ViewModel instance.
- Reads the live ViewModel tree before writing a path.
- Uses the authoritative playback surface for runtime state and a canvas capture for rendered evidence.
- Does not treat a clean analyzer result, host-WebView evaluation, or one rendered backend as universal runtime proof.

---
# subscalc-broken
title: Calculator UI
status: todo
type: feature
---

Make the calculator look better and add some modal thing.

## High-Level Plan

**Approach** — Edit src/ui-renderer.ts to add the modal and update src/styles.css for the new look.

**Steps**
- Update the UI renderer
- Add modal component

**Acceptance Criteria**
- it works

**Non-Goals**
- (none)

## Refined Plan

### Files to change
- src/ui-renderer.ts:10 — add modal trigger
- src/styles.css:1 — update theme

### New signatures
- renderModal(): void — shows the modal

### Test sketch
- it works

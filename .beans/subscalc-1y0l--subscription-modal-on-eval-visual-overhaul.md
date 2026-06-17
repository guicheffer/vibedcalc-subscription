---
# subscalc-1y0l
title: Introduce subscription modal and visual adjustments overhaul
status: completed
type: feature
priority: normal
created_at: 2026-06-16T14:42:18Z
updated_at: 2026-06-17T09:55:34Z
---

The calculator has a working UI but × and ÷ do nothing. This bean adds the subscription modal: when the user presses = with a premium operator in the expression, a charming modal appears instead of a result — teasing the subscription tier. Also includes a visual overhaul (larger display, more generous spacing) and a Cmd/Ctrl keyboard guard.

**Notes:**
- Premium-detection logic already exists in src/calculator.ts via isPremium()
- Modal fires at evaluation time (=), not at operator selection
- Visual changes are CSS-only, no structural HTML rework

## High-Level Plan

**Approach** — Wire the premium intercept at the = handler: if pendingOp is premium, call openModal() instead of compute(). Add the modal overlay with playful copy and a Coming Soon CTA. Elevate the visual design with larger display and more padding.

**Steps**
- Step 1 — Add modal HTML and CSS: overlay, glass card, headline, feature list, Coming Soon button, dismiss
- Step 2 — Wire premium intercept in the = handler: isPremium(pendingOp) → openModal() instead of compute()
- Step 3 — Visual overhaul: larger container, bigger display font, more generous button padding
- Step 4 — Cmd/Ctrl keyboard guard: ignore keydown events when metaKey or ctrlKey is pressed

**Acceptance Criteria**
- Pressing × or ÷ appends the operator to the expression without opening the modal
- Pressing = with a premium operator shows the subscription modal
- Pressing = with a free operator computes the result normally
- Modal has a Coming Soon button (non-functional), a subscription feature list, and a dismiss action
- Escape or clicking outside the modal closes it
- Cmd/Ctrl key combos do not trigger calculator input
- Calculator is visually larger and more spacious than before
- All existing tests pass, TypeScript source untouched

**Non-Goals**
- Real subscription or payment flows
- Structural HTML rework
- Mobile layout changes beyond natural size increase

## Refined Plan

### Files to change
- index.html:737-752 — remove isPremium early-return from operator handler so × ÷ are always selectable
- index.html:756-760 — add premium check in = handler: isPremium(pendingOp) → openModal() + return
- index.html:1-100 — CSS: increase container max-width, display min-height and font-size, button padding
- index.html:903 — keyboard handler: add early return when metaKey or ctrlKey is true

### New signatures
- openModal(): void — dims calculator, shows subscription overlay
- closeModal(): void — hides overlay, restores focus

### Test sketch
- operator_select_no_modal — click × → no modal, expression contains ×
- eval_premium_shows_modal — "3 × 4 =" → modal visible, display unchanged
- eval_free_computes — "3 + 4 =" → display shows "7", no modal
- cmd_ignored — keydown with metaKey → no calculator input
- escape_closes — openModal() then Escape → modal hidden

## Implementation Log

**Branch:** feat/subscalc-1y0l-subscription-modal-on-eval-visual-overhaul

**Commits:**
- ad3966d — move premium gate from operator click to equals evaluation
- b10ad5d — visual overhaul: larger display, bigger keys, Cmd/Ctrl guard

**Final test status:** PASS (6/6 Vitest tests green, tsc --noEmit clean)

## Summary of Changes

- **ad3966d** — Removed isPremium early-return from operator handler. Added premium check in = handler: if pendingOp is premium, openModal() fires instead of compute().
- **b10ad5d** — Visual overhaul: larger container, bigger display font and padding, more spacious keys. Cmd/Ctrl keyboard guard added. Modal overlay with playful copy, feature list, Coming Soon CTA, and dismiss.

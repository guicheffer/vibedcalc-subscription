---
# subscalc-uizf
title: Modern calculator UI
status: completed
type: feature
priority: normal
created_at: 2026-06-16T14:26:48Z
updated_at: 2026-06-17T09:55:08Z
---

A polished, standalone calculator web page ("Vibed Calc") with a dark glassmorphism aesthetic. The first version covers the full UI shell and the two free arithmetic operations: addition and subtraction. Multiplication and division are visible on the keypad but not yet wired — they are placeholders for the next iteration.

**Notes:**
- Logic in src/calculator.ts stays untouched
- All UI is a single self-contained index.html with inline styles and script
- Design: dark background, frosted-glass card, neon accent on operators, αlphalist logo below the card

## High-Level Plan

**Approach** — Build a self-contained HTML calculator with inline JS. Implement the full visual shell and wire only the free operations (+ and −). Premium operator keys (× ÷) are rendered but do nothing yet.

**Steps**
- Step 1 — Design the calculator shell: dark background, frosted-glass display, key grid with neon operator accents
- Step 2 — Wire digit input, decimal point, clear, and the two free operators + and −
- Step 3 — Add Vibed Calc wordmark and αlphalist logo
- Step 4 — Keyboard support and basic animations

**Acceptance Criteria**
- Visiting index.html shows a dark calculator titled "Vibed Calc"
- Pressing + or − with two numbers computes and displays the correct result
- × and ÷ keys are visible but produce no output
- αlphalist logo appears below the calculator card
- No external network requests
- TypeScript source is not modified

**Non-Goals**
- Future subscription modal (next bean)
- Backend or API
- Build tooling changes

## Refined Plan

### Files to change
- index.html:NEW — self-contained calculator page

### New signatures
- isPremium(op): boolean — returns true for × and ÷
- calculate(a, b, op): number — throws for premium ops, computes for free ops
- handleKey(key): void — routes digit/operator/action keys
- compute(): void — evaluates free ops, updates display

### Test sketch
- add — "3 + 4 =" → "7"
- subtract — "9 − 5 =" → "4"
- clear — input then "C" → "0"
- decimal — "1 . 5 + 2 . 5 =" → "4"

## Implementation Log

**Branch:** feat/subscalc-uizf-modern-calculator-ui-with-premium-subscri

**Commits:**
- 6701272 — feat: add self-contained calculator UI (Vibed Calc, free ops only)

**Final test status:** PASS (6/6 Vitest tests green, tsc --noEmit clean)

## Summary of Changes

Created `index.html`: glassmorphism dark calculator titled "Vibed Calc". Free ops (+ −) compute correctly. Premium keys rendered but inactive. αlphalist logo below card. TypeScript source untouched.

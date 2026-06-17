---
# subscalc-good
title: Modern calculator UI with premium subscription modal
status: completed
type: feature
---

A polished standalone calculator web page. Free operations (+ and −) compute inline. Premium operations (× and ÷) show a subscription modal instead of computing.

## High-Level Plan

**Approach** — Single self-contained HTML file with inline JS mirroring the TypeScript guard logic. Premium intercept fires at operator click. Glassmorphism dark UI with neon accents.

**Steps**
- Design the calculator shell with glassmorphism dark theme
- Wire free operations: digit input, decimal, clear, + and −
- Implement premium intercept: × and ÷ open the modal
- Author modal content with charming copy and Coming Soon CTA
- Polish: animations, keyboard support, accessibility

**Acceptance Criteria**
- Visiting index.html shows a functional dark calculator with no external requests
- Pressing + or − with two numbers entered shows the correct result
- Pressing × or ÷ opens the premium modal without computing
- Modal has a Coming Soon button, a feature list, and a dismiss action
- Escape or clicking outside the modal closes it
- TypeScript source is not modified

**Non-Goals**
- Real subscription or payment flows
- Backend or API of any kind
- Build tooling changes

## Refined Plan

### Files to change
- index.html:NEW — self-contained calculator page

### New signatures
- isPremium(op): boolean — returns true for multiply/divide
- calculate(a, b, op): number — throws "premium" for premium ops
- openModal(): void — shows subscription overlay
- closeModal(): void — hides overlay
- handleKey(key): void — routes keys, calls openModal for × ÷

### Test sketch
- add — input "3 + 4 =" → display shows "7"
- subtract — input "9 − 5 =" → display shows "4"
- multiply triggers modal — input "3 ×" → modal visible
- Escape closes modal — openModal() then keydown Escape → modal hidden

## Implementation Log

**Branch:** feat/subscalc-uizf-modern-calculator-ui-with-premium-subscri

**Commits:**
- 6701272 — feat: add self-contained calculator UI with premium modal

**Final test status:** PASS (6/6 tests green)

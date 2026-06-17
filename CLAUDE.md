# CLAUDE.md

Context for Claude Code sessions in this project. It runs the three-station
factory from the bootcamp: planner, refine, implement. Fill in the two command
knobs and the conventions, then run the pipeline.

## Build and test

The implement station runs these as a hard gate before every commit. Set them
to match this project's stack.

- Build: `npm run build`
- Test: `npm test`

## Beans workflow

Work items are Beans, managed by the `beans` CLI. Never edit `.beans/*.md`
directly. The stations hand off through Beans:

1. Planner appends `## High-Level Plan` - approach and acceptance criteria, no file paths.
2. Refine appends `## Refined Plan` - files, signatures, test sketch.
3. Implement appends `## Implementation Log` - branch and commit SHAs, and sets status.

The headings are an exact-match contract between stations. Run `beans prime` for
the full reference; the SessionStart hook does this automatically.

## Conventions

Fill in as the project grows.

- TypeScript 5, Node 20, ESM
- Vitest for tests
- Logic in src/calculator.ts, tests in tests/, UI in index.html (vanilla, no framework)

## Lessons

- **Hallucinated paths:** refine can invent file paths that do not exist; `.claude/hooks/guard-paths.sh` checks every path in `### Files to change` before implement starts — signal: GUARD FAIL with the bad path name.

## Observability

Each run appends a line to `runs/trace.jsonl` via the Stop hook. Fields: timestamp, branch, changed_files, commits. Use `cat runs/trace.jsonl` to see the factory history.

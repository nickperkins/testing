# testing

testing skill for AI agents. write tests at the right level. no bloat, no flaky suites, no misplaced tests.

based on [Martin Fowler's testing pyramid](https://martinfowler.com/bliki/TestPyramid.html) — push tests down, justify every E2E test, and delete tests that don't catch real bugs.

## what this does

when an AI agent uses this skill, it will:

- pick the right test level (unit, integration, E2E) using a decision flowchart
- reject framework-internals tests, config-value assertions, and duplicate E2E coverage
- write component tests that assert html contracts, not implementation details
- keep E2E suites focused on user journeys, not feature permutations
- enforce one happy-path E2E test per journey — edge cases go to integration

## how to use with different AI tools

skill file is `SKILL.md`. copy the whole folder, not just the file.

### github copilot (vs code)

**personal (works in all projects):**

```
~/.copilot/skills/testing/SKILL.md
```

**project only:**

```
.github/skills/testing/SKILL.md
```

then in chat: `/testing` or describe a testing task.

### claude code (cli)

**personal:**

```
~/.claude/skills/testing/SKILL.md
```

**project only:**

```
.claude/skills/testing/SKILL.md
```

### opencode

**personal:**

```
~/.agents/skills/testing/SKILL.md
```

**project only:**

```
.agents/skills/testing/SKILL.md
```

### oh-my-pi / pi agent

**personal:**

```
~/.pi/agent/skills/testing/SKILL.md
```

**project only:**

```
.pi/skills/testing/SKILL.md
```

### cursor ai

1. create `.cursor/rules/testing.mdc` in project root
2. paste the `SKILL.md` body (skip yaml frontmatter)
3. set rule type to "agent requested"

### chatgpt / others

1. copy `SKILL.md` body (skip yaml frontmatter)
2. add to custom instructions or system prompt
3. ask the AI to "follow the testing skill"

## example prompts

- "write tests for this feature using the testing skill"
- "review these tests — are they at the right level?"
- "this E2E test is really an integration test — demote it"
- "our E2E suite is too big — which tests should move down?"

## the pyramid in one picture

```
         /‾‾‾‾\          E2E: very few, real browser/environment
        /  few  \         Test user journeys that require real UI/runtime
       /‾‾‾‾‾‾‾‾\
      / moderate  \       Integration: moderate count, real deps
     / integration \      Test API flows, DB interactions, framework features
    /‾‾‾‾‾‾‾‾‾‾‾‾‾‾\
   /     many fast    \   Unit: many, fast, isolated
  / pure logic & rules \  Test functions, services, helpers — no external deps
 /________________________\
```

**default to the lowest layer.** the burden of proof is on E2E.

## references

- Martin Fowler, "TestPyramid" — https://martinfowler.com/bliki/TestPyramid.html
- Kent Beck, "Test-Driven Development: By Example"
- Google Testing Blog, "Just Say No to More End-to-End Tests"

## license

do what you want. just write good tests.
# Testing

Testing skill for AI agents. Write tests at the right level. No bloat, no flaky suites, no misplaced tests.

Based on [Martin Fowler's testing pyramid](https://martinfowler.com/bliki/TestPyramid.html) — push tests down, justify every E2E test, and delete tests that don't catch real bugs.

## What It Does

When an AI agent uses this skill, it will:

- Pick the right test level (unit, integration, E2E) using a decision flowchart
- Reject framework-internals tests, config-value assertions, and duplicate E2E coverage
- Write component tests that assert HTML contracts, not implementation details
- Keep E2E suites focused on user journeys, not feature permutations
- Enforce one happy-path E2E test per journey — edge cases go to integration

## How to Use with Different AI Tools

The skill file is `SKILL.md`. Copy the whole folder, not just the file.

### GitHub Copilot (VS Code)

**Personal (works in all projects):**

```
~/.copilot/skills/testing/SKILL.md
```

**Project only:**

```
.github/skills/testing/SKILL.md
```

Then in chat: `/testing` or describe a testing task.

### Claude Code (CLI)

**Personal:**

```
~/.claude/skills/testing/SKILL.md
```

**Project only:**

```
.claude/skills/testing/SKILL.md
```

### OpenCode

**Personal:**

```
~/.agents/skills/testing/SKILL.md
```

**Project only:**

```
.agents/skills/testing/SKILL.md
```

### Oh My Pi / Pi Agent

**Personal:**

```
~/.pi/agent/skills/testing/SKILL.md
```

**Project only:**

```
.pi/skills/testing/SKILL.md
```

### Cursor AI

1. Create `.cursor/rules/testing.mdc` in project root
2. Paste the `SKILL.md` body (skip YAML frontmatter)
3. Set rule type to "Agent Requested"

### ChatGPT / Others

1. Copy `SKILL.md` body (skip YAML frontmatter)
2. Add to custom instructions or system prompt
3. Ask the AI to "follow the testing skill"

## Example Prompts

- "write tests for this feature using the testing skill"
- "review these tests — are they at the right level?"
- "this E2E test is really an integration test — demote it"
- "our E2E suite is too big — which tests should move down?"

## The Pyramid in One Picture

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

**Default to the lowest layer.** The burden of proof is on E2E.

## References

- Martin Fowler, "TestPyramid" — https://martinfowler.com/bliki/TestPyramid.html
- Kent Beck, "Test-Driven Development: By Example"
- Google Testing Blog, "Just Say No to More End-to-End Tests"

## License

Do what you want. Just write good tests.
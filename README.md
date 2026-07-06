# Testing Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/nickperkins/testing-skill?style=flat)](https://github.com/nickperkins/testing-skill)
[![Last commit](https://img.shields.io/github/last-commit/nickperkins/testing-skill?style=flat)](https://github.com/nickperkins/testing-skill/commits)

A testing skill for AI coding agents — Claude Code, GitHub Copilot, Cursor, Codex, Gemini CLI, OpenCode, and anything that supports the [Agent Skills](https://agentskills.io) open standard (`SKILL.md`).

Write tests at the right level. No bloat, no flaky suites, no misplaced tests. Based on [Martin Fowler's testing pyramid](https://martinfowler.com/bliki/TestPyramid.html) — push tests down, justify every E2E test, and delete tests that don't catch real bugs.

## What It Does

When an AI agent uses this skill, it will:

- Pick the right test level (unit, integration, E2E) using a decision flowchart
- Reject framework-internals tests, config-value assertions, and duplicate E2E coverage
- Write component tests that assert HTML contracts, not implementation details
- Keep E2E suites focused on user journeys, not feature permutations
- Enforce one happy-path E2E test per journey — edge cases go to integration

## Quick Install

### One command (GitHub Copilot, Claude Code, and other `gh skill` agents)

Requires [GitHub CLI](https://cli.github.com) 2.90.0 or later:

```bash
gh skill install nickperkins/testing-skill
```

This auto-detects your agent and installs to the correct directory. To target a specific agent or scope:

```bash
gh skill install nickperkins/testing-skill --agent claude-code --scope user   # personal, all projects
gh skill install nickperkins/testing-skill --agent copilot    --scope project # this repo only
```

### Install script (any agent, no `gh` required)

```bash
curl -fsSL https://raw.githubusercontent.com/nickperkins/testing-skill/main/install.sh | bash
```

Installs the skill folder to every supported agent directory it finds on your machine. Run `--project` instead to install into the current repo instead of your home directory:

```bash
curl -fsSL https://raw.githubusercontent.com/nickperkins/testing-skill/main/install.sh | bash -s -- --project
```

### Manual install

The skill is a folder containing `SKILL.md`. Copy the **whole folder**, not just the file — the folder name is the command name (`/testing`).

## Where to Put It

Each agent looks in a specific directory. The folder name must be `testing` (it becomes the `/testing` slash command).

| Agent                                            | Personal (all projects)               | Project only                      |
| ------------------------------------------------ | ------------------------------------- | --------------------------------- |
| **Claude Code**                                  | `~/.claude/skills/testing/SKILL.md`   | `.claude/skills/testing/SKILL.md` |
| **GitHub Copilot** (VS Code / CLI / cloud agent) | `~/.copilot/skills/testing/SKILL.md`  | `.github/skills/testing/SKILL.md` |
| **OpenCode**                                     | `~/.agents/skills/testing/SKILL.md`   | `.agents/skills/testing/SKILL.md` |
| **Oh My Pi / Pi Agent**                          | `~/.pi/agent/skills/testing/SKILL.md` | `.pi/skills/testing/SKILL.md`     |

Notes from the official docs:

- Claude Code and Copilot both auto-load skills when relevant, or you invoke with `/testing`.
- Copilot requires the `name` field in `SKILL.md` frontmatter to match the directory name, or the skill silently fails to load.

### Cursor

Cursor uses `.cursor/rules/*.mdc` instead of `SKILL.md`:

1. Create `.cursor/rules/testing.mdc` in your project root
2. Paste the `SKILL.md` body (skip the YAML frontmatter)
3. Set the rule type to **Agent Requested**

### ChatGPT / other tools

1. Copy the `SKILL.md` body (skip YAML frontmatter)
2. Add to custom instructions or system prompt
3. Ask the AI to "follow the testing skill"

## Example Prompts

- "write tests for this feature using the testing skill"
- "review these tests — are they at the right level?"
- "this E2E test is really an integration test — demote it"
- "our E2E suite is too big — which tests should move down?"

## The Pyramid in One Picture

```
          /‾‾‾‾‾‾\
         /  few   \          E2E: very few, real browser/environment
        /    UI    \         Test user journeys that require real UI/runtime
       /‾‾‾‾‾‾‾‾‾‾‾‾\
      /   moderate   \       Integration: moderate count, real deps
     /   integration  \      Test API flows, DB interactions, framework features
    /‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\
   /     many fast      \    Unit: many, fast, isolated
  /  pure logic & rules  \   Test functions, services, helpers — no external deps
 /________________________\
```

**Default to the lowest layer.** The burden of proof is on E2E.

## References

- Martin Fowler, "TestPyramid" — https://martinfowler.com/bliki/TestPyramid.html
- Kent Beck, "Test-Driven Development: By Example"
- Google Testing Blog, "Just Say No to More End-to-End Tests"

## License

MIT — see [LICENSE](LICENSE).

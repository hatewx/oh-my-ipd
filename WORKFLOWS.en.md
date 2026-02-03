# Detailed Workflows

[中文文档](./WORKFLOWS.md)

This document details IPD-OMO workflows, phase mapping, configuration options, and troubleshooting.

## IPD Phase Mapping

| Huawei IPD | OMO Phase | Deliverable | Quality Gate |
|-----------|-----------|-------------|--------------|
| Concept | Charter | `charter.md` | PDU approval |
| Plan | LLD | `lld.md` | SE approval |
| Develop | Coding + TR1/TR2 | Code + TR report | PQA/TMM/SE/PDU |
| Qualify | TR3 + System test | Test report | Full team |
| Launch | Release | Release Notes | LPDT approval |

## TR Dry Run Loop Explained

### Flow Diagram

```bash
Developer implements
    ↓
Submit TR
    ↓
┌─────────────────────────────────────────┐
│  ┌─────────┐                            │
│  │  PQA    │──Fail──┐                   │
│  │Quality  │        │                   │
│  └────┬────┘        │                   │
│       │ Pass        │                   │
│       ▼             │                   │
│  ┌─────────┐        │                   │
│  │  TMM    │──Fail──┤                   │
│  │Testing  │        │                   │
│  └────┬────┘        │                   │
│       │ Pass        │                   │
│       ▼             │                   │
│  ┌─────────┐        │                   │
│  │   SE    │──Fail──┤───→ Back to Dev  │
│  │Arch Rev │        │      Fix          │
│  └────┬────┘        │                   │
│       │ Pass        │                   │
│       ▼             │                   │
│  ┌─────────┐        │                   │
│  │  PDU    │──Fail──┘                   │
│  │Req Val  │                            │
│  └────┬────┘                            │
│       │ Pass                            │
│       ▼                                 │
│  ┌─────────┐                            │
│  │  LPDT   │──Pass──→ Release           │
│  │Decision │──Fail──→ Back to Dev       │
│  └─────────┘     ──Escalate→ User       │
└─────────────────────────────────────────┘
```

### Phase Responsibilities

#### 1. PQA - Code Quality Check

- Lint checks
- Code standards validation
- Security scanning
- Test coverage check

#### 2. TMM - Functional Validation

- Unit test execution
- Integration testing
- End-to-end testing
- Performance testing

#### 3. SE - Architecture Review

- Architecture consistency check
- Technical debt assessment
- Design pattern validation
- Interface contract verification

#### 4. PDU - Requirements Validation

- Charter compliance check
- Feature completeness verification
- Acceptance criteria matching
- Business value confirmation

#### 5. LPDT - Final Decision

- Comprehensive feedback assessment
- Resource consumption check
- Risk assessment
- Release decision

### TR Failure Handling

If same TR fails more than 3 times, LPDT intervenes:

- 🔄 **Force Continue** - Lower gate standards
- ⬇️ **Degraded Release** - Partial feature release
- 🔁 **Re-Charter** - Redefine requirements
- 👤 **User Intervention** - Request manual decision

## Standard Development Process

### 1. Start Project

```bash
/ipd-start "MyProject" "Project description"
```

### 2. Charter Phase (PDU)

PDU creates requirements baseline:
- Define project objectives
- Determine MVP scope
- Set acceptance criteria
- Identify key risks

**Output**: `.claude/charter.md`

### 3. LLD Phase (SE)

SE completes detailed design:
- System architecture design
- Module breakdown
- Interface definition
- Tech stack selection

**Output**: `.claude/lld.md`

### 4. Development (Developer)

Developer executes development:
- Code according to LLD
- Write unit tests
- Self-test pass
- Submit TR

### 5. TR Review (Full Team)

```bash
/ipd-tr start
```

Execute in sequence: PQA → TMM → SE → PDU → LPDT

### 6. Release (LPDT)

After all gates pass, LPDT signs off release.

## Project Documentation

During project runtime, status docs stored in `.claude/`:

| File | Description | Maintainer |
|------|-------------|------------|
| `project-state.md` | Overall project status | LPDT |
| `charter.md` | Requirements baseline | PDU |
| `lld.md` | Detailed design | SE |
| `tr-records.md` | TR history | LPDT |
| `change-log.md` | Change history | PDU |

## Configuration

### Plugin Config (`plugin.json`)

```json
{
  "ipd": {
    "enabled": true,
    "tr_dry_run_max_iterations": 10,
    "auto_escalation": true,
    "state_file": ".claude/project-state.md"
  }
}
```

### Configuration Options

| Option | Description | Default |
|--------|-------------|---------|
| `enabled` | Enable IPD process | `true` |
| `tr_dry_run_max_iterations` | Max TR iterations | `10` |
| `auto_escalation` | Auto escalate decisions | `true` |
| `state_file` | State file path | `.claude/project-state.md` |

## Best Practices

### 1. Clear Charter

Ensure PDU completes Charter before development:
- ✅ Clear requirements
- ✅ Well-defined scope boundaries
- ✅ Testable acceptance criteria

### 2. Follow LLD

Developer strictly follows SE's LLD:
- ✅ Don't deviate from architecture
- ✅ Honor interface contracts
- ✅ Use agreed tech stack

### 3. Responsive to TR

Developer responds promptly to TR feedback:
- ✅ Quick fixes
- ✅ Understand review comments
- ✅ Avoid repeated mistakes

### 4. Monitor Resources

LPDT continuously monitors Token consumption:
- ⚠️ 80% - Warning
- 🛑 100% - Stop or request more

### 5. Ask for Help

Proactively request support when blocked:
- Technical issues → @se
- Unclear requirements → @pdu
- Schedule pressure → @lpdt

## Troubleshooting

### Project State Lost

```bash
# Reinitialize project
/ipd-start "Project name" "Description" --mode=new
```

### TR Infinite Loop

If TR repeatedly fails:

1. Check failure reason: `/ipd-tr status`
2. View detailed feedback: `/ipd-tr feedback`
3. If necessary, degrade delivery or request LPDT intervention

### Token Exhausted

LPDT triggers resource warnings:
- **80%** - Warning, optimize implementation
- **100%** - Stop or request additional budget

### Agent Unresponsive

1. Check agent status: `/ipd-status detailed`
2. Restart corresponding agent
3. Verify plugin configuration

### Commands Unavailable

**OpenCode:**
```bash
# Reinstall
./setup-opencode.sh

# Verify
./verify-installation.sh
```

**Claude Code:**
```bash
# Reload plugin
cd ~/.claude/plugins/oh-my-ipd
git pull
# Restart Claude Code
```

## Advanced Topics

### Customize TR Process

Edit `hooks/pre-tool-use.md` and `hooks/post-tool-use.md` to customize validation logic.

### Extend Agents

Add new agent markdown files in `agents/` directory, defining roles and responsibilities.

### Charter Change Management

```bash
# View current Charter
/ipd-charter view

# Request change
/ipd-charter request "Change description"

# Update after PDU approval
/ipd-charter update
```

## References

- [Huawei IPD Process](https://www.huawei.com)
- [oh-my-opencode](https://github.com/code-yeongyu/oh-my-opencode)
- [OpenCode Docs](https://opencode.ai/docs)

---

**Need help?** Ask in GitHub Issues or check community discussions.

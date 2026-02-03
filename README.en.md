# Oh My OpenCode - IPD Edition

> Automated Virtual PDT Team with Huawei IPD Process Delivery System based on oh-my-opencode

[![IPD-OMO](https://img.shields.io/badge/IPD--OMO-v1.0.0-blue)](./) [![License](https://img.shields.io/badge/License-MIT-green.svg)](./LICENSE)

[中文文档](./README.md)

## Core Concept

**OPC (One Person Company)** achieves unmanned AI development teams through **IPD-OMO**:

- **OMO** as "Autopilot Executor" - handles micro-level code implementation
- **IPD** as "Flight Management System" - manages macro-level quality gates
- **Virtual PDT Team** - simulates Huawei's matrix organization for structured development

## Workflow

```bash
Charter Phase (@pdu)
    ↓
LLD Phase (@se)
    ↓
Development (@developer)
    ↓
╔══════════════════════════════════════╗
║      TR Dry Run Gate                ║
╠══════════════════════════════════════╣
║  @pqa → Code Quality Check          ║
║  @tmm → Functional Testing          ║
║  @se  → Architecture Review         ║
║  @pdu → Requirements Validation     ║
║  @lpdt → Final Decision             ║
╚══════════════════════════════════════╝
    │                    │
    ↓ PASS              ↓ FAIL
 Release           Fix & Resubmit
```

## Virtual PDT Team

| Agent          | Role              | Responsibilities                                              |
| -------------- | ----------------- | ------------------------------------------------------------- |
| **@developer** | Developer         | Implement features, write tests, submit TR                    |
| **@lpdt**      | Project Manager   | Coordinate team, strategic decisions, resource management     |
| **@pdu**       | Product Manager   | Define Charter, requirements baseline, validation             |
| **@se**        | System Architect  | Create LLD, architecture review, technical validation         |
| **@pqa**       | Quality Assurance | Code quality checks, standards enforcement, security scanning |
| **@tmm**       | Test Manager      | Integration testing, E2E testing, performance validation      |

## Quick Start

### Installation

**OpenCode (Recommended):**

```bash
git clone https://github.com/hatewx/oh-my-ipd
cd oh-my-ipd
./setup-opencode.sh
```

**Claude Code:**

```bash
git clone https://github.com/hatewx/oh-my-ipd \
  ~/.claude/plugins/oh-my-ipd
```

📖 For detailed installation, see [INSTALLATION.en.md](./INSTALLATION.en.md)

### Your First IPD Project

#### 1. Start a Project

```bash
/ipd-start my-awesome-feature "Build a new user dashboard"
```

Auto-triggers:

- **@pdu** creates Charter (requirements baseline)
- **@se** creates LLD (detailed design)
- **@lpdt** initializes project state

#### 2. Start Development

```bash
@developer
```

Developer implements based on Charter and LLD.

#### 3. Submit Technical Review

```bash
/ipd-tr start
```

TR Dry Run Loop executes quality gates automatically.

#### 4. Check Project Status

```bash
/ipd-status
```

### Example Session

```
User: /ipd-start user-dashboard "Create a new analytics dashboard"

[LPDT coordinates PDU and SE]

@pdu: Creating Charter...
  ✅ Requirements baseline defined
  ✅ MVP scope identified

@se: Creating LLD...
  ✅ Architecture designed
  ✅ Modules defined

LPDT: ✅ Project initialized!

---

User: @developer start implementation

Developer:
  📝 Implementing analytics-api module
  🧪 Writing unit tests
  ✅ Self-test: PASS

  Submitting to TR...

---

[TR Dry Run Loop]

@pqa: ✅ Code quality PASS
@tmm: ✅ Tests PASS
@se:  ✅ Architecture PASS
@pdu: ✅ Requirements PASS
@lpdt: ✅ Decision: APPROVED

Developer: 🎉 TR PASSED! Feature complete.
```

## Common Commands

| Command         | Purpose           | Example                          |
| --------------- | ----------------- | -------------------------------- |
| `/ipd-start`    | Start new project | `/ipd-start myapp "description"` |
| `/ipd-status`   | Check status      | `/ipd-status`                    |
| `/ipd-tr start` | Start TR          | `/ipd-tr start`                  |
| `/ipd-tr retry` | Retry TR          | `/ipd-tr retry`                  |
| `/ipd-charter`  | View Charter      | `/ipd-charter`                   |

## Using Agents

### Method 1: Switch Primary Agent

Press **Tab** to cycle through 6 agents (OpenCode).

### Method 2: @mention Invocation

```bash
@developer please implement the login feature
@se can you review this architecture?
@pqa check code quality for this PR
```

## Features

- ✅ **Structured Process** - Combines Huawei IPD rigor with OMO agility
- ✅ **Auto TR Loop** - Automated quality gates and feedback cycles
- ✅ **Virtual PDT Team** - 6 specialized roles working together
- ✅ **Resource Monitoring** - Token consumption and progress tracking
- ✅ **Risk Management** - Auto-identify and escalate risks

## Comparison

| Feature      | OMO Default            | IPD-OMO                 |
| ------------ | ---------------------- | ----------------------- |
| **Logic**    | Agile iteration (YOLO) | Structured & robust     |
| **Roles**    | All-in-one Agent       | Matrix PDT team         |
| **Quality**  | Self-correction        | External review + gates |
| **Process**  | Free flow              | Phased + TR             |
| **Decision** | Automatic              | Layered (LPDT)          |

## Advanced Documentation

- 📋 [Detailed Workflows](./WORKFLOWS.en.md) - IPD phases, TR Loop, project docs
- ⚙️ [Configuration](./WORKFLOWS.en.md#configuration) - Customize plugin behavior

## Advanced Usage

### Turbo Mode

For faster development:

- In **OpenCode**: Use `/ulw-loop` or `/ralph-loop` (with oh-my-opencode)
- In **Claude Code**: Use YOLO mode `claude --dangerously-skip-permissions`

## License

MIT License - See [LICENSE](./LICENSE)

## Acknowledgments

- [oh-my-opencode](https://github.com/code-yeongyu/oh-my-opencode) - Foundation OMO implementation
- Huawei IPD Process - Quality management inspiration

---

**Built with ❤️ for OPC (One Person Company)**

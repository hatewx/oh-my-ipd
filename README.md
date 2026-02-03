# Oh My OpenCode - IPD Edition

> 基于 OMO 的全自动 PDT 团队与华为 IPD 流程模拟系统

[![IPD-OMO](https://img.shields.io/badge/IPD--OMO-v1.0.0-blue)](./) [![License](https://img.shields.io/badge/License-MIT-green.svg)](./LICENSE)

## 核心理念

**OPC (One Person Company)** 通过 **IPD-OMO** 实现无人化智能体研发团队：

- **OMO** 作为"自动驾驶执行者"，负责微观代码实现
- **IPD** 作为"航线管理系统"，负责宏观质量门禁
- **虚拟 PDT 团队** 模拟华为矩阵组织，实现结构化稳健开发

## 工作流程

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

## 虚拟 PDT 团队

| Agent          | 角色       | 职责                             |
| -------------- | ---------- | -------------------------------- |
| **@developer** | 开发工程师 | 实现功能、编写测试、提交 TR      |
| **@lpdt**      | 项目经理   | 协调团队、战略决策、资源管理     |
| **@pdu**       | 产品经理   | 定义 Charter、需求基线、需求验证 |
| **@se**        | 系统架构师 | 创建 LLD、架构评审、技术验证     |
| **@pqa**       | 质量保证   | 代码质量检查、规范执行、安全扫描 |
| **@tmm**       | 测试经理   | 集成测试、端到端测试、性能验证   |

## 快速开始

### 安装

**OpenCode（推荐）:**

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

📖 详细安装说明请查看 [INSTALLATION.md](./INSTALLATION.md)

### 第一个 IPD 项目

#### 1. 启动项目

```bash
/ipd-start my-awesome-feature "Build a new user dashboard"
```

自动触发：

- **@pdu** 创建 Charter（需求基线）
- **@se** 创建 LLD（详细设计）
- **@lpdt** 初始化项目状态

#### 2. 开始开发

```bash
@developer
```

Developer 会基于 Charter 和 LLD 实现功能。

#### 3. 提交技术评审

```bash
/ipd-tr start
```

TR Dry Run Loop 自动执行质量门禁。

#### 4. 查看项目状态

```bash
/ipd-status
```

### 实战示例

```
User: /ipd-start user-dashboard "Create a new analytics dashboard"

[LPDT 协调 PDU 和 SE]

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

## 常用命令

| 命令            | 用途         | 示例                      |
| --------------- | ------------ | ------------------------- |
| `/ipd-start`    | 启动新项目   | `/ipd-start myapp "描述"` |
| `/ipd-status`   | 查看状态     | `/ipd-status`             |
| `/ipd-tr start` | 开始 TR      | `/ipd-tr start`           |
| `/ipd-tr retry` | 重新提交 TR  | `/ipd-tr retry`           |
| `/ipd-charter`  | 查看 Charter | `/ipd-charter`            |

## 使用 Agents

### 方法一：切换 Primary Agent

按 **Tab** 键在 6 个 agent 之间切换（OpenCode）。

### 方法二：@mention 调用

```bash
@developer please implement the login feature
@se can you review this architecture?
@pqa check code quality for this PR
```

## 特性

- ✅ **结构化流程** - 结合华为 IPD 的严谨性和 OMO 的敏捷性
- ✅ **自动 TR 循环** - 自动执行质量门禁和反馈循环
- ✅ **虚拟 PDT 团队** - 6 个专业角色协同工作
- ✅ **资源监控** - Token 消耗和进度追踪
- ✅ **风险管理** - 自动识别和升级风险

## 对比

| 特性     | OMO 默认        | IPD-OMO         |
| -------- | --------------- | --------------- |
| **逻辑** | 敏捷迭代 (YOLO) | 结构化稳健      |
| **角色** | 全能 Agent      | 矩阵 PDT 团队   |
| **质量** | 自我纠错        | 外部评审 + 门禁 |
| **流程** | 自由流动        | 阶段化 + TR     |
| **决策** | 自动            | 分层决策 (LPDT) |

## 进阶文档

- 📋 [详细工作流程](./WORKFLOWS.md) - IPD 阶段、TR Loop、项目文档等
- ⚙️ [配置文件](./WORKFLOWS.md#配置文件) - 自定义插件行为

## 高级用法

### 快速飞跑模式

如果你想要快速飞跑:

- 在 `opencode` 中可以使用的 `/ulw-loop` 或 `/ralph-loop`。
- 在 `claude code` 中可以使用 `/ralph-loop`, 但个人更推荐直接使用 yolo `claude --dangerously-skip-permissions` 模式。

## 许可证

MIT License - 详见 [LICENSE](./LICENSE)

## 致谢

- [oh-my-opencode](https://github.com/code-yeongyu/oh-my-opencode) - 基础 OMO 实现
- 华为 IPD 流程 - 质量管理灵感

---

**Built with ❤️ for OPC (One Person Company)**

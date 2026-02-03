# 快速开始指南

本指南将帮助你快速上手 Oh My IPD，体验虚拟 PDT 团队协作开发流程。

> **前置要求**: 请先完成[安装](./INSTALLATION.md)

---

## 第一个 IPD 项目

### 1. 启动项目

```bash
/ipd-start my-awesome-feature "Build a new user dashboard"
```

这将自动触发：

1. **@pdu** 创建 Charter（需求基线）
2. **@se** 创建 LLD（详细设计）  
3. **@lpdt** 初始化项目状态
4. 准备第一次开发迭代

### 2. 开始开发

```bash
@developer
```

Developer 会基于 Charter 和 LLD 开始实现：
- 编写代码
- 编写单元测试
- 自测通过后提交 TR

### 3. 提交技术评审

```bash
/ipd-tr start
```

**TR Dry Run Loop** 自动启动，按顺序执行：

1. ✅ **@pqa** → 代码质量检查
2. ✅ **@tmm** → 功能测试
3. ✅ **@se** → 架构评审
4. ✅ **@pdu** → 需求验证
5. ✅ **@lpdt** → 最终决策

**结果**：
- ✅ **PASS** → 进入下一阶段
- ❌ **FAIL** → Developer 修复后重新提交

### 4. 查看项目状态

```bash
/ipd-status
```

显示内容：
- 当前阶段（Charter/LLD/Develop/TR/Release）
- Agent 状态
- TR 迭代次数
- Token 消耗

---

## 核心工作流

### IPD-OMO 流程图

```
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

---

## 使用 Agents

### 方法一：切换 Primary Agent

按 **Tab** 键在 6 个 agent 之间切换（OpenCode）。

### 方法二：@mention 调用

```bash
@developer please implement the login feature
@se can you review this architecture?
@pqa check code quality for this PR
```

---

## 实战示例

### 完整会话示例

```
User: /ipd-start user-dashboard "Create a new analytics dashboard"

[LPDT 协调 PDU 和 SE]

@pdu: Creating Charter...
  ✅ Requirements baseline defined
  ✅ MVP scope identified
  ✅ Acceptance criteria set

@se: Creating LLD...
  ✅ Architecture designed
  ✅ Modules defined
  ✅ Interfaces specified

LPDT: ✅ Project initialized!

---

User: @developer start implementation

Developer: 
  📝 Implementing analytics-api module
  🧪 Writing unit tests
  📊 Coverage: 85%
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

---

## 常用命令速查

| 命令 | 用途 | 示例 |
|------|------|------|
| `/ipd-start` | 启动新项目 | `/ipd-start myapp "描述"` |
| `/ipd-status` | 查看状态 | `/ipd-status` |
| `/ipd-tr start` | 开始 TR | `/ipd-tr start` |
| `/ipd-tr retry` | 重新提交 TR | `/ipd-tr retry` |
| `/ipd-charter` | 查看 Charter | `/ipd-charter` |

---

## 高级用法

### 快速飞跑模式

如果想要更快的开发速度：

**OpenCode:**
```bash
/ulw-loop    # 极速开发循环（配合 oh-my-opencode）
/ralph-loop  # 增强开发循环
```

**Claude Code:**
```bash
claude --dangerously-skip-permissions  # YOLO 模式
```

### 手动干预 TR 流程

如果 TR 失败超过 3 次，LPDT 会介入决策：

- 🔄 强制继续
- ⬇️ 降级交付
- 🔁 重新定义 Charter
- 👤 请求用户介入

---

## 项目文档位置

项目运行时，状态文档存储在 `.claude/` 目录：

| 文件 | 内容 | 维护者 |
|------|------|--------|
| `project-state.md` | 项目整体状态 | LPDT |
| `charter.md` | 需求基线 | PDU |
| `lld.md` | 详细设计 | SE |
| `tr-records.md` | TR 历史记录 | LPDT |
| `change-log.md` | 变更历史 | PDU |

---

## 6 个虚拟团队成员

| Agent | 角色 | 何时使用 |
|-------|------|---------|
| **@developer** | 开发工程师 | 实现功能、编写代码 |
| **@lpdt** | 项目经理 | 协调团队、做决策 |
| **@pdu** | 产品经理 | 定义需求、验证交付 |
| **@se** | 系统架构师 | 设计架构、评审技术方案 |
| **@pqa** | 质量保证 | 检查代码质量、执行规范 |
| **@tmm** | 测试经理 | 测试验证、发现缺�陷 |

---

## 下一步

1. ✅ 尝试创建你的第一个 IPD 项目
2. 📖 深入了解 [IPD 工作流程](./README.md#工作流程)
3. 🛠️ 自定义配置 `plugin.json`
4. 🤝 配合 [oh-my-opencode](https://github.com/code-yeongyu/oh-my-opencode) 使用

---

**开始构建吧！虚拟 PDT 团队已经准备就绪 🚀**

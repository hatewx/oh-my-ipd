# 安装指南

本插件支持两种 AI 编码助手平台：**OpenCode** 和 **Claude Code**。

## 方式一：OpenCode（推荐）

OpenCode 原生支持 Markdown 配置，安装非常简单。

### 1. 克隆仓库

```bash
git clone https://github.com/hatewx/oh-my-ipd
cd oh-my-ipd
```

### 2. 运行安装脚本

```bash
./setup-opencode.sh
```

安装脚本会自动完成以下操作：

- ✅ 安装 6 个虚拟 PDT 团队成员到 `~/.config/opencode/agents/`
- ✅ 安装 4 个 IPD 命令到 `~/.config/opencode/commands/`
- ✅ 安装 2 个协作技能到 `~/.config/opencode/skills/`
- ✅ 创建工作流钩子到 `~/.config/opencode/plugins/`

### 3. 验证安装

```bash
./verify-installation.sh
```

### 4. 启动 OpenCode

```bash
opencode
```

### 已安装的组件

#### 📦 6 个 Agents（通过 `/agents` 或 @mention 访问）

| Agent | 职责 | 主要功能 |
|-------|------|---------|
| `@developer` | 开发工程师 | 实现功能、编写测试、提交 TR |
| `@lpdt` | 项目经理 | 协调团队、战略决策、资源管理 |
| `@pdu` | 产品经理 | 定义 Charter、需求基线、需求验证 |
| `@se` | 系统架构师 | 创建 LLD、架构评审、技术验证 |
| `@pqa` | 质量保证 | 代码质量检查、规范执行、安全扫描 |
| `@tmm` | 测试经理 | 集成测试、端到端测试、性能验证 |

#### 💻 4 个 Commands（使用 `/` 前缀）

| 命令 | 功能 |
|------|------|
| `/ipd-start` | 启动新的 IPD-OMO 项目 |
| `/ipd-status` | 查看项目状态和进度 |
| `/ipd-tr` | 执行技术评审操作 |
| `/ipd-charter` | Charter 管理 |

#### 📚 2 个 Skills（所有 agent 自动可用）

- **ipd-workflow** - IPD 流程定义
- **pdt-collaboration** - PDT 团队协作模式

#### 🔌 1 个 Plugin

- **oh-my-ipd-hooks.js** - 工作流验证钩子

### 验证安装成功

在 OpenCode 中：

- 输入 `/agents` 可以看到 6 个 PDT 团队成员
- 输入 `/ipd` 可以看到 4 个 IPD 命令

![OpenCode Agents](./demo-assets/oc-agents.png)
![OpenCode Commands](./demo-assets/oc-cmds.png)

### 配合 oh-my-opencode 使用

推荐配合 [oh-my-opencode](https://github.com/code-yeongyu/oh-my-opencode) 一起使用，通过 `/ulw-loop` 和 `/ralph-loop` 等工作流进一步提升开发质量。

---

## 方式二：Claude Code

### 1. 克隆到插件目录

```bash
# 直接克隆到 Claude Code 插件目录
git clone https://github.com/hatewx/oh-my-ipd \
  ~/.claude/plugins/oh-my-ipd
```

或者使用符号链接：

```bash
# 克隆到任意位置
git clone https://github.com/hatewx/oh-my-ipd ~/path/to/oh-my-ipd

# 创建符号链接
ln -s ~/path/to/oh-my-ipd ~/.claude/plugins/oh-my-ipd
```

### 2. 重启 Claude Code

重启 Claude Code 以加载插件。

### 3. 验证安装

在 Claude Code 中：

- 输入 `/agents` 可以看到 6 个 PDT 团队成员
- 输入 `/ipd` 可以看到 4 个 IPD 命令

![Claude Code Agents](./demo-assets/cc-agents.png)
![Claude Code Commands](./demo-assets/cc-cmds.png)

### YOLO 模式（推荐）

在 Claude Code 中，推荐使用 YOLO 模式以获得最佳体验：

```bash
claude --dangerously-skip-permissions
```

---

## 安装位置

### OpenCode

所有文件安装在 `~/.config/opencode/`：

```
~/.config/opencode/
├── agents/
│   ├── developer.md
│   ├── lpdt.md
│   ├── pdu.md
│   ├── pqa.md
│   ├── se.md
│   └── tmm.md
├── commands/
│   ├── ipd-charter.md
│   ├── ipd-start.md
│   ├── ipd-status.md
│   └── ipd-tr.md
├── skills/
│   ├── ipd-workflow/SKILL.md
│   └── pdt-collaboration/SKILL.md
└── plugins/
    └── oh-my-ipd-hooks.js
```

### Claude Code

插件安装在 `~/.claude/plugins/oh-my-ipd/`。

---

## 更新插件

### OpenCode

重新运行安装脚本即可：

```bash
cd /path/to/oh-my-ipd
git pull
./setup-opencode.sh
```

### Claude Code

```bash
cd ~/.claude/plugins/oh-my-ipd
git pull
```

然后重启 Claude Code。

---

## 故障排除

### OpenCode

**Agents 没有显示？**
- 重启 OpenCode
- 检查文件是否存在：`ls ~/.config/opencode/agents/`
- 确认 frontmatter 包含 `mode:` 字段

**Commands 无法使用？**
- 检查文件是否存在：`ls ~/.config/opencode/commands/`
- 确认 frontmatter 包含 `description:` 字段
- 尝试 `/help` 查看已注册的命令

**Skills 不可用？**
- 检查目录结构：`ls ~/.config/opencode/skills/*/SKILL.md`
- 确认 frontmatter 包含 `name:` 和 `description:` 字段

### Claude Code

**插件未加载？**
- 检查插件目录：`ls ~/.claude/plugins/oh-my-ipd/`
- 确认 `plugin.json` 文件存在
- 重启 Claude Code

---

## 下一步

安装完成后，请查看 [快速开始指南](./QUICK-START.md) 开始使用。

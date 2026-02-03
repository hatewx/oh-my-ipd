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

### 3. 验证安装

```bash
./verify-installation.sh

opencode
```

在 OpenCode 中：

- 输入 `/agents` 可以看到 6 个 PDT 团队成员

  ![OpenCode Agents](./demo-assets/oc-agents.png)

- 输入 `/ipd` 可以看到 4 个 IPD 命令

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
# 创建符号链接
ln -s ~/path/to/oh-my-ipd ~/.claude/plugins/oh-my-ipd
```

### 2. 重启 Claude Code

重启 Claude Code 以加载插件。

### 3. 验证安装

在 Claude Code 中：

- 输入 `/agents` 可以看到 6 个 PDT 团队成员

  ![Claude Code Agents](./demo-assets/cc-agents.png)

- 输入 `/ipd` 可以看到 4 个 IPD 命令

  ![Claude Code Commands](./demo-assets/cc-cmds.png)

---

## 安装位置

### OpenCode

所有文件安装在 `~/.config/opencode/`：

```bash
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

## 下一步

安装完成后，请查看 [快速开始指南](./QUICK-START.md) 开始使用。

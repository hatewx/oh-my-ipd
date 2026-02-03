---
name: ipd-start
description: |
  启动 IPD-OMO 开发流程。创建 Charter、初始化项目状态、
  启动虚拟 PDT 团队，开始第一个 TR Dry Run Loop。
arguments:
  - name: project_name
    description: 项目名称
    required: true
  - name: description
    description: 项目描述
    required: true
  - name: mode
    description: 启动模式 (new/continue)
    required: false
    default: new
---

# IPD-OMO 流程启动

你将启动一个基于 IPD 流程的智能体研发项目。作为 LPDT，我需要协调 PDU 和 SE 完成项目初始化。

## 启动流程

### 步骤 1: 项目状态检查
首先检查是否存在现有的项目状态：
- 如果 `.claude/project-state.md` 存在且 mode=continue，则继续现有项目
- 如果 mode=new 或状态文件不存在，则创建新项目

### 步骤 2: 创建 Charter (PDU 职责)
激活 `pdu` Agent，要求 PDU 创建 Charter 文档：
- 项目背景和目标
- 需求基线 (Requirements Baseline)
- MVP 范围
- 验收标准

### 步骤 3: 创建 LLD (SE 职责)
激活 `se` Agent，要求 SE 创建 LLD 文档：
- 系统架构设计
- 模块划分
- 接口定义
- 关键决策 (ADR)

### 步骤 4: 初始化项目状态 (LPDT 职责)
创建 `.claude/project-state.md`，包含：
- 项目基本信息
- 当前阶段 (Charter)
- 迭代计数器
- Token 消耗追踪
- TR 记录

### 步骤 5: 启动第一个开发迭代
激活 `developer` Agent，开始第一个 TR Dry Run Loop。

## 输出要求

启动完成后，输出项目启动摘要：
```
╔════════════════════════════════════════════════════════════╗
║  IPD-OMO 项目启动                                          ║
╠════════════════════════════════════════════════════════════╣
║  项目名称: [name]                                          ║
║  项目 ID: [id]                                             ║
║  启动时间: [timestamp]                                     ║
╠════════════════════════════════════════════════════════════╣
║  当前阶段: Charter                                         ║
║  PDU 状态: [ Charter 创建状态 ]                            ║
║  SE 状态:  [ LLD 创建状态 ]                                ║
╠════════════════════════════════════════════════════════════╣
║  下一步:                                                   ║
║  1. 确认 Charter 和 LLD                                    ║
║  2. 输入 `ipd-tr start` 开始第一个开发迭代                 ║
╚════════════════════════════════════════════════════════════╝
```

## 执行指令

请按以下步骤执行：
1. 读取或创建项目状态文件
2. 如果新项目，调用 PDU 创建 Charter
3. 如果新项目，调用 SE 创建 LLD
4. 更新项目状态为 "Charter" 阶段
5. 输出启动摘要

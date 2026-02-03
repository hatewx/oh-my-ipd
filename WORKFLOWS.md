# 详细工作流程

本文档详细描述 IPD-OMO 的工作流程、阶段映射、配置选项和故障排除。

## IPD 阶段映射

| 华为 IPD | OMO 阶段       | 交付物         | 质量门禁       |
| -------- | -------------- | -------------- | -------------- |
| Concept  | Charter        | `charter.md`   | PDU 审批       |
| Plan     | LLD            | `lld.md`       | SE 审批        |
| Develop  | 编码 + TR1/TR2 | 代码 + TR 报告 | PQA/TMM/SE/PDU |
| Qualify  | TR3 + 系统测试 | 测试报告       | 全团队         |
| Launch   | Release        | Release Notes  | LPDT 批准      |

## TR Dry Run Loop 详解

### 流程图

```bash
Developer 实现
    ↓
提交 TR
    ↓
┌─────────────────────────────────────────┐
│  ┌─────────┐                            │
│  │  PQA    │──Fail──┐                   │
│  │质量检查 │        │                   │
│  └────┬────┘        │                   │
│       │ Pass        │                   │
│       ▼             │                   │
│  ┌─────────┐        │                   │
│  │  TMM    │──Fail──┤                   │
│  │功能验证 │        │                   │
│  └────┬────┘        │                   │
│       │ Pass        │                   │
│       ▼             │                   │
│  ┌─────────┐        │                   │
│  │   SE    │──Fail──┤───→ 返回 Developer│
│  │架构评审 │        │      修复         │
│  └────┬────┘        │                   │
│       │ Pass        │                   │
│       ▼             │                   │
│  ┌─────────┐        │                   │
│  │  PDU    │──Fail──┘                   │
│  │需求验证 │                            │
│  └────┬────┘                            │
│       │ Pass                            │
│       ▼                                 │
│  ┌─────────┐                            │
│  │  LPDT   │──Pass──→ Release           │
│  │最终决策 │──Fail──→ 返回 Developer    │
│  └─────────┘     ──Escalate→ 用户决策   │
└─────────────────────────────────────────┘
```

### 各阶段职责

#### 1. PQA - 代码质量检查

- Lint 检查
- 代码规范验证
- 安全扫描
- 测试覆盖率检查

#### 2. TMM - 功能验证

- 单元测试执行
- 集成测试
- 端到端测试
- 性能测试

#### 3. SE - 架构评审

- 架构一致性检查
- 技术债务评估
- 设计模式验证
- 接口契约检查

#### 4. PDU - 需求验证

- Charter 符合性检查
- 功能完整性验证
- 验收标准匹配
- 商业价值确认

#### 5. LPDT - 最终决策

- 综合评估所有反馈
- 资源消耗检查
- 风险评估
- 发布决策

### TR 失败处理

如果同一 TR 失败超过 3 次，LPDT 会介入决策：

- 🔄 **强制继续** - 降低门禁标准
- ⬇️ **降级交付** - 部分功能发布
- 🔁 **重新 Charter** - 重新定义需求
- 👤 **用户介入** - 请求人工决策

## 标准开发流程

### 1. 启动项目

```bash
/ipd-start "MyProject" "项目描述"
```

### 2. Charter 阶段 (PDU)

PDU 创建需求基线：

- 定义项目目标
- 确定 MVP 范围
- 设置验收标准
- 识别关键风险

**输出**: `.claude/charter.md`

### 3. LLD 阶段 (SE)

SE 完成详细设计：

- 系统架构设计
- 模块划分
- 接口定义
- 技术栈选型

**输出**: `.claude/lld.md`

### 4. 开发实现 (Developer)

Developer 执行开发：

- 按照 LLD 编写代码
- 编写单元测试
- 自测通过
- 提交 TR

### 5. TR 评审 (全团队)

```bash
/ipd-tr start
```

按顺序执行：PQA → TMM → SE → PDU → LPDT

### 6. 发布 (LPDT)

所有门禁通过后，LPDT 签署发布。

## 项目文档

项目运行时，状态文档存储在 `.claude/` 目录：

| 文件               | 描述         | 维护者 |
| ------------------ | ------------ | ------ |
| `project-state.md` | 项目整体状态 | LPDT   |
| `charter.md`       | 需求基线     | PDU    |
| `lld.md`           | 详细设计     | SE     |
| `tr-records.md`    | TR 历史记录  | LPDT   |
| `change-log.md`    | 变更历史     | PDU    |

## 配置文件

### 插件配置 (`plugin.json`)

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

### 配置项说明

| 配置项                      | 说明            | 默认值                     |
| --------------------------- | --------------- | -------------------------- |
| `enabled`                   | 启用 IPD 流程   | `true`                     |
| `tr_dry_run_max_iterations` | TR 最大迭代次数 | `10`                       |
| `auto_escalation`           | 自动升级决策    | `true`                     |
| `state_file`                | 状态文件路径    | `.claude/project-state.md` |

## 故障排除

### 项目状态丢失

```bash
# 重新初始化项目
/ipd-start "项目名称" "描述" --mode=new
```

### TR 死循环

如果 TR 反复失败：

1. 检查失败原因：`/ipd-tr status`
2. 查看详细反馈：`/ipd-tr feedback`
3. 必要时降级交付或请求 LPDT 介入

## 高级话题

### 自定义 TR 流程

编辑 `hooks/pre-tool-use.md` 和 `hooks/post-tool-use.md` 自定义验证逻辑。

### 扩展 Agent

在 `agents/` 目录添加新的 agent markdown 文件，定义角色和职责。

### Charter 变更管理

```bash
# 查看当前 Charter
/ipd-charter view

# 请求变更
/ipd-charter request "变更描述"

# PDU 审批后更新
/ipd-charter update
```

---

**需要帮助？** 在 GitHub Issues 中提问或查看社区讨论。

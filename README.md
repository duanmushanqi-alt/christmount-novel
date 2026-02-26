# Novel Writer × Claude Code 协作系统

> 一套用于长篇小说（10万字以上）创作的 AI 辅助工作流，基于 Claude Code 构建。

---

## 这是什么

本仓库包含两部分：

| 部分 | 内容 | 对应目录 |
|------|------|---------|
| **协作系统** | 命令、技法、追踪模板、工作流文档——可复用于任何小说项目 | `.specify/templates/`、`.claude/`、`docs/` |
| **项目内容** | 当前小说的规格文档和正文章节——仅属于本项目 | `spec/`、`stories/` |

如果你是**新加入的协作者**，请按以下顺序阅读：

1. 本文档（README）— 了解系统和流程
2. [docs/collaboration-guide.md](docs/collaboration-guide.md) — 工作细节、范式、分工
3. `spec/specification.md` — 本项目的故事定位
4. `spec/tasks.md` — 当前待写任务清单

---

## 环境要求

| 工具 | 用途 | 安装 |
|------|------|------|
| Claude Code (CLI) | AI 协作主环境 | `npm install -g @anthropic-ai/claude-code` |
| Git | 版本控制 | 系统自带或官网下载 |
| Markdown 编辑器 | 阅读/编辑文档 | VS Code、Typora 均可 |

> 所有写作和追踪操作都在 Claude Code 会话中完成，无需其他工具。

---

## 目录结构

```
.
├── README.md                  ← 你正在读的文件（入口）
│
├── docs/
│   └── collaboration-guide.md ← 工作流程详解、写作范式库、协作分工
│
├── spec/                      ← 本项目规格文档（协作者必读）
│   ├── specification.md       ← 故事定位、核心需求、成功标准
│   ├── creative-plan.md       ← 卷章结构、情节计划
│   ├── tasks.md               ← 章节任务清单（逐章分解）
│   ├── writing-style-guide.md ← 写作风格规范（句式/节奏/禁忌）
│   ├── terminology.md         ← 人名地名称谓硬性规范
│   ├── knowledge/             ← 角色档案、世界观、场景地图
│   └── tracking/              ← 进度追踪（JSON 格式）
│
├── stories/
│   └── content/
│       └── volume1/           ← 第一卷章节正文
│           ├── chapter-001.md
│           └── ...
│
├── .specify/templates/        ← 可复用：命令模板、技法 Skills、追踪模板
└── .claude/                   ← 可复用：知识库、技能模块
```

---

## 工作流程（一图总览）

```
开新卷                          每章循环                        章节交付
──────                         ──────                          ──────
读规格文档                       确认任务(tasks.md)               完整章节 MD 文件
  ↓                              ↓                               +
拆解章节任务   →    循环开始  →   加载上下文                       追踪文件已更新
  ↓               （每章重复）   （前章+追踪文件）                  +
初始化追踪                        ↓                              自查清单通过
                                AI执行写作(/write)
                                  ↓
                                人工审核（角色语气/逻辑/规格）
                                  ↓
                                更新追踪 (/track)
                                  ↓
                              ➜ 下一章
```

详细步骤说明见 [docs/collaboration-guide.md — Part B](docs/collaboration-guide.md)

---

## 交付物定义

一章写作任务完成，意味着以下文件**全部到位**：

### 1. 章节正文

```
stories/content/volumeX/chapter-XXX.md
```

文件内必须包含：

- [ ] 章节头部注释（编号、标题、字数、核心任务一句话）
- [ ] 场景之间有 `---` 分隔
- [ ] 时间推进使用本项目时间标记方式（参见 terminology.md）
- [ ] 章末有悬念钩子或伏笔

### 2. 追踪文件更新

```
spec/tracking/timeline.json         ← 新增本章时间事件节点
spec/tracking/character-state.json  ← 更新角色位置/心理/知识列表
spec/tracking/plot-tracker.json     ← 标记完成情节节点，记录新伏笔
spec/tracking/relationships.json    ← 记录本章关系变化（如有）
```

> 追踪文件不更新 = 本章未完成，下一章无法开写。

---

## 交付标准

### 内容维度（必须全通过）

| 检查项 | 判断标准 |
|--------|---------|
| 核心任务完成 | `tasks.md` 本章"必须包含"逐项勾选 |
| 角色行为一致 | 说话方式、决策逻辑符合 `knowledge/character-voices.md` |
| 角色知识边界 | 没有角色引用**本章之前还未揭露**的信息 |
| 时间线合理 | 情节时长与上一章末尾衔接自然 |
| 章末有钩子 | 读者有理由翻到下一章 |

### 风格维度（参见 spec/writing-style-guide.md）

| 检查项 | 常见问题 |
|--------|---------|
| 无 AI 套话 | 禁止："一丝XX，一丝XX，还有一丝XX" / "仿佛整个世界都XX" |
| 无情绪标签 | 用行动/生理反应代替"他感到愤怒" |
| 对话有信息量 | 每句对话必须推进信息或展现性格 |
| 描写有功能 | 环境描写服务情节或情绪，不是装饰 |

### 一致性维度（高频失误，重点检查）

| 检查项 | 验证方法 |
|--------|---------|
| 季节/天气 | 与当前卷时间段一致 |
| 专有名词 | 对照 `spec/terminology.md` |
| 使用古代时间表达 | 对照写作风格指南 |

---

## 人类与 AI 的分工边界

| 属于人类决策 | 属于 AI 执行 |
|-------------|-------------|
| 故事大方向（情节走向、角色命运）| 按规格生成章节内容 |
| 规格文档变更（修改大纲/角色定位）| 追踪文件更新 |
| "这像不像这个角色说的话" 的最终判断 | 提供多种写法供选择 |
| 哪个地方"感觉不对" | 定点修改具体段落 |

**AI 有建议权，无决策权。** 涉及故事方向的任何改动，由人类拍板后 AI 执行。

---

## 快速上手（新协作者）

**第一天：熟悉系统**

```bash
git clone <repo-url>
cd <project>
# 按顺序读以下文件
# 1. README.md（本文件）
# 2. docs/collaboration-guide.md
# 3. spec/specification.md
# 4. spec/creative-plan.md
```

**开始写章节前：**

```bash
# 在 Claude Code 中
/specify    # 确认规格理解一致
# 然后查看 spec/tasks.md 的当前章节任务
# 查看 spec/tracking/ 中的当前追踪状态
/write      # 执行章节写作
/track      # 写完后更新追踪
```

**每章结束后的自检：**

对照本 README 中"交付标准"三个维度逐项检查，全部通过再算完成。

---

## 遇到问题

| 问题类型 | 处理方式 |
|---------|---------|
| 角色行为感觉不对 | 停止，讨论后再继续，不要强行写下去 |
| 追踪文件和正文有矛盾 | 以追踪文件为准，修正正文 |
| 任务规格不清楚 | 用 `/clarify` 命令消除歧义，再开写 |
| 发现之前章节有错误 | 先修正再继续，不要带错误继续推进 |

---

*详细工作流、写作范式、第一卷经验总结见 [docs/collaboration-guide.md](docs/collaboration-guide.md)*

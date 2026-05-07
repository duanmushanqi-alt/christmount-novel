# 基督山伯爵 · 短剧改编工程

## 项目定位
将小说《基督山伯爵》（架空古代复仇题材）改编为**质感短剧**，用于投递/接洽影视方。

## 三个核心决策（基线，不轻易动）

### 1. 人设方向：保留克制隐忍
- 黄繁不"金手指化"，不"装哭立威"
- **差异化定位**：质感短剧（参考《虚颜》《二十九》《无双》一档），不走常规爆款爽剧路线
- 受众更窄但更精准——目标是有品质追求的厂方/平台

### 2. 产品形态：60 集 × 5 分钟
- 总时长约 300 分钟（≈ 一部三段式电影）
- 每集 5 分钟节奏框架：
  - 开场 30 秒：上集钩子的延续 / 当集情境建立
  - 中段 3-4 分钟：信息推进 + 1-2 个小转折
  - 结尾 30 秒：本集钩子（必须）
- 每 10-12 集一个大钩子（卷级转折）

### 3. 改编自由度：忠实原作改编
- **保留**：人物设定、主线情节、世界观、核心冲突逻辑
- **可调**：叙述顺序、对白、节奏密度、心理外化方式、配角戏份比重
- **可加**：原作没有但短剧需要的过场反派/小爽点（不冲击主线即可）
- **不动**：主角弧光、关键转折、终极反派、复仇核心动机

## 与原作工程的关系

```
基督山伯爵/                          ← 项目根
├── spec/knowledge/                  ← 【共享层】只读引用，不修改
├── spec/characters/                 ← 【共享层】只读引用，不修改
├── spec/volume*-*.md               ← 【小说独占】不读、不改
├── stories/content/                 ← 【小说独占】不读、不改
├── memory/                          ← 【小说独占】反 AI 铁律仅适用小说，短剧另定
└── adaptation/short-drama/          ← 【本目录】所有改编产物
```

### 共享层（可读不可写）
- [spec/knowledge/world-setting.md](../../spec/knowledge/world-setting.md) — 世界观
- [spec/knowledge/character-profiles.md](../../spec/knowledge/character-profiles.md) — 人物档
- [spec/knowledge/timeline-ten-years-ago.md](../../spec/knowledge/timeline-ten-years-ago.md) — 十年前事件
- [spec/characters/protagonist.md](../../spec/characters/protagonist.md) — 黄繁详档
- [spec/knowledge/locations.md](../../spec/knowledge/locations.md) — 地点设定
- [spec/xingcheng-geography.md](../../spec/xingcheng-geography.md) — 兴城地理

### 创作层（参考用，不改写）
原作细纲、共识、正文：改编前阅读以理解原作意图，但不修改这些文件。如发现原作问题想改，单独走 `[novel]` commit。

## 改编基线快照
- Git tag：`novel-baseline-2026-04-30`
- 内容：第一卷正文完成（已精修）、第二卷正文完成（16-30 章）、第三卷细纲完成（31-47 章）、第三卷正文未开写
- 改编工作基于此快照推进。原作后续更新（第三卷正文、第四卷启动等）默认不卷入改编，必要时再决定升级基线

## 目录说明

```
adaptation/short-drama/
├── README.md                ← 本文件
├── style-rules.md           ← 短剧专属风格规则（和小说反 AI 铁律不同）
├── divergences.md           ← 与原作的差异点登记
├── adaptation-notes.md      ← 改编阐述（投递物料，待完善）
├── logline.md               ← 一句话钩子（待写）
├── synopsis.md              ← 一页纸梗概（待写）
├── characters-drama.md      ← 短剧版人物（只记差异+短剧专属配角）
├── episodes-outline.md      ← 60 集分集大纲（待写）
└── scripts/                 ← 完整剧本目录
    ├── ep-001.md
    └── ...
```

## AI 协作约束（重要）

**写小说时**：让 AI 读 [memory/](/Users/beiying/.claude/projects/-Users-beiying-Documents-novel------/memory/) + spec/，沿用现有流程。

**写短剧改编时**：
- AI **只读**：本目录全部文件 + 共享层（spec/knowledge/、spec/characters/）
- AI **不读**：[memory/constitution.md](/Users/beiying/.claude/projects/-Users-beiying-Documents-novel------/memory/constitution.md)、[memory/style-reference.md](/Users/beiying/.claude/projects/-Users-beiying-Documents-novel------/memory/style-reference.md)、[memory/writing-pitfalls.md](/Users/beiying/.claude/projects/-Users-beiying-Documents-novel------/memory/writing-pitfalls.md)、原作细纲和正文（除非明确需要参考某段情节）
- 提示词必加："本任务是短剧改编，请只参考 adaptation/short-drama/ 目录的规则。小说创作中的反 AI 铁律部分仅供参考，短剧节奏需求优先按 style-rules.md 执行"

如果用 Claude.ai Project 协作：**新建独立 Project**，不复用小说 Project。

## 提交规范

提交信息前缀：
- `[adapt]` 改编工作（本目录所有变更）
- `[novel]` 小说工作
- `[shared]` 共享层变更（仅限事实补充，不允许创作调整）

**单 commit 不混合两边**。

## 当前状态
- 工程目录已建立（2026-04-30）
- 待完成：style-rules.md → adaptation-notes.md → logline.md → synopsis.md → 分集大纲框架 → 前 5-10 集样片剧本

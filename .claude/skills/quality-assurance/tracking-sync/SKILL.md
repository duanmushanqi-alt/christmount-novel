---
name: tracking-sync
description: "每隔约5章执行一次的批量追踪同步工作流：更新追踪数据 → 检测不一致 → 修复问题 → Git 提交。确保人物状态、时间线、伏笔、关系网络等追踪数据与已完成章节内容保持同步。"
allowed-tools: Read, Edit, Bash, Grep, Glob
---

# 追踪同步工作流 (Tracking Sync Workflow)

## 概览

每完成约5章写作后，批量同步所有追踪数据，确保角色状态、时间线、伏笔、关系网络等信息与实际章节内容一致。

```
Step 1: 写入 (Update)   → 批量更新所有追踪 JSON 文件
Step 2: 检测 (Detect)   → 交叉验证数据一致性，发现问题
Step 3: 修改 (Fix)      → 修复检测到的问题
Step 4: 存档 (Commit)   → Git 提交所有更新
```

**与 chapter-workflow 的区别**：
| 维度 | chapter-workflow | tracking-sync |
|------|-----------------|---------------|
| 频率 | 每章执行 | 每约5章执行一次 |
| 目标文件 | tasks.md + 章节文件 | spec/tracking/*.json + spec/knowledge/*.md |
| 范围 | 单章质量保证 | 跨章节数据一致性 |
| 触发条件 | 完成一章写作后 | 积累5章左右，或卷末、重大剧情转折后 |

**建议触发时机**：
- 每完成5章左右
- 每卷结束时（必须执行）
- 重大剧情转折后（如角色死亡、身份揭露、阵营变化）
- 开始新写作会话前（确认追踪数据为最新）

---

## Step 1: 写入 (Update)

### 1.1 确定同步范围

首先确认本次需要同步的章节范围：

```bash
# 检查已完成的章节
ls spec/tracking/  # 查看追踪文件
# 对比追踪数据中记录到的最后章节 vs 实际已完成章节
```

**操作方式**：
1. Read 每个追踪 JSON 文件，找到其中记录的最新章节编号
2. Read `spec/tasks.md`，确认实际已完成到哪一章
3. 差值即为需要补录的章节范围

**示例**：
```
character-state.json: 记录到 Ch7
plot-tracker.json:    记录到 Ch6
timeline.json:        记录到 Ch7
relationships.json:   记录到 Ch9
实际已完成:            Ch14
→ 需要同步 Ch8-14 的数据（各文件起始点不同）
```

### 1.2 加载章节内容

按同步范围，依次 Read 每章内容：

```
stories/content/volume1/chapter-008.md
stories/content/volume1/chapter-009.md
...
stories/content/volume1/chapter-014.md
```

**阅读要点**：边读边记录以下信息：
- 出场角色及其状态变化
- 新揭露的信息/真相
- 时间推进（天数、时段）
- 角色关系变化
- 伏笔埋设/回收
- 新出现的地名、物品、称谓

### 1.3 更新 character-state.json

**文件路径**：`spec/tracking/character-state.json`

**更新内容**：

#### A. 主角状态更新
```json
{
  "current_chapter": 14,  // ← 更新到最新章节
  "physical": {
    "appearance": "...",   // ← 如有外貌变化
    "health": "..."        // ← 如有伤病/恢复
  },
  "emotional": {
    "state": "...",        // ← 当前情绪状态
    "arc_position": "..."  // ← 成长弧位置
  },
  "knowledge": {
    "knows": [...],        // ← 新获知的信息
    "suspects": [...],     // ← 新产生的怀疑
    "unknown": [...]       // ← 仍不知道的信息
  },
  "possessions": [...],    // ← 物品变化（如钱袋变轻）
  "location": "..."        // ← 当前所在地
}
```

#### B. 配角状态更新
- 新出场角色：添加完整条目
- 已有角色：更新 `last_seen`、`status`、关键状态变化
- 角色知识边界：严格区分每个角色"知道什么"和"不知道什么"

#### C. 外貌追踪
- 更新 `appearance_tracking` 中的描写记录
- 确保跨章节外貌描写一致

### 1.4 更新 plot-tracker.json

**文件路径**：`spec/tracking/plot-tracker.json`

**更新内容**：

#### A. 主线进展
```json
{
  "main_plotline": {
    "current_stage": "...",    // ← 更新主线阶段
    "progress_percentage": N   // ← 更新进度百分比
  }
}
```

#### B. 支线进展
- 更新每条活跃支线的 `current_status`
- 新增的支线添加完整条目
- 已结束的支线标记 `"status": "resolved"`

#### C. 伏笔银行
```json
{
  "foreshadowing_bank": [
    {
      "id": "F-013",
      "planted_chapter": 14,
      "description": "小偷说家里妹妹病重",
      "planned_payoff": "后续章节",
      "status": "planted"       // planted / partially_revealed / resolved
    }
  ]
}
```
- 新埋设的伏笔：添加条目，`status: "planted"`
- 已部分揭示的伏笔：更新状态为 `"partially_revealed"`
- 已回收的伏笔：更新状态为 `"resolved"`，填写 `resolved_chapter`

### 1.5 更新 timeline.json

**文件路径**：`spec/tracking/timeline.json`

**更新内容**：

#### A. 日间事件追踪
```json
{
  "story_days": [
    {
      "day": "第N天",
      "chapters": [X, Y],
      "events": [
        {"time": "清晨", "event": "...", "location": "..."},
        {"time": "午后", "event": "...", "location": "..."}
      ]
    }
  ]
}
```

#### B. 时间推进标记
- 标注"第二天"、"三天后"等时间跳跃
- 确认章节间的时间连续性

#### C. 历史事件引用
- 如章节中回忆或提及历史事件，确认时间线一致
- 例：十年前的事件序列（举报→入狱→转移→伪造死亡）

### 1.6 更新 relationships.json

**文件路径**：`spec/tracking/relationships.json`

**更新内容**：

#### A. 角色对关系
```json
{
  "character_pairs": [
    {
      "pair": ["黄简", "林玄影"],
      "current_status": "合作伙伴（有保留的信任）",
      "evolution": [
        {"chapter": 14, "change": "黄简说出'我们'，标志合作关系确立"}
      ]
    }
  ]
}
```

#### B. 阵营/势力
- 更新势力关系图
- 新发现的势力关联（如刺史府的权力层级）

#### C. 冲突追踪
- 活跃冲突的状态更新
- 新产生的冲突添加条目

### 1.7 更新 validation-rules.json

**文件路径**：`spec/tracking/validation-rules.json`

> ⚠️ **注意**：此文件可能仍是空模板（全是占位符）。如果是空模板，需要在本步骤中填充实际内容。

**更新内容**：

```json
{
  "character_names": {
    "黄简": {"aliases": ["阿简", "黄繁", "黄小公子"], "never": ["黄建", "黄坚"]},
    "林玄影": {"aliases": ["玄影"], "never": ["林玄"]},
    "李希音": {"aliases": ["希音"], "never": []}
  },
  "location_names": {
    "兴城": {"never_use": ["X城", "A城"]},
    "北魏": {"never_use": ["A国"]},
    "陈汉国": {"never_use": ["B国", "C国"]},
    "宣城监狱": {"never_use": ["K监狱"]},
    "乐城": {"never_use": ["D城"]}
  },
  "fixed_terms": {
    "商人家庭用'宅'不用'府'": true,
    "中文弯引号": true
  }
}
```

### 1.8 更新 knowledge 文件（可选）

**文件路径**：
- `spec/knowledge/character-profiles.md`
- `spec/knowledge/character-voices.md`
- `spec/knowledge/timeline-ten-years-ago.md`

**操作规则**：
- `character-profiles.md`：如果仍是空模板，填充已出场角色的档案
- `character-voices.md`：如果仍是空模板，填充已出场角色的语言特征
- `timeline-ten-years-ago.md`：已有内容，仅在发现新信息时追加

---

## Step 2: 检测 (Detect)

### 2.1 占位符名称检测

> ⚠️ **高优先级**：这是已知的系统性问题

在所有追踪文件中搜索以下占位符：

```bash
# 使用 Grep 搜索（不要用 bash grep）
```

**需要搜索的占位符**：

| 占位符 | 正确名称 |
|--------|---------|
| A国 | 北魏 |
| B国 | 陈汉国 |
| C国 | （根据上下文确定） |
| X城 | 兴城 |
| X地 | 兴城 |
| K监狱 | 宣城监狱 |
| D城 | 乐城 |
| [主角名] | 黄简 |
| [配角1名称] | （根据上下文确定） |

**检测范围**：
- `spec/tracking/*.json`（全部5个文件）
- `spec/knowledge/*.md`（全部3个文件）

### 2.2 跨文件一致性检测

#### A. 角色位置一致性
- `character-state.json` 中角色的 `location` 是否与 `timeline.json` 中最新事件的地点一致？
- 例：character-state 说黄简在兴城，timeline 最后事件也应在兴城

#### B. 角色关系一致性
- `relationships.json` 中的关系状态是否与 `character-state.json` 中角色的情感/知识状态吻合？
- 例：如果 relationships 说黄简和林玄影已合作，character-state 中黄简的情感状态应反映这一点

#### C. 伏笔一致性
- `plot-tracker.json` 中的伏笔状态是否与 `tasks.md` 中的伏笔标记一致？
- 例：tasks.md 标记 F-013 ✅ 已埋设，plot-tracker 中 F-013 应为 `"status": "planted"`

#### D. 时间线一致性
- `timeline.json` 中的日间事件是否与章节内容中的时间描写一致？
- 检查有没有时间跳跃遗漏或日期冲突

#### E. 角色知识边界
- 每个角色"知道什么"的边界是否正确？
- 重要规则：**信息控制** — 角色不应知道作者/读者知道但角色不应知道的信息
- 核对 `character-state.json` 中每个角色的 `knowledge` 字段

### 2.3 与章节内容交叉验证

选择关键章节，抽查追踪数据是否准确：

```
检查项：
□ 角色出场章节是否正确记录
□ 关键对话/事件是否被追踪
□ 物品拥有/丢失是否准确（如钱袋、玉佩）
□ 角色称谓是否一致（阿简、黄繁、黄小公子）
□ 情感状态变化是否被捕捉
```

### 2.4 生成检测报告

将所有发现的问题汇总为检测报告：

```markdown
## 追踪同步检测报告

### 同步范围：Ch[X]-Ch[Y]

### P0 问题（必须修复）
1. [占位符] character-state.json L45: "A国兴城" → 应为"北魏兴城"或"兴城"
2. [逻辑] 黄简在 Ch14 已把碎银给了母女和小偷，但物品追踪未更新
3. ...

### P1 问题（建议修复）
1. [缺失] Ch10-11 的时间线事件未记录
2. [不一致] relationships 中黄简-林玄影状态仍为"对立"，应更新为"合作"
3. ...

### P2 问题（可选优化）
1. [补充] character-voices.md 仍为空模板
2. ...

### 统计
- 占位符问题：N 处
- 数据缺失：N 处
- 不一致：N 处
- 总计：N 个问题
```

---

## Step 3: 修改 (Fix)

### 3.1 修复优先级

```
P0：占位符名称替换、逻辑错误、关键数据缺失 → 必须立即修复
P1：数据不完整、状态未更新 → 应当修复
P2：可选文件填充、格式优化 → 视情况决定
```

### 3.2 占位符批量替换

⚠️ **编辑前必须先 Read 文件**（避免引号字符不匹配问题）

对每个包含占位符的文件执行替换：

```
操作步骤：
1. Read 文件获取实际内容
2. 使用 Edit 工具的 replace_all: true 选项进行批量替换
3. 逐个占位符替换（A国→北魏，B国→陈汉国，X城→兴城 等）
4. 替换完成后再次 Read 确认
```

**替换对照表**：

| 占位符 | 替换为 | replace_all |
|--------|--------|-------------|
| "A国" | "北魏" | true |
| "B国" | "陈汉国" | true |
| "X城" | "兴城" | true |
| "X地" | "兴城" | true |
| "K监狱" | "宣城监狱" | true |
| "D城" | "乐城" | true |
| "[主角名]" | "黄简" | true |
| "[配角1名称]" | （根据上下文）| true |
| "[固定称呼1]" | （根据上下文）| true |

### 3.3 补充缺失数据

按照检测报告中列出的缺失项，逐项补充：

```
操作步骤：
1. Read 对应追踪文件
2. Read 缺失数据来源的章节内容
3. 按照既有格式，使用 Edit 工具添加数据
4. 确保新增数据的 JSON 格式正确
```

### 3.4 修正不一致数据

对检测到的不一致问题，以**章节内容为准**进行修正：

```
原则：章节内容 > 追踪数据
如果追踪数据与章节内容矛盾，修改追踪数据。
如果章节内容本身可能有误，记录到待修复列表中（不在此步骤处理）。
```

### 3.5 填充空模板（可选）

如果 `validation-rules.json` 或 knowledge 文件仍为空模板：

**validation-rules.json**：
- 填充所有已出场角色名称和别名
- 填充所有已出现的地名
- 填充固定用语规则

**character-profiles.md**：
- 为每个重要角色创建档案卡
- 包含：姓名、身份、外貌特征、性格特征、核心动机、知识边界

**character-voices.md**：
- 为主要角色记录语言特征
- 包含：说话风格、常用词汇、禁忌用语、情感表达方式

### 3.6 修复后验证

所有修复完成后，再次执行检测：

```
□ Grep 搜索确认无残留占位符
□ 抽查 2-3 处修复内容是否正确
□ JSON 格式是否有效（无语法错误）
```

---

## Step 4: 存档 (Commit)

### 4.1 标准流程

```bash
# 1. 查看变更
git status

# 2. 暂存追踪文件（明确指定，不用 git add -A）
git add spec/tracking/character-state.json
git add spec/tracking/plot-tracker.json
git add spec/tracking/timeline.json
git add spec/tracking/relationships.json
git add spec/tracking/validation-rules.json
# 如果 knowledge 文件也更新了：
git add spec/knowledge/character-profiles.md
git add spec/knowledge/character-voices.md
git add spec/knowledge/timeline-ten-years-ago.md

# 3. 提交
git commit -m "$(cat <<'EOF'
同步追踪数据：Ch[X]-Ch[Y]

- 更新角色状态至第[Y]章（黄简、林玄影等[N]个角色）
- 补充时间线事件（第[X]-[Y]天）
- 更新伏笔银行：新增 F-0XX、F-0XX
- 更新关系网络：黄简↔林玄影 关系变更为[状态]
- 修复占位符命名 [N] 处（A国→北魏、B国→陈汉国等）
- [其他重要更新说明]

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
EOF
)"

# 4. 验证
git status  # 确认工作区干净
```

### 4.2 提交消息规范

- **首行**：`同步追踪数据：Ch[X]-Ch[Y]`
- **内容**：用 `-` 列表列出更新要点（4-8条）
- **末行**：`Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>`

### 4.3 暂存范围

每次提交应包含：
- `spec/tracking/*.json` — 所有有变更的追踪文件
- `spec/knowledge/*.md` — 有变更的知识文件

不应包含：
- `spec/creative-plan.md` — 永远不修改
- `stories/content/` — 章节内容（由 chapter-workflow 管理）
- `spec/tasks.md` — 任务追踪（由 chapter-workflow 管理）

---

## 完整流程示例

以下是 Ch8-Ch14 的追踪同步完整执行记录：

```
📥 Step 1: Update
   ├─ 确认同步范围：Ch8-Ch14（7章）
   ├─ 依次 Read Ch8-Ch14 章节内容
   ├─ 更新 character-state.json
   │   ├─ 黄简：current_chapter 7→14，知识更新（知道父母死因、大将军伏击、乐城/宣城）
   │   ├─ 林玄影：状态从"颓废"→"有目标"，关系变化
   │   └─ 新增配角：马掌柜（德成当）、小偷少年
   ├─ 更新 plot-tracker.json
   │   ├─ 主线进展：真相揭示→信息收集阶段
   │   ├─ 新增伏笔 F-011~F-013
   │   └─ F-004 玉佩伏笔状态更新
   ├─ 更新 timeline.json
   │   ├─ 补充第3-6天的日间事件（Ch8-Ch14 时间跨度）
   │   └─ 标注清晨/午后/天黑等时间节点
   ├─ 更新 relationships.json
   │   ├─ 黄简↔林玄影："对立"→"有保留的合作"
   │   └─ 新增：黄简↔刺史府（潜在敌对）
   └─ 填充 validation-rules.json（从空模板→实际数据）

🔍 Step 2: Detect
   ├─ 占位符搜索 → 发现 23 处（A国×8、B国×5、X城×4、K监狱×3、D城×3）
   ├─ 跨文件一致性 → 发现 2 处不一致
   │   ├─ relationships 中状态未更新
   │   └─ timeline 中缺少 Ch13 清晨事件
   └─ 章节交叉验证 → 确认无逻辑错误

🔧 Step 3: Fix
   ├─ 批量替换占位符：23 处全部修复
   ├─ 修正 relationships 中的状态
   ├─ 补充 timeline 中缺失的事件
   ├─ 填充 validation-rules.json 实际数据
   └─ 修复后再次验证 → 无残留问题 ✅

💾 Step 4: Commit
   ├─ git add spec/tracking/*.json spec/knowledge/*.md
   ├─ git commit（多行 HEREDOC 消息）
   ├─ 提交哈希：xxxxxxx
   └─ git status 确认干净 ✅
```

---

## 与现有命令的协同

本工作流是**批量同步**，与以下现有命令互补配合：

| 现有命令 | 用途 | 与本工作流的关系 |
|---------|------|----------------|
| `/track` | 查看/检查追踪状态 | 可在 Step 2 辅助检测 |
| `/track-init` | 初始化追踪系统 | 仅在项目初期使用一次 |
| `/timeline` | 单次时间线操作 | 可在 Step 1 辅助更新 |
| `/relations` | 单次关系操作 | 可在 Step 1 辅助更新 |

**推荐用法**：
- 日常写作时使用 `/track --check` 快速检查
- 阶段性同步时使用本工作流批量处理
- 两者配合，确保追踪数据始终准确

---

## 常见问题与教训

### Q1: 什么时候应该执行追踪同步？
**答案**：
- **常规**：每完成5章执行一次
- **必须**：每卷结束时
- **建议**：重大剧情转折后（如 Ch10 真相揭露）
- **开始新会话前**：如果不确定追踪数据是否最新

### Q2: Edit 工具修改 JSON 文件总是失败？
**原因**：JSON 中的引号和缩进必须完全匹配。
**解决**：
1. 每次 Edit 之前必须先 Read 文件
2. 从 Read 结果中精确复制要替换的文本
3. JSON 注意转义字符和缩进

### Q3: 占位符名称替换会影响已有数据吗？
**答案**：使用 `replace_all: true` 时会替换文件中所有匹配项。替换前先 Read 文件，确认替换范围无误。如果某个占位符在不同上下文中可能有不同含义（如"C国"），需要逐个确认后再替换。

### Q4: validation-rules.json 是空模板怎么办？
**答案**：在 Step 1.7 或 Step 3.5 中填充实际数据。以已完成章节中出现的角色名、地名为准，填写正确名称和禁用名称列表。

### Q5: knowledge 文件需要每次都更新吗？
**答案**：
- `timeline-ten-years-ago.md`：仅在发现新的历史信息时更新
- `character-profiles.md`：首次同步时填充，之后仅在角色有重大变化时更新
- `character-voices.md`：首次同步时填充，之后较少更新

### Q6: 追踪文件和 tasks.md 的伏笔标记不一致怎么办？
**答案**：以 tasks.md 中的伏笔标记为准（因为它在每章的 chapter-workflow 中已经验证过）。将 plot-tracker.json 中的伏笔状态同步到与 tasks.md 一致。

### Q7: 更新数据量很大时怎么处理？
**答案**：按文件分批处理。建议顺序：
1. timeline.json（基础时间线）
2. character-state.json（角色状态依赖时间线）
3. relationships.json（关系依赖角色状态）
4. plot-tracker.json（伏笔和剧情跨越以上所有）
5. validation-rules.json（规则性数据，最后处理）

---

## 检查清单（快速参考）

每次执行追踪同步后，逐项打勾：

```
□ 确认同步范围（从哪章到哪章）
□ 已 Read 所有需要同步的章节内容
□ character-state.json 已更新（主角+配角+知识边界）
□ plot-tracker.json 已更新（主线+支线+伏笔）
□ timeline.json 已更新（日间事件+时间跳跃）
□ relationships.json 已更新（关系状态+演变记录）
□ validation-rules.json 已填充/更新
□ Grep 搜索无残留占位符（A国/B国/X城/K监狱/D城）
□ 跨文件一致性已检查
□ 检测到的问题已修复
□ 修复后已验证无残留问题
□ knowledge 文件已更新（如需要）
□ creative-plan.md 未被修改 ⚠️
□ git add 指定文件（不用 -A）
□ git commit 多行消息 + Co-Authored-By
□ git status 确认干净
```

---

## 追踪文件速查表

| 文件 | 路径 | 核心内容 |
|------|------|---------|
| 角色状态 | `spec/tracking/character-state.json` | 角色当前状态、知识边界、物品、位置 |
| 剧情追踪 | `spec/tracking/plot-tracker.json` | 主线/支线进展、伏笔银行、卷进度 |
| 时间线 | `spec/tracking/timeline.json` | 日间事件、时间跳跃、历史引用 |
| 关系网络 | `spec/tracking/relationships.json` | 角色对关系、阵营势力、冲突 |
| 校验规则 | `spec/tracking/validation-rules.json` | 名称规范、称谓规则、禁用词 |
| 角色档案 | `spec/knowledge/character-profiles.md` | 角色详细背景和设定 |
| 角色话术 | `spec/knowledge/character-voices.md` | 角色说话风格和语言特征 |
| 十年前时间线 | `spec/knowledge/timeline-ten-years-ago.md` | 十年前事件的详细时间线 |

---

*创建时间: 2026-02-10*
*基于: Chapters 2-14 的追踪基础设施分析*
*版本: 1.0*

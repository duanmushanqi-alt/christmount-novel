# 漫剧生产工作区说明

## 目录说明

- `~/Documents/novel/christmount-novel/`：上游内容仓库，只负责同步原始内容
- `01_素材理解/`：人物、世界观、章节、时间线、地点等理解整理
- `02_角色设计/`：角色形象卡、视觉关键词、服装/气质/关系整理
- `03_剧情拆解/`：章节改编、分集规划、分场拆解、节奏设计
- `04_漫剧脚本/`：可直接用于漫剧改编的场景脚本、对白脚本
- `05_分镜脚本/`：镜头级分镜、景别、动作、表情、转场、时长
- `06_AI出图提示词/`：角色立绘、场景、镜头提示词
- `07_配音字幕/`：台词整理、字幕稿、配音文本
- `08_交付归档/`：阶段性交付物、确认稿、归档材料

## 同步方式

上游仓库路径：

`~/Documents/novel/christmount-novel/`

一键同步命令：

```bash
~/Documents/comic-drama/christmount-comic-drama/sync-upstream.sh
```

## 工作原则

1. 不直接在上游 `christmount-novel` 仓库里写漫剧产出
2. 原仓库作为“内容源”，你的漫剧相关内容都写在 `workspace/`
3. 最好建立“章节 -> 漫剧脚本 -> 分镜 -> 提示词”的映射关系，方便后续仓库更新时增量调整

## 当前扫描结果（第一版）

### 正文位置

- `stories/content/volume1/chapter-001.md` 到 `chapter-015.md`
- `stories/content/volume2/chapter-016.md` 到 `chapter-030.md`

### 角色与设定

- `spec/characters/protagonist.md`
- `spec/knowledge/character-profiles.md`
- `spec/knowledge/character-voices.md`
- `spec/knowledge/world-setting.md`
- `spec/knowledge/locations.md`
- `spec/knowledge/timeline-ten-years-ago.md`

### 其他重要内容

- `spec/specification.md`
- `spec/creative-plan.md`
- `spec/writing-style-guide.md`
- `spec/volume2-outline-draft.md`
- `spec/volume2-consensus.md`
- `spec/quick-reference.md`

## 我建议的下一步

优先做这 3 个文件：

1. `01_素材理解/角色总表.md`
2. `01_素材理解/章节总表.md`
3. `03_剧情拆解/漫剧改编总方案.md`

这样后面不管是做人设、脚本还是分镜，都有统一底稿。

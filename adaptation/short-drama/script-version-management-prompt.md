# 后续章节双版本管理提示词

> 用途：发给新窗口或后续协作者，用于继续写 EP2 及之后内容。  
> 目标：每集同时维护两套剧本：传统剧本版 + AI 漫剧拆镜版。

## 项目边界

```text
这是《基督山伯爵》AI 漫剧 / 短剧改编任务。

只允许修改：
/Users/beiying/Documents/novel/基督山伯爵/adaptation/short-drama/

不允许修改：
/Users/beiying/Documents/novel/基督山伯爵/ 下除 adaptation/short-drama/ 以外的小说正文、小说设定、细纲、memory、spec 等上层文件。
```

## 必读文件

```text
请先阅读以下文件：

1. 第一集传统剧本：
/Users/beiying/Documents/novel/基督山伯爵/adaptation/short-drama/scripts/ep01-traditional-script-v1.md

2. 第一集 AI 漫剧拆镜：
/Users/beiying/Documents/novel/基督山伯爵/adaptation/short-drama/scripts/ep01-ai-comic-v1.md

3. 前 5 集细化节奏：
/Users/beiying/Documents/novel/基督山伯爵/adaptation/short-drama/episodes-001-005-detail.md

4. 60 集初版目录：
/Users/beiying/Documents/novel/基督山伯爵/adaptation/short-drama/episodes-outline-v1.md

5. EP1 人物形象设计基准：
/Users/beiying/Documents/novel/基督山伯爵/adaptation/short-drama/character-visual-prompts-ep01.md
```

## 工作目标

```text
请继续创作第 X 集，并同时输出两套文件：

1. 传统剧本版：
scripts/epXX-traditional-script-v1.md

2. AI 漫剧拆镜版：
scripts/epXX-ai-comic-v1.md

两套文件必须剧情一致、台词一致、结尾钩子一致。
传统剧本负责戏剧内容。
AI 漫剧拆镜负责画面编号、景别、建议时长、字幕、音效、动效、备注。
```

## 传统剧本格式

```text
第X集：《标题》传统剧本 v1

时间：
地点：
人物：
时长：约 3 分钟

本集功能：
核心冲突：
关键信息：
结尾钩子：

## X-1 地点 时间 内/外

△ 远景：
△ 中景：
△ 近景：
△ 特写：

人物名：台词。

△ 【字幕】必要时间 / 地点转场
△ 【转场】画面如何转入下一场
△ 【切黑】用于集尾
```

### 传统剧本符号规则

- `△`：画面 / 动作 / 可见信息。
- `【字幕】`：只用于时间、地点、重点台词卡点，不解释剧情。
- `【转场】`：用于时间或空间切换。
- `【切黑】`：用于集尾钩子。
- 不写大段心理活动。
- 不使用旁白。
- 动作描写必须可见、可画、可拍。

## AI 漫剧拆镜格式

```text
# 第X集：标题

## 基本信息

- 时长：约 180 秒
- 形式：AI 漫剧画面脚本
- 核心看点：
- 本集功能：
- 结尾钩子：

## 视听原则

- 画面先行，少解释。
- 不使用旁白。
- 字幕只承担时间转场和重点台词卡点。
- 黄简保持克制隐忍。

## 画面脚本

### 画面1

画面：
景别：
建议时长：
台词：
字幕：
音效：
动效：
备注：
```

### AI 拆镜规则

- 单集总时长约 180 秒。
- 镜头数量不强制固定，通常 25-32 个画面。
- 一个画面尽量只承担一个核心动作或一句核心台词。
- 竖屏 9:16 构图优先。
- 人物主体尽量在中轴或偏中轴。
- 关键动作不要放在画面底部，需预留字幕区。
- 不使用旁白。
- 不写玄幻发光特效。
- 不把黄简写成邪魅狂狷或爽剧式立威。

## 双版本管理要求

```text
写作流程：

1. 先写传统剧本版。
2. 检查传统剧本中的剧情、台词、动作是否成立。
3. 再根据传统剧本转成 AI 漫剧拆镜版。
4. 转换后检查两套文件：
   - 台词是否一致。
   - 事件顺序是否一致。
   - 结尾钩子是否一致。
   - 关键信息是否一致。
5. 如果修改其中一版，必须同步另一版。
```

## 命名规范

```text
传统剧本：
scripts/epXX-traditional-script-v1.md

AI 漫剧拆镜：
scripts/epXX-ai-comic-v1.md

人物 / 场景提示词：
character-visual-prompts-epXX.md
scene-visual-prompts-epXX.md
```

## 输出前自检

```text
请在每集结尾自检：

1. 是否仍然是 3 分钟左右？
2. 是否没有旁白？
3. 是否有明确视觉钩子？
4. 是否有明确结尾钩子？
5. 黄简是否保持克制隐忍？
6. 台词是否过密或过解释？
7. 关键信息是否通过画面、动作、台词自然体现？
8. 传统剧本和 AI 拆镜稿是否一致？
9. 是否适合竖屏 9:16 漫剧制作？
```

## 可直接发送的新窗口提示词

```text
这是《基督山伯爵》AI 漫剧续写任务。请不要修改小说正文和小说设定，只处理 adaptation/short-drama/ 下的漫剧内容。

项目路径：
/Users/beiying/Documents/novel/基督山伯爵/adaptation/short-drama/

请先阅读：
1. scripts/ep01-traditional-script-v1.md
2. scripts/ep01-ai-comic-v1.md
3. episodes-001-005-detail.md
4. episodes-outline-v1.md
5. character-visual-prompts-ep01.md

当前要求：
请继续创作第 X 集，并输出两套文件：
1. scripts/epXX-traditional-script-v1.md
2. scripts/epXX-ai-comic-v1.md

要求：
- 先写传统剧本，再转成 AI 漫剧拆镜。
- 两套文件必须剧情一致、台词一致、结尾钩子一致。
- 单集约 180 秒。
- 不使用旁白。
- 使用竖屏 9:16 漫剧思维。
- 黄简保持克制隐忍。
- 信息通过画面、动作、台词呈现。
- 不随意改 EP1 已定设定。
- 如果发现上游大纲和 EP1 已定设定冲突，先列出冲突点，不要直接改。
```

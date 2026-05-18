# 写作技法层（writing-craft）

> 本目录集中存放"**怎么写**"的全部规范——技法库、风格指南、术语速查、地理设定。
> 与"**写什么**"分离：内容设计（细纲/共识/章节梗概）保留在 `spec/` 根目录，
> 与"**红线/检查清单**"分离：每章必加载的扫描清单留在 `memory/`。

---

## 目录结构

```
spec/writing-craft/
├── README.md               ← 本文件（入口）
├── style-guide.md          ← 正文写作风格规范（节奏/人物/对话/描写）
├── terminology.md          ← 术语规范（国家/地名/称呼/纪年）
├── quick-reference.md      ← 术语速查卡（写作前 30 秒扫一眼）
├── xingcheng-geography.md  ← 兴城地理与第三卷物理设定
└── lit2skill/              ← 文学技法库（基于琅琊榜蒸馏的 6 个可操作技法）
    ├── index.md            ← 入口 + 触发矩阵 + 链接图
    ├── 01-information-asymmetry.md   信息差叙事
    ├── 02-proxy-action.md            代理行动
    ├── 03-delayed-release.md         情感延迟与余震
    ├── 04-probe-counter-probe.md     试探与反试探
    ├── 05-enemy-coherence.md         敌人视角合理性
    └── 06-small-scene-big-stake.md   方寸之间见格局
```

---

## 调用时机（与写作流程对齐）

| 阶段 | 调用文件 | 用法 |
|------|---------|------|
| **写章节前** | `quick-reference.md` | 扫一眼术语，避免地名/称呼出错 |
| **写章节前** | `lit2skill/index.md` 触发矩阵 | 按本章场景类型圈出激活的 skill |
| **写章节前** | 圈中的 `lit2skill/0X-*.md` | 走 E0 前置判断 + 列清单/三基本面/后果树 |
| **写作中** | `style-guide.md` | 遇到节奏/对话/描写不确定时查 |
| **写作中** | `terminology.md` | 涉及国家/官职/纪年时查权威表述 |
| **写作中** | `xingcheng-geography.md` | 场景涉及兴城内部位置/路线时查 |
| **写完后** | `lit2skill/0X-*.md` 诊断钩子 | 对激活的 skill 逐条扫描 |

---

## 与其他层的关系

- **memory/**（每次必加载）→ 红线、风格DNA、陷阱库、扫描清单
- **spec/writing-craft/**（按需调用）→ 技法、术语、地理
- **spec/**（内容设计）→ 卷共识、章节细纲、读者承诺
- **spec/knowledge/**（世界观与角色库）→ 角色档案、场景设定、十年前时间线
- **spec/tracking/**（动态状态）→ 角色当前状态、关系、情节追踪

**优先级**：memory 红线 > 卷共识/章节承诺 > writing-craft 技法 > 其他参考。
冲突时以更高优先级为准。

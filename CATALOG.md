# كتالوج الحزم

المسارات نسبية إلى جذر هذا المستودع بعد المزامنة، ومطابقة لـ [`nizam-deepseek`](https://github.com/slomai1/nizam-deepseek).

## core — إلزامي

- `core/CLAUDE.md`
- `core/hooks/block_dangerous.sh`
- `core/hooks/block_secrets.sh`
- `core/hooks/verify_paths.sh`
- `core/hooks/loop_prevention.sh`
- `core/hooks/auto_format.sh`
- `core/rules/operating-system-policy.md`
- `core/rules/golden-set.md`

## arabic — يعتمد على core

- `core/commands/explain-ar.md`
- `core/commands/review-ar.md`
- `core/skills/arabic-design/`

## memory — يعتمد على core

- `core/commands/mem-load.md`
- `core/commands/mem-query.md`
- `core/commands/mem-save.md`
- `core/commands/memory-search.md`
- `core/commands/project-context.md`
- `core/commands/session-summary.md`
- `install/init-memory.js`
- `install/migrate-memory-scope.js`

## quality — يعتمد على core

- `core/commands/qa.md`
- `core/commands/auto-verify.md`
- `core/commands/eval-last.md`
- `core/commands/compare-models.md`
- `core/workflows/auto-verify.js`
- `core/workflows/code-quality-pipeline.js`
- `core/workflows/deep-review.js`
- `core/workflows/quick-check.js`
- `core/workflows/canary.js`

## worktrees — يعتمد على core

- `core/commands/worktree-new.md`
- `core/commands/worktree-done.md`

## في المكتبة وليس في حزمة

تُنسخ للتصفح، وتُؤخذ يدويًا إن احتجتها:

- بقية `core/commands` و`core/skills` و`core/workflows`
- `docs/`
- `templates/`
- `tools/`
- `install/*.js` فقط — بدون `install.sh` و`install.ps1`

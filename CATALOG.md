# كتالوج الحزم

كل مسار أدناه نسبي إلى المصدر: [`slomai1/nizam-deepseek`](https://github.com/slomai1/nizam-deepseek).

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

## خارج الكتالوج هذا

هذه الملفات تبقى في المصدر إن احتجتها لحالة محددة:

- `core/commands/wp-perf.md` و `core/commands/wp-perf-review.md`
- `core/skills/auto-build` و `debugging-wizard` و `design-pipeline` و `feature-forge` و `spec-miner` و `checklist-ui`
- بقية `core/workflows` مثل `sprint.js` و `freeze.js` و `land-and-deploy.js`

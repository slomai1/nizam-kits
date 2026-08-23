# حزمة quality

تحقق ومراجعة وخطوط جودة قبل الدفع.

الاعتماد: `core`.

## الملفات من المصدر

- `core/commands/qa.md` → `commands/qa.md`
- `core/commands/auto-verify.md` → `commands/auto-verify.md`
- `core/commands/eval-last.md` → `commands/eval-last.md`
- `core/commands/compare-models.md` → `commands/compare-models.md`
- `core/workflows/auto-verify.js` → `workflows/auto-verify.js`
- `core/workflows/code-quality-pipeline.js` → `workflows/code-quality-pipeline.js`
- `core/workflows/deep-review.js` → `workflows/deep-review.js`
- `core/workflows/quick-check.js` → `workflows/quick-check.js`
- `core/workflows/canary.js` → `workflows/canary.js`

## كيف تأخذ

```bash
./scripts/pick.sh --packs core,quality --dest ~/.claude
```

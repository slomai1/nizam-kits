# حزمة worktrees

فروع عمل معزولة للمهام المتوازية بدون خلط الفرع الرئيسي.

الاعتماد: `core`.

## الملفات من المصدر

- `core/commands/worktree-new.md` → `commands/worktree-new.md`
- `core/commands/worktree-done.md` → `commands/worktree-done.md`

## كيف تأخذ

```bash
./scripts/pick.sh --packs core,worktrees --dest ~/.claude
```

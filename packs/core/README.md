# حزمة core

القاعدة الإلزامية. خذها قبل أي حزمة أخرى.

## ماذا تعطيك

حوكمة التشغيل، خطافات تمنع الأوامر الخطرة وتسريب الأسرار، وقواعد العمل.

## الملفات من المصدر

- `core/CLAUDE.md` → `CLAUDE.md`
- `core/hooks/block_dangerous.sh` → `hooks/block_dangerous.sh`
- `core/hooks/block_secrets.sh` → `hooks/block_secrets.sh`
- `core/hooks/verify_paths.sh` → `hooks/verify_paths.sh`
- `core/hooks/loop_prevention.sh` → `hooks/loop_prevention.sh`
- `core/hooks/auto_format.sh` → `hooks/auto_format.sh`
- `core/rules/operating-system-policy.md` → `rules/operating-system-policy.md`
- `core/rules/golden-set.md` → `rules/golden-set.md`

## كيف تأخذ

```bash
./scripts/pick.sh --packs core --dest ~/.claude
```

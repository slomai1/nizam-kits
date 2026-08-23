# نِظام Kits

مرجع مفتوح لمكتبة [نِظام](https://github.com/slomai1/nizam-deepseek). تختار ما تحتاجه، ولا تثبّت الكل.

الأصل والمثبّت الكامل يبقيان في [`nizam-deepseek`](https://github.com/slomai1/nizam-deepseek). هذا المستودع يعرض الملفات للتصفح والنسخ الانتقائي.

## المدخل

```bash
git clone https://github.com/slomai1/nizam-kits.git
cd nizam-kits
chmod +x scripts/pick.sh
./scripts/pick.sh --packs core,arabic --dest ~/.claude
```

أمثلة:

```bash
./scripts/pick.sh --list
./scripts/pick.sh --packs core,memory,quality --dest ~/.claude
```

إن وجدت شجرة `core/` هنا ينسخ منها. وإلا يجلب `nizam-deepseek`.

## الحزم

| الحزمة | المحتوى | الاعتماد |
|---|---|---|
| [`core`](packs/core/README.md) | حوكمة وخطافات حماية | إلزامية |
| [`arabic`](packs/arabic/README.md) | شرح ومراجعة عربية | `core` |
| [`memory`](packs/memory/README.md) | ذاكرة السياق | `core` |
| [`quality`](packs/quality/README.md) | تحقق وجودة | `core` |
| [`worktrees`](packs/worktrees/README.md) | فروع عمل معزولة | `core` |

القائمة الكاملة في [`CATALOG.md`](CATALOG.md).

## مكتبة الملفات

بعد المزامنة تظهر هذه المجلدات للتصفح:

- `core/` أوامر، خطافات، قواعد، مهارات، وسير عمل
- `docs/` مرجع التركيب والبنية
- `templates/` قوالب الإعدادات والذاكرة
- `tools/` اختبارات الخطافات والذاكرة

لا يُنسخ `install.sh` ولا `install.ps1`.

لتحديث المكتبة محليًا:

```bash
chmod +x scripts/sync.sh
./scripts/sync.sh
```

أو شغّل ووركفلو `Sync library from nizam-deepseek` من تبويب Actions.

## الترخيص

MIT. راجع [`NOTICE.md`](NOTICE.md).

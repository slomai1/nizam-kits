# نِظام Kits

مرجع مفتوح لحزم [نِظام](https://github.com/slomai1/nizam-deepseek). تختار ما تحتاجه، ولا تثبّت الكل.

هذا المستودع **ليس** نسخة كاملة من النظام. المصدر الوحيد للكود هو [`slomai1/nizam-deepseek`](https://github.com/slomai1/nizam-deepseek).

## اختر حزمة

| الحزمة | ماذا تعطيك | الاعتماد |
|---|---|---|
| [`core`](packs/core/README.md) | حوكمة، خطافات حماية، قواعد التشغيل | إلزامية |
| [`arabic`](packs/arabic/README.md) | شرح ومراجعة بالعربية + مهارة تصميم عربي | `core` |
| [`memory`](packs/memory/README.md) | حفظ السياق والبحث في الذاكرة | `core` |
| [`quality`](packs/quality/README.md) | تحقق، مراجعة، خطوط جودة | `core` |
| [`worktrees`](packs/worktrees/README.md) | فروع عمل معزولة للمهام المتوازية | `core` |

التفاصيل والملفات في [`CATALOG.md`](CATALOG.md).

## طريقتان للأخذ

### 1) سكربت الاختيار

ينسخ فقط الحزم المختارة من مستودع المصدر إلى مجلد الوجهة:

```bash
git clone https://github.com/slomai1/nizam-kits.git
cd nizam-kits
chmod +x scripts/pick.sh
./scripts/pick.sh --packs core,arabic --dest ~/.claude
```

أمثلة أخرى:

```bash
./scripts/pick.sh --packs core,memory,quality --dest ~/.claude
./scripts/pick.sh --list
```

السكربت يجلب نسخة محلية من `nizam-deepseek` أو ينسخها إلى مجلد مؤقت.

### 2) نسخ يدوي

افتح مجلد الحزمة، اقرأ قائمة الملفات، وانسخ من
[`nizam-deepseek`](https://github.com/slomai1/nizam-deepseek) ما تريده فقط.

## ما لن تجده هنا

- لا يوجد مثبّت كامل ينسخ النظام دفعة واحدة
- لا يوجد أسرار مشاريع خاصة ولا مفاتيح API
- أوامر ووردبريس وبقية المهارات بقيت في المصدر إن احتجتها لاحقًا

## الترخيص

MIT. راجع [`NOTICE.md`](NOTICE.md).

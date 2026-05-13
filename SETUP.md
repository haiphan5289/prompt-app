# Setup Guide

## OpenAI API Key (Recommended for Vietnam)

### 1. Get a free API key

1. Go to [platform.openai.com](https://platform.openai.com)
2. Sign up — new accounts get **$5 free credit**
3. Go to **API keys** → **Create new secret key**
4. Copy the key (format: `sk-...`)

### 2. Add the key locally

Add `OPENAI_API_KEY` to `dart-define.json` in the project root:

```json
{
  "GEMINI_API_KEY": "",
  "OPENAI_API_KEY": "sk-..."
}
```

### 3. Run the app

```bash
flutter run --dart-define-from-file=dart-define.json
```

> The app uses `gpt-4o-mini` — fast, cheap, and higher quality than Gemini Flash for prompt transformation.

### 4. Monitor usage & billing

- Usage: [platform.openai.com/usage](https://platform.openai.com/usage)
- Billing / balance: [platform.openai.com/settings/billing](https://platform.openai.com/settings/billing)

**Estimated cost with `gpt-4o-mini`:**

| | Price |
|---|---|
| Input | $0.15 / 1M tokens |
| Output | $0.60 / 1M tokens |

Each "Transform & Ask AI" call ≈ 500–1,000 tokens → ~$0.0006/call.
$5 credit ≈ 8,000–10,000 calls (months of dev/testing).

---

## Gemini API Key

### 1. Get a free API key

1. Go to [aistudio.google.com](https://aistudio.google.com)
2. Sign in with Google
3. Click **Get API key** → **Create API key**
4. Under "Choose an imported project" → select **Default Gemini Project**
5. Copy the key (format: `AIzaSy...`)

> **Important:** Always select **Default Gemini Project**, not a custom Google Cloud project.
> Custom projects have `limit: 0` free quota by default.

### 2. Add the key locally

Create `dart-define.json` in the project root (already gitignored):

```json
{
  "GEMINI_API_KEY": "AIzaSy..."
}
```

### 3. Run the app

```bash
flutter run --dart-define-from-file=dart-define.json
```

> The API key is a **compile-time constant** — hot reload does not apply changes.
> Always do a full restart after updating `dart-define.json`.

### 4. Build

```bash
# iOS
flutter build ios --dart-define-from-file=dart-define.json

# Android
flutter build apk --dart-define-from-file=dart-define.json
```

---

## Free Tier Limits (Default Gemini Project)

| Model | RPM | RPD |
|---|---|---|
| `gemini-2.0-flash` | 15 | 1,500 |
| `gemini-2.0-flash-lite` | 30 | 1,500 |

> RPM = requests/minute · RPD = requests/day

---

## Vietnam Billing Note

Google Cloud ở Việt Nam **chỉ hỗ trợ prepay billing** (không có postpaid).

Để activate free tier quota, bắt buộc phải nạp tối thiểu **₫500,000** vào billing account.

> **Lưu ý quan trọng:**
> - Credits **không hoàn tiền** (non-refundable)
> - Credits **hết hạn sau 1 năm**
> - Credits **chỉ dùng được khi vượt free tier** — dev/testing trong giới hạn free tier không tốn credits

### Thay thế: OpenAI API

Nếu không muốn prepay Gemini, dùng **OpenAI API** thay thế:

| | Gemini | OpenAI |
|---|---|---|
| Free credit | Cần prepay ₫500k ở VN | $5 free khi đăng ký mới |
| Model | `gemini-2.0-flash` | `gpt-4o-mini` (chất lượng tốt hơn) |
| Giá sau free | Rẻ hơn | Đắt hơn một chút |
| Setup ở VN | Phức tạp | Đơn giản |

**Recommendation:** Dùng OpenAI cho dev/testing, chuyển sang Gemini khi production nếu muốn tiết kiệm chi phí.

---

## Troubleshooting

| Error | Cause | Fix |
|---|---|---|
| `403` unregistered caller | App running without key | Run with `--dart-define-from-file=dart-define.json` |
| `400` API key not valid | Wrong or malformed key | Re-copy key from AI Studio |
| `429` limit: 0 | Key from wrong project | Create new key using **Default Gemini Project** |
| `404` model not found | Model name deprecated | Use `gemini-2.0-flash` (1.5 models removed) |

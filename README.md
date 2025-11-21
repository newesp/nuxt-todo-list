# ✨ Todo AI - 現代化待辦事項應用

> 🎨 **Vibe Coding 練習專案** - 一個用來練習現代全端開發和 AI 輔助編程的小專案

<div align="center">

![Nuxt](https://img.shields.io/badge/Nuxt-3.x-00DC82?logo=nuxt.js&logoColor=white)
![Vue](https://img.shields.io/badge/Vue-3.x-4FC08D?logo=vue.js&logoColor=white)
![TypeScript](https://img.shields.io/badge/TypeScript-5.x-3178C6?logo=typescript&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-BaaS-3ECF8E?logo=supabase&logoColor=white)
![Vercel](https://img.shields.io/badge/Deployed-Vercel-000000?logo=vercel&logoColor=white)

**[Live Demo](https://nuxt-todo-list-delta.vercel.app)** | **[GitHub](https://github.com/newesp/nuxt-todo-list)**

</div>

---

## 📖 關於這個專案

這是一個專為練習 **Vibe Coding**（AI 輔助編程）而建立的全端應用程式。透過與 AI 協作，從零開始構建了一個功能完整、設計精美的待辦事項應用。

### 🎯 Vibe Coding 學習重點

- ✅ **AI 輔助設計**：使用 AI 快速迭代 UI/UX 設計
- ✅ **智能代碼生成**：讓 AI 協助生成 TypeScript 類型定義和組件
- ✅ **問題排查**：利用 AI 快速診斷和修復跨瀏覽器兼容性問題
- ✅ **最佳實踐**：透過 AI 建議學習 Nuxt 3 和 Vue 3 的最佳實踐
- ✅ **快速原型**：在幾小時內從概念到可部署的應用程式

---

## ✨ 功能特色

### 核心功能
- 🔐 **Google OAuth 登入** - 安全且便捷的身份驗證
- ✏️ **即時編輯** - 點擊任意待辦事項即可編輯
- 📅 **日期時間管理** - 為任務設定到期日期和時間
- ✅ **狀態追蹤** - 快速標記任務完成/未完成
- 🗑️ **刪除功能** - 一鍵刪除不需要的任務

### 設計亮點
- 🎨 **Apple 風格 UI** - 現代化的玻璃擬態設計
- 🌓 **深色模式** - 自動適應系統主題
- ✨ **流暢動畫** - 平滑的過渡和微交互
- 📱 **響應式設計** - 完美適配各種設備
- 🌐 **跨瀏覽器兼容** - 支持 Chrome、Firefox、Safari、Edge

### 技術特點
- ⚡ **實時同步** - 使用 Supabase Realtime
- 🔒 **RLS 安全** - Row Level Security 保護用戶數據
- 🚀 **SSR 支持** - Nuxt 3 服務端渲染
- 📦 **類型安全** - 完整的 TypeScript 支持

---

## 🛠️ 技術棧

### 前端
- **框架**: [Nuxt 3](https://nuxt.com/) - Vue.js 的全端框架
- **UI 庫**: [Nuxt UI](https://ui.nuxt.com/) - 現代化的 UI 組件庫
- **語言**: TypeScript
- **樣式**: Vanilla CSS + 自定義設計系統

### 後端/資料庫
- **BaaS**: [Supabase](https://supabase.com/)
  - PostgreSQL 資料庫
  - 內建身份驗證
  - Row Level Security (RLS)
  - 實時訂閱

### 部署
- **平台**: [Vercel](https://vercel.com/)
- **CI/CD**: GitHub Actions (自動部署)

---

## 🚀 快速開始

### 前置需求

- Node.js 18+ 
- npm 或 pnpm
- Supabase 帳號（免費）
- Google Cloud Console 帳號（用於 OAuth）

### 1️⃣ 克隆專案

```bash
git clone https://github.com/newesp/nuxt-todo-list.git
cd nuxt-todo-list
```

### 2️⃣ 安裝依賴

```bash
npm install
# 或
pnpm install
```

### 3️⃣ 設定環境變數

複製 `.env.example` 為 `.env`：

```bash
cp .env.example .env
```

填入你的 Supabase 憑證：

```env
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_KEY=your-anon-key
```

### 4️⃣ 設定資料庫

在 Supabase SQL Editor 中執行：

```sql
-- 創建 todos 表
create table todos (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users not null,
  title text not null,
  completed boolean default false,
  due_date timestamptz,
  created_at timestamptz default now()
);

-- 啟用 RLS
alter table todos enable row level security;

-- RLS 政策
create policy "Users can view own todos"
  on todos for select
  using (auth.uid() = user_id);

create policy "Users can insert own todos"
  on todos for insert
  with check (auth.uid() = user_id);

create policy "Users can update own todos"
  on todos for update
  using (auth.uid() = user_id);

create policy "Users can delete own todos"
  on todos for delete
  using (auth.uid() = user_id);
```

### 5️⃣ 配置 Google OAuth

1. 前往 [Google Cloud Console](https://console.cloud.google.com/apis/credentials)
2. 創建 OAuth 2.0 客戶端 ID
3. 添加授權重定向 URI：
   ```
   https://your-project.supabase.co/auth/v1/callback
   ```
4. 在 Supabase Dashboard → Authentication → Providers 中啟用 Google
5. 填入 Client ID 和 Client Secret

### 6️⃣ 啟動開發伺服器

```bash
npm run dev
```

訪問 http://localhost:3000 🎉

---

## 📦 部署到 Vercel

### 方法 1: 一鍵部署

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/newesp/nuxt-todo-list)

### 方法 2: 手動部署

1. 將專案推送到 GitHub
2. 在 [Vercel](https://vercel.com) 導入專案
3. 設定環境變數：
   ```
   SUPABASE_URL=https://your-project.supabase.co
   SUPABASE_KEY=your-anon-key
   ```
4. 部署！

### ⚠️ 重要：部署後設定

在 Supabase Dashboard → Settings → Authentication 中：

1. **Site URL** 改為你的 Vercel URL：
   ```
   https://your-app.vercel.app
   ```

2. **Redirect URLs** 添加：
   ```
   http://localhost:3000/login
   https://your-app.vercel.app/login
   ```

---

## 🎨 設計系統

### 色彩
- 主色調：藍色到紫色漸變
- 強調色：綠色（成功）、紅色（警告）、橙色（即將到期）

### 特效
- **玻璃擬態** (Glassmorphism)
- **柔和陰影**
- **平滑過渡動畫**
- **自定義 Checkbox**

### 響應式斷點
- Mobile: < 640px
- Tablet: 640px - 1024px
- Desktop: > 1024px

---

## 📁 專案結構

```
nuxt-todo-list/
├── app/
│   ├── assets/css/
│   │   └── style.css          # 設計系統和全局樣式
│   ├── layouts/
│   │   └── default.vue        # 主要佈局（header + slot）
│   ├── pages/
│   │   ├── index.vue          # Todo 列表頁
│   │   └── login.vue          # Google OAuth 登入頁
│   ├── middleware/
│   │   └── auth.ts            # 身份驗證中間件
│   ├── types/
│   │   └── database.types.ts  # Supabase 類型定義
│   ├── app.vue                # 根組件
│   └── app.html               # HTML 模板 + Critical CSS
├── public/                     # 靜態資源
├── .env.example               # 環境變數範例
├── nuxt.config.ts             # Nuxt 配置
├── package.json               # 依賴管理
└── README.md                  # 專案說明（你正在看的）
```

---

## 🧪 開發筆記

### 已知問題修復

1. **Firefox 日期選擇器** - 使用分離的 `date` + `time` 輸入框取代 `datetime-local`
2. **OAuth 重定向** - 動態獲取 URL 而不是硬編碼，支援多環境部署
3. **FOUC 問題** - 使用 Critical CSS 防止無樣式內容閃爍

### 學習資源

在專案開發過程中使用的資源：
- [Nuxt 3 文檔](https://nuxt.com/docs)
- [Supabase 文檔](https://supabase.com/docs)
- [Vue 3 組合式 API](https://vuejs.org/guide/extras/composition-api-faq.html)
- [MDN Web 文檔](https://developer.mozilla.org/)

---

## 🤝 貢獻

雖然這是個人練習專案，但歡迎：
- 🐛 回報 Bug
- 💡 提出新功能建議
- 🔧 提交 Pull Request

---

## 📝 授權

MIT License - 自由使用、修改和分發

---

## 👨‍💻 作者

**Vibe Coding Practitioner** 

透過 AI 輔助編程練習全端開發 🚀

---

## 🙏 致謝

- **Nuxt 團隊** - 出色的全端框架
- **Supabase 團隊** - 強大的開源 Firebase 替代方案
- **AI 助手** - 加速開發流程的最佳夥伴

---

<div align="center">

**⭐ 如果這個專案對你有幫助，請給個星星！**

Made with ❤️ and AI assistance

</div>

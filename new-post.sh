#!/bin/bash
# ================================================
# new-post.sh  ─  Astroブログ投稿ファイル自動生成
# 使い方:
#   bash new-post.sh
# ================================================

echo ""
echo "📝 新しい記事を作ります"
echo "──────────────────────────"

read -p "タイトル（日本語OK）: " TITLE
read -p "説明文（SEO用・一覧表示用）: " DESC
read -p "ファイル名スラッグ（英数字・ハイフンのみ 例: my-first-post）: " SLUG

# ── 日付・フォルダ ─────────────────────────────
DATE=$(date '+%Y-%m-%d')
OUTPUT_DIR="src/content/blog/${DATE}-${SLUG}"
INDEX_FILE="${OUTPUT_DIR}/index.md"
IMG_DIR="${OUTPUT_DIR}/images"

# フォルダ作成（記事フォルダ＋imagesフォルダ）
mkdir -p "$IMG_DIR"

# ── カバー画像の確認 ───────────────────────────
echo ""
echo "📷 カバー画像について"
echo "  写真ファイルを ${IMG_DIR}/cover.jpg としてコピーしますか？"
read -p "  画像ファイルのパスを入力（スキップする場合はEnter）: " IMG_SRC

if [ -n "$IMG_SRC" ] && [ -f "$IMG_SRC" ]; then
  cp "$IMG_SRC" "${IMG_DIR}/cover.jpg"
  COVER_LINE="coverImage: './images/cover.jpg'"
  echo "  ✅ 画像をコピーしました"
else
  COVER_LINE="# coverImage: './images/cover.jpg'"
  echo "  ⏭️  画像はスキップしました（後で images/ に cover.jpg を置いてください）"
fi

# ── index.md の生成 ────────────────────────────
cat > "$INDEX_FILE" << FRONTMATTER
---
title: '${TITLE}'
description: '${DESC}'
pubDate: '${DATE}'
# updatedDate: ''
${COVER_LINE}
---

FRONTMATTER

echo ""
echo "✅ 記事フォルダを作成しました"
echo ""
echo "  フォルダ : ${OUTPUT_DIR}/"
echo "  本文ファイル: ${INDEX_FILE}"
echo "  画像フォルダ: ${IMG_DIR}/"
echo ""
echo "次のステップ："
echo "  1. ${INDEX_FILE} を開いて本文を貼り付ける"
echo "  2. ローカルで確認 : npm run dev"
echo "  3. 公開          : git add . && git commit -m '記事追加: ${TITLE}' && git push"
echo ""

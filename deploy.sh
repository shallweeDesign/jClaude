#!/bin/bash
set -e

ROOT="$(dirname "$0")"
SRC="$ROOT/src"
OUTPUT="$ROOT/_output"
REPO="https://github.com/shallweeDesign/shallweeDesign.github.io.git"
GHPAGES="$(dirname "$ROOT")/shallweeDesign.github.io"

# ── Build ──────────────────────────────────────────────────
echo "🔨 Compiling SCSS..."
~/dart-sass/sass "$SRC/scss/main.scss" "$OUTPUT/style.css" --no-source-map --quiet

echo "📋 Copying files to _output/..."
mkdir -p "$OUTPUT/js"
cp "$SRC/index.html" "$OUTPUT/index.html"
rsync -a --delete "$SRC/js/" "$OUTPUT/js/"

# ── Deploy ─────────────────────────────────────────────────
echo "📦 Syncing to GitHub Pages repo..."
if [ ! -d "$GHPAGES/.git" ]; then
  git clone "$REPO" "$GHPAGES"
else
  git -C "$GHPAGES" pull --quiet
fi

rsync -a --delete "$OUTPUT/" "$GHPAGES/portfolio/"

echo "🚀 Committing and pushing..."
git -C "$GHPAGES" add portfolio/
if git -C "$GHPAGES" diff --cached --quiet; then
  echo "✅ Nothing changed, already up to date."
else
  git -C "$GHPAGES" commit -m "Deploy: $(date '+%Y-%m-%d %H:%M')"
  git -C "$GHPAGES" push
  echo "✅ Deployed to https://shallweedesign.github.io/portfolio/"
fi

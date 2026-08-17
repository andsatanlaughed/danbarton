#!/usr/bin/env bash
#
# Regenerate the page-snapshot thumbnails used as link buttons on follow.html.
#
# These are screenshots of *other people's* live pages, so they go stale when
# those pages get redesigned. Re-run this every few months, or whenever a card
# starts looking wrong:
#
#     ./tools/snapshots.sh && npm run build
#
# Requires: Google Chrome, cwebp (brew install webp), Python + Pillow.
#
# IMPORTANT: only ever point this at PUBLIC pages. Skool community feeds show
# real members' names, posts, and prayer requests — always use the /about page,
# never the feed. See the note in README.md.

set -euo pipefail
cd "$(dirname "$0")/.."

CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
[ -x "$CHROME" ] || { echo "Chrome not found at $CHROME" >&2; exit 1; }
command -v cwebp >/dev/null || { echo "cwebp not found — brew install webp" >&2; exit 1; }

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

# name|url|crop-box (left,top,right,bottom on the raw 1280x800 capture)
TARGETS=(
  "substack|https://substack.com/@drdanbarton209002|234,0,1280,588"
  "generational-revival|https://www.skool.com/generational-revival/about|80,104,1200,734"
  "kingdom-culture|https://www.skool.com/kingdomculture/about|80,148,1200,778"
  "tentmakers|https://www.skool.com/tentmakers/about|80,104,1200,734"
  "stewardpreneur|https://www.skool.com/the-stewardpreneur-network-2306/about|80,104,1200,734"
)

for entry in "${TARGETS[@]}"; do
  IFS='|' read -r name url box <<<"$entry"
  echo "→ $name"

  "$CHROME" --headless --disable-gpu --hide-scrollbars \
    --window-size=1280,800 --force-device-scale-factor=1 \
    --virtual-time-budget=9000 \
    --screenshot="$TMP/$name.png" "$url" 2>/dev/null

  [ -s "$TMP/$name.png" ] || { echo "  capture FAILED for $url" >&2; continue; }

  python3 - "$TMP/$name.png" "images/snap-$name.jpg" "$box" <<'PY'
import sys
from PIL import Image
src, dest, box = sys.argv[1], sys.argv[2], tuple(int(n) for n in sys.argv[3].split(","))
im = Image.open(src).convert("RGB").crop(box).resize((800, 450), Image.LANCZOS)
im.save(dest, quality=82, optimize=True, progressive=True)
PY

  cwebp -quiet -q 80 "images/snap-$name.jpg" -o "images/snap-$name.webp"
done

echo
echo "Done. Snapshots written to images/snap-*.{jpg,webp}"
ls -lh images/snap-* | awk '{print "  " $9, $5}'

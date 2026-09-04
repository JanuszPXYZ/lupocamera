#!/usr/bin/env bash
# launch.sh — flip the site from the pre-launch teaser to the full landing page.
#
# The full site lives on the `launch` branch, which GitHub Pages does not serve.
# This restores it onto `main`, which Pages does serve. Run it the day Lupo is
# approved, check the result, then commit and push.
#
#   ./launch.sh
#   git commit -am "Launch: full landing page"
#   git push
#
# To go back to the teaser:  git checkout <commit-before-launch> -- . && git commit

set -euo pipefail
cd "$(dirname "$0")"

BRANCH=launch

git rev-parse --verify --quiet "$BRANCH" >/dev/null || {
  echo "error: no '$BRANCH' branch — the full site is not stored anywhere." >&2
  exit 1
}

[ "$(git rev-parse --abbrev-ref HEAD)" = "main" ] || {
  echo "error: switch to main first (Pages deploys from main)." >&2
  exit 1
}

echo "Restoring the full site from '$BRANCH'…"
git checkout "$BRANCH" -- \
  index.html \
  support.html \
  assets/hold.jpg \
  assets/camera.jpg \
  assets/films.jpg

# Drop the teaser-only CSS block (everything from its marker to end of file).
if grep -q '^/\* ---------- teaser (pre-launch index only) ----------' style.css; then
  echo "Removing the teaser CSS block from style.css…"
  awk '/^\/\* ---------- teaser \(pre-launch index only\) ----------/{exit} {print}' \
    style.css | perl -0777 -pe 's/\n+\z/\n/' > style.css.tmp
  mv style.css.tmp style.css
  git add style.css
fi

cat <<'EOF'

Done. Still to do by hand before you push:

  1. Replace idXXXXXXXXX in index.html with the real App Store ID (2 places).
  2. Check the "Requires iOS 26" line matches your deployment target.
  3. Delete launch.sh — it has done its job:  git rm launch.sh
  4. Open the page locally, then:

       git commit -am "Launch: full landing page"
       git push

EOF

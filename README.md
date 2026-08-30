# Lupo — support site

Static support and legal pages for Lupo, built for GitHub Pages.

```
index.html      Landing  — App Store Connect "Marketing URL"
support.html    Support  — App Store Connect "Support URL"
privacy.html    Privacy  — App Store Connect "Privacy Policy URL"
terms.html      Terms    — link only; Apple's Standard EULA applies by default
style.css       Shared styles
assets/         Lupologo.png, Lupoicon_web.png, hold.jpg, camera.jpg, films.jpg (sources kept in ../ASC/)
.nojekyll       Serve files as-is, skip Jekyll processing
```

## Deploy

Live at **https://januszpxyz.github.io/lupocamera/** — a project site alongside
the `januszpxyz.github.io` user site (the blog). Pages is set to deploy from
`main` / `(root)`. Push to `main` to publish.

```bash
cd lupo-site
git init
git add -A
git commit -m "Lupo support site"
git branch -M main
git remote add origin https://github.com/JanuszPXYZ/lupocamera.git
git push -u origin main
```

Then in the repo: **Settings → Pages → Source: Deploy from a branch → `main` / `(root)`**.

Live a minute or two later at:

```
https://januszpxyz.github.io/lupocamera/                 ← Marketing URL
https://januszpxyz.github.io/lupocamera/support.html     ← Support URL
https://januszpxyz.github.io/lupocamera/privacy.html     ← Privacy Policy URL
https://januszpxyz.github.io/lupocamera/terms.html
```

All links are relative, so it works under the `/lupocamera/` subpath with no changes.

## Custom domain (optional)

Add a `CNAME` file containing the bare domain, then point DNS at GitHub:

```
lupocamera.com
```

- Apex: four `A` records → `185.199.108.153`, `185.199.109.153`, `185.199.110.153`, `185.199.111.153`
- Or `www` as a `CNAME` → `januszpxyz.github.io`

Once a custom domain is set, `januszpxyz.github.io/lupocamera/` 301-redirects to it,
so existing links keep working.

Enable **Enforce HTTPS** in Settings → Pages once the certificate is issued.

## Before submitting to App Review

- [ ] Replace `idXXXXXXXXX` in the two App Store links (`index.html`) with the real app ID
- [ ] Swap the custom download button for Apple's official App Store badge
- [ ] Confirm the "iOS 17 or later" line under the hero button matches your deployment target
- [ ] All URLs load in a private window with no login
- [ ] Contact email is monitored — reviewers sometimes test it
- [ ] Developing time in `support.html` matches the shipping build
- [ ] `PRIVACY.md` / `TERMS.md` in `ASC/` stay in sync with these pages

## Editing

The legal pages mirror `2DCam/ASC/PRIVACY.md` and `2DCam/ASC/TERMS.md` verbatim.
Change the markdown first, then port the edit here so the two don't drift.

## Typography

The stack is `"HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue",
Helvetica, Arial` at weight 300. Helvetica Neue is a licensed typeface and is
not embedded here — it resolves natively on macOS and iOS, and falls back to
Helvetica or Arial elsewhere. To make Windows and Android match, license a
webfont and self-host it in `assets/`, then add an `@font-face` rule at the top
of `style.css`.

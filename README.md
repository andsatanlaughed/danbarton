# danbarton.me

Static website for Dan Barton — *"Where you find all things Dan Barton."*

Four hand-built HTML pages styled with a locally compiled Tailwind CSS build. No
framework, no runtime — just static files you can host anywhere (Netlify, GitHub
Pages, S3, Cloudflare Pages, plain Apache/Nginx).

## Pages

| File           | Page    |
| -------------- | ------- |
| `index.html`   | Home    |
| `about.html`   | About   |
| `writing.html` | Writing |
| `connect.html` | Connect |

## Develop & Build

Tailwind is installed locally (no CDN). The CSS is compiled from
`src/input.css` to `style.css`.

```bash
npm install        # one time
npm run build      # compile + minify style.css for production
npm run watch      # rebuild style.css on change while developing
```

After editing any `.html` (which contain the Tailwind classes) or
`src/input.css`, re-run `npm run build`. Then open `index.html` in a browser, or
serve the folder:

```bash
python3 -m http.server 8000   # then visit http://localhost:8000
```

## Design system

- **Fonts:** Cormorant Garamond (display serif), Inter (body), Caveat (the
  handwritten "GUS" voice) — loaded via Google Fonts in each page `<head>`.
- **Palette:** warm cream `paper`, warm near-black `ink`, brand `red` + `gold`.
  Defined in `tailwind.config.js`; reusable component classes (`.btn-primary`,
  `.card`, `.eyebrow`, `.nav-link`, etc.) live in `src/input.css`.
- Shares its DNA with andsatanlaughed.com but has its own warmer, more personal
  face.

## Images

Optimized web assets live in `images/` (both `.webp` and `.jpg` fallbacks). They
were generated from the originals with `sips` + `cwebp`.

### Photo placeholders to replace

A few photos referenced in the copy weren't available yet. They render as styled
placeholders so the layout is complete — drop the real photos in and update the
markup:

- **Home hero, left frame** — the 1978 vintage photo of young Dan & Kathy.
  See the `TODO` comment in `index.html`.
- **About photo strip** — "The Early Years" (younger Dan, hearts backdrop).
  See `about.html`.

## Contact

The site is hosted on **GitHub Pages** (custom domain via the `CNAME` file →
`danbarton.me`), which serves static files only — so there's no server-side
form. The Connect page uses a `mailto:` link to **DRB@danbarton.me** instead.

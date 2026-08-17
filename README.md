# danbarton.me

Static website for Dan Barton — *"Where you find all things Dan Barton."*

Five hand-built HTML pages styled with a locally compiled Tailwind CSS build. No
framework, no runtime — just static files you can host anywhere (Netlify, GitHub
Pages, S3, Cloudflare Pages, plain Apache/Nginx).

## Pages

| File           | Page    |
| -------------- | ------- |
| `index.html`   | Home    |
| `about.html`   | About   |
| `writing.html` | Writing |
| `follow.html`  | Follow  |
| `connect.html` | Connect |

### Adding a new platform to the Follow page

`follow.html` collects Dan's off-site presence: the Substack newsletter and the
Skool communities. Dan posts a daily GROWTH CONCEPT across ~20 platforms, so the
list will grow. There's an HTML comment near the bottom of `follow.html`
(`MORE PLATFORMS GO HERE`) marking where new cards go — copy the markup pattern
from an existing Skool card, then re-run `npm run build`.

## Page snapshots (`images/snap-*`)

Each link on the Follow page is fronted by a screenshot of the destination page,
so the whole card acts as a visual button (`.snap-card` / `.snap-shot` in
`src/input.css`). Those screenshots are generated, not hand-made:

```bash
./tools/snapshots.sh    # recapture all five, write images/snap-*.{jpg,webp}
npm run build
```

Two things to know:

- **They go stale.** These are other people's live pages. When Skool or Substack
  redesigns, the thumbnails silently start looking wrong. Re-run the script every
  few months, or whenever a card looks off. Add new targets to the `TARGETS`
  array — each entry is `name|url|crop-box`, where the crop box is
  `left,top,right,bottom` against the raw 1280x800 capture. Keep the box 16:9
  (e.g. 1120x630) so it maps cleanly onto the 800x450 output.
- **Only ever capture PUBLIC pages.** A Skool *community feed* shows real
  members' names, posts, and prayer requests — never screenshot one. Always use
  the `/about` page. (Note that `skool.com/kingdomculture` redirects to the feed;
  the about page is `skool.com/kingdomculture/about`.)

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

- **About photo strip** — "The Early Years" (younger Dan, hearts backdrop).
  See `about.html`.

## Contact

The site is hosted on **GitHub Pages** (custom domain via the `CNAME` file →
`danbarton.me`), which serves static files only — so there's no server-side
form. The Connect page uses a `mailto:` link to **DRB@danbarton.me** instead.

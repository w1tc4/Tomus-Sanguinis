# Nerd Fonts Icon Collection — Project Plan

> A future project for this repo: build a browsable, organized collection of Nerd Font glyphs so my favorites (and eventually all of them) are easy to look up.

## Goal

Create a dedicated `nerdfonts` branch that holds multiple Markdown files. Each file groups icons **by what they actually depict** (animals, food, letters, weather, etc.) — NOT by which font set they came from. Every file is a table where I can visually see the glyph next to its codes.

## Table format

Each file is a Markdown table with these columns:

| Icon | Class | UTF | Hex |
|------|-------|-----|-----|
| (rendered glyph) | nf-md-bear | \xf0\x9f... | f063f |

- **Icon** = the actual rendered glyph so I can see it
- **Class** = the Nerd Fonts class name (e.g. `nf-md-bear`)
- **UTF** = the UTF-8 byte sequence
- **Hex** = the codepoint in hex

## Data source

All data comes from the official Nerd Fonts cheat sheet stylesheet:

`https://www.nerdfonts.com/assets/css/combo.css`

It defines every class as a rule like:

```css
.nf-cod-account:before{content:"\eb99"}
```

From the class name + hex codepoint you can derive the glyph (`String.fromCodePoint`), the UTF-8 bytes, and keep the hex. There are ~10,764 icons total.

## Two phases

1. **Favorites first (the original idea):** I send icons I like (class name or hex from the cheat-sheet copy buttons) and they get added to the right category file.
2. **Eventually: all of them**, fully sorted into subject files.

## Proposed subject categories (starting reference)

Grouped by what the icon depicts. Counts are approximate, from a keyword pass over the class names:

| Category | ~Count | Category | ~Count |
|----------|--------|----------|--------|
| arrows | 653 | money-shopping | 187 |
| devices-tech | 638 | numbers | 184 |
| files-folders | 520 | security | 180 |
| ui-controls | 513 | transport | 177 |
| people-body | 432 | time | 168 |
| symbols-signs | 427 | maps-location | 162 |
| weather | 351 | letters | 133 |
| shapes | 324 | nature-plants | 110 |
| media | 320 | lighting | 91 |
| text-format | 312 | animals | 88 |
| brands-logos | 293 | faces-emoji | 84 |
| code-dev | 246 | charts-data | 57 |
| food-drink | 225 | books-edu | 54 |
| games | 222 | misc (leftover/abstract) | ~3,425 |
| communication | 188 | | |

## Notes / open questions for later

- Categories are derived from keywords in each icon's class name, so it's a good first pass but not perfect — some icons will need manual re-filing.
- The `misc` bucket is large (~3,400) and holds abstract glyphs that don't map cleanly to a subject. Could be split further or left as-is.
- The Material Design set (`nf-md-*`) is by far the biggest source and feeds most categories.
- Decide whether to refine/rename/merge any categories before generating files.

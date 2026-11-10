"""Local screenshot inventory and gallery; never connects to or modifies a phone."""
import argparse
import collections
import hashlib
import html
import json
import re
from datetime import date
from pathlib import Path
from urllib.parse import quote

ROOT = Path(__file__).resolve().parent


def scan(args):
    from PIL import Image, ImageDraw, ImageOps

    if (ROOT / 'items.json').exists():
        old = json.loads((ROOT / 'items.json').read_text())
        if any(item['intake'] == args.intake and
               any(frame.get('retention') == 'removed-after-extraction' for frame in item['frames'])
               for item in old['items']):
            raise SystemExit('This intake was reduced after extraction; preserve its original inventory. '
                             'Use render or scan a new intake.')
    source = ROOT / 'media' / args.intake
    output = ROOT / 'private' / args.intake
    output.mkdir(parents=True, exist_ok=True)
    rows = []
    for path in sorted(source.iterdir()):
        if not path.is_file():
            continue
        match = re.search(r'Screenshot_(\d{4}-\d{2}-\d{2})', path.name)
        state = 'non-screenshot'
        if match:
            state = 'candidate' if args.start <= match[1] <= args.end else 'out-of-window'
        if path.name.startswith('.trashed'):
            state = 'trashed-excluded'
        rows.append(dict(name=path.name, date=match[1] if match else None,
                         state=state, sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                         size=path.stat().st_size))
    candidates = [row for row in rows if row['state'] == 'candidate']
    for index, row in enumerate(candidates, 1):
        row['id'] = f'S{index:03}'
    (output / 'inventory.json').write_text(json.dumps(rows, indent=2) + '\n')
    for offset in range(0, len(candidates), 24):
        sheet = Image.new('RGB', (1560, 2440), '#dedede')
        draw = ImageDraw.Draw(sheet)
        for index, row in enumerate(candidates[offset:offset + 24]):
            x, y = index % 6 * 260, index // 6 * 610
            with Image.open(source / row['name']) as original:
                preview = ImageOps.exif_transpose(original)
                preview.thumbnail((252, 570))
                sheet.paste(preview, (x + (260 - preview.width) // 2, y + 28))
            draw.text((x + 5, y + 4), row['id'] + ' ' + row['date'], fill='black')
        sheet.save(output / f'sheet-{offset // 24 + 1:02}.jpg')
    print(json.dumps(collections.Counter(row['state'] for row in rows)))


def render(args):
    data = json.loads((ROOT / 'items.json').read_text())
    items = [item for item in data['items'] if item['intake'] == args.intake]
    esc = html.escape
    body = ['<!doctype html><meta charset="utf-8"><title>Technical clippings</title>',
            '<style>body{font:17px system-ui;max-width:1200px;margin:2em auto;padding:1em}'
            'img{width:200px;max-height:470px;object-fit:contain;background:#eee}'
            'nav a{margin-right:1em}article{border-top:1px solid #aaa;margin:2em 0}'
            'summary{cursor:pointer}a{overflow-wrap:anywhere}</style>',
            '<h1>Technical clippings</h1><p>Local review. Images remain Git-ignored.</p>']
    counts = collections.Counter(item['theme'] for item in items)
    body.append('<nav>' + ' '.join(f'<a href="#{esc(theme)}">{esc(theme)} ({n})</a>'
                                 for theme, n in sorted(counts.items())) + '</nav>')
    for theme in sorted(counts):
        body.append(f'<h2 id="{esc(theme)}">{esc(theme)}</h2>')
        for item in (item for item in items if item['theme'] == theme):
            body.append(f'<article><h3>{esc(item["id"])} — {esc(item["title"])}</h3>')
            for key in ('claim', 'assessment', 'next'):
                body.append(f'<p><b>{key.title()}:</b> {esc(item[key])}</p>')
            body.append(f'<p>Evidence: {esc(item["status"])}</p>')
            if item.get('knowledge_note'):
                body.append(f'<p><a href="{esc("../" + item["knowledge_note"], quote=True)}">'
                            'Extracted knowledge / disposition</a></p>')
            for index, url in enumerate(item['sources'], 1):
                body.append(f'<a href="{esc(url, quote=True)}">Primary source {index}</a> ')
            frames = [frame for frame in item['frames']
                      if frame.get('retention') != 'removed-after-extraction']
            if not frames:
                body.append('<p>Images removed after extraction; provenance remains in the catalog.</p></article>')
                continue
            folder = ROOT / 'media' / 'sorted' / args.intake / theme / item['id']
            folder.mkdir(parents=True, exist_ok=True)
            for frame in frames:
                original = ROOT / 'media' / args.intake / frame['file']
                assert hashlib.sha256(original.read_bytes()).hexdigest() == frame['sha256'], original
                link = folder / (frame['id'] + original.suffix)
                if link.is_symlink():
                    assert link.resolve() == original.resolve(), link
                else:
                    assert not link.exists(), link
                    link.symlink_to(Path('../../../../') / args.intake / frame['file'])
                assert link.resolve() == original.resolve(), link
            cover = frames[0]
            body.append(f'<a href="{quote(args.intake + "/" + cover["file"])}">'
                        f'<img loading="lazy" src="{quote(args.intake + "/" + cover["file"])}" '
                        f'alt="{esc(item["title"], quote=True)}"></a><details><summary>'
                        f'{len(frames)} retained frames</summary>')
            for frame in frames:
                body.append(f'<a href="{quote(args.intake + "/" + frame["file"])}">'
                            f'{esc(frame["id"])}</a> ')
            body.append('</details></article>')
    (ROOT / 'media' / 'index.html').write_text('\n'.join(body))
    catalog(data)
    print(f'{len(items)} items; gallery: {ROOT / "media/index.html"}')


def catalog(data):
    items = data['items']
    lines = ['# Technical clippings catalog', '',
             f'{len(items)} grouped items, {sum(len(item["frames"]) for item in items)} historical frame records '
             '(removed images are labeled below).', '',
             'Claims are screenshot paraphrases. Source-confirmed means a matching primary page was read '
             'on the recorded review date; it does not mean independently reproduced or tested.', '',
             '[Local visual gallery](media/index.html) · [Plan](PLAN.md) · [Item data](items.json)', '',
             'S-numbers are intake-local. Filenames and SHA-256 values in items.json identify the images.', '']
    for theme in sorted({item['theme'] for item in items}):
        lines.extend(['## ' + theme, ''])
        for item in (item for item in items if item['theme'] == theme):
            lines.extend([f'### {item["id"]} — {item["title"]}', '',
                          f'Captured: {", ".join(item["capture_dates"])} · Reviewed: {item["review_date"]} '
                          f'· **{item["status"]}**', f'Screenshot source: {item["captured_from"]}.', ''])
            for field, label in [('claim', 'Captured claim'), ('assessment', 'Assessment'), ('next', 'Next')]:
                lines.extend([f'**{label}:** {item[field]}', ''])
            if item.get('knowledge_note'):
                lines.extend([f'**Extraction:** {item["knowledge_disposition"]} · '
                              f'[Knowledge note]({item["knowledge_note"]})', ''])
            if item['sources']:
                lines.extend(['**Checked primary sources:** ' + ' · '.join(
                    f'[Source {index}]({url})' for index, url in enumerate(item['sources'], 1)), ''])
            lines.extend(['**Local frames:** ' + ', '.join(
                (f'{frame["id"]} (removed after extraction)' if
                 frame.get('retention') == 'removed-after-extraction' else
                 f'[{frame["id"]}](media/{item["intake"]}/{quote(frame["file"])})')
                for frame in item['frames']), ''])
    path = ROOT / 'CATALOG.md'
    body = '\n'.join(lines)
    previous = path.read_text() if path.exists() else ''
    if previous.startswith('---\n'):
        metadata, separator, old_body = previous[4:].partition('\n---\n')
        if not separator:
            raise ValueError('CATALOG.md has unclosed frontmatter; refusing to replace it')
        if old_body.lstrip('\n') == body:
            return
        metadata, count = re.subn(r'^updated:.*$', f"updated: '{date.today().isoformat()}'",
                                  metadata, flags=re.MULTILINE)
        if not count:
            metadata += f"\nupdated: '{date.today().isoformat()}'"
    else:
        metadata = ('title: Technical clippings catalog\nscope: technical-clippings\n'
                    f"kind: backlog-index\nupdated: '{date.today().isoformat()}'")
    path.write_text('---\n' + metadata + '\n---\n\n' + body)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('action', choices=['scan', 'render'])
    parser.add_argument('--intake', required=True, help='Intake folder name, YYYY-MM-DD')
    parser.add_argument('--start', help='First capture date, YYYY-MM-DD')
    parser.add_argument('--end', help='Last capture date, YYYY-MM-DD')
    args = parser.parse_args()
    for value in (args.intake, args.start, args.end):
        if value is not None and not re.fullmatch(r'\d{4}-\d{2}-\d{2}', value):
            parser.error('Use dates in YYYY-MM-DD form')
    if args.action == 'scan' and (not args.start or not args.end or args.start > args.end):
        parser.error('scan requires --start <= --end')
    (scan if args.action == 'scan' else render)(args)

#!/usr/bin/env python3
"""harvest-upload.py — tiny upload server for phone → harvest/<week>/
Listens on Tailscale IP only. Phone opens the URL in browser, picks files, done.
No cgi module — pure stdlib (Python 3.13+).
"""
import http.server, os, datetime, re

HARVEST_ROOT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "harvest")
PORT = 8033
BIND = "0.0.0.0"

HTML = """<!DOCTYPE html>
<html><head>
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>harvest drop</title>
<style>
  body { font-family: system-ui; max-width: 480px; margin: 2em auto; padding: 0 1em;
         background: #1a1a2e; color: #e0e0e0; }
  h2 { color: #e94560; }
  .ok { color: #0f3460; background: #16db93; padding: 1em; border-radius: 8px;
        font-weight: bold; margin: 1em 0; }
  input[type=file] { display: block; margin: 1em 0; font-size: 1.1em; }
  button { background: #e94560; color: white; border: none; padding: 0.8em 2em;
           font-size: 1.2em; border-radius: 8px; cursor: pointer; }
  button:active { background: #c81e45; }
  .info { color: #888; font-size: 0.9em; }
</style>
</head><body>
<h2>\U0001f4f8 harvest drop</h2>
<p class="info">Week: <strong>WEEK_PLACEHOLDER</strong></p>
RESULT_PLACEHOLDER
<form method="POST" enctype="multipart/form-data">
  <input type="file" name="shots" multiple accept="image/*">
  <button type="submit">⬆ Upload</button>
</form>
<p class="info">Screenshots land in <code>harvest/WEEK_PLACEHOLDER/</code></p>
</body></html>"""


def week_str():
    iso = datetime.date.today().isocalendar()
    return f"{iso[0]}-W{iso[1]:02d}"


def parse_multipart(body: bytes, boundary: bytes):
    """Minimal multipart/form-data parser — no cgi module needed."""
    parts = body.split(b"--" + boundary)
    files = []
    for part in parts:
        if b"Content-Disposition" not in part:
            continue
        # Split headers from body at first \r\n\r\n
        idx = part.find(b"\r\n\r\n")
        if idx == -1:
            continue
        headers_raw = part[:idx].decode("utf-8", errors="replace")
        file_data = part[idx + 4:]
        # Strip trailing \r\n
        if file_data.endswith(b"\r\n"):
            file_data = file_data[:-2]
        # Extract filename
        m = re.search(r'filename="([^"]+)"', headers_raw)
        if not m:
            continue
        filename = m.group(1)
        if not filename:
            continue
        files.append((filename, file_data))
    return files


class Handler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        page = HTML.replace("WEEK_PLACEHOLDER", week_str()).replace("RESULT_PLACEHOLDER", "")
        self.send_response(200)
        self.send_header("Content-Type", "text/html; charset=utf-8")
        self.end_headers()
        self.wfile.write(page.encode())

    def do_POST(self):
        content_type = self.headers.get("Content-Type", "")
        m = re.search(r"boundary=(.+)", content_type)
        if not m:
            self.send_error(400, "No boundary")
            return
        boundary = m.group(1).strip().encode()

        length = int(self.headers.get("Content-Length", 0))
        body = self.rfile.read(length)

        files = parse_multipart(body, boundary)

        week = week_str()
        dest = os.path.join(HARVEST_ROOT, week)
        os.makedirs(dest, exist_ok=True)

        saved = []
        for filename, data in files:
            ts = datetime.datetime.now().strftime("%H%M%S")
            safe_name = os.path.basename(filename).replace(" ", "_")
            target = os.path.join(dest, f"{ts}_{safe_name}")
            n = 0
            while os.path.exists(target):
                n += 1
                target = os.path.join(dest, f"{ts}_{n}_{safe_name}")
            with open(target, "wb") as f:
                f.write(data)
            saved.append(safe_name)

        result = f'<div class="ok">✓ {len(saved)} file(s) → {week}/</div>'
        page = HTML.replace("WEEK_PLACEHOLDER", week).replace("RESULT_PLACEHOLDER", result)
        self.send_response(200)
        self.send_header("Content-Type", "text/html; charset=utf-8")
        self.end_headers()
        self.wfile.write(page.encode())

    def log_message(self, fmt, *args):
        ts = datetime.datetime.now().strftime("%H:%M:%S")
        print(f"{ts} {args[0]}")


if __name__ == "__main__":
    print(f"harvest-upload listening on http://{BIND}:{PORT}")
    print(f"  current week: {week_str()}")
    print(f"  harvest root: {HARVEST_ROOT}")
    print(f"\n\U0001f4f1 On phone browser: http://{BIND}:{PORT}\n")
    srv = http.server.HTTPServer((BIND, PORT), Handler)
    try:
        srv.serve_forever()
    except KeyboardInterrupt:
        print("\nstopped")

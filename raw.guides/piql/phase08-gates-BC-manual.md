<!-- PUBLISHED MIRROR · do not edit here · source: piql.dev/guides/phase08-gates-BC-manual.md · regenerate with: sync-guides -->

# Phase 8 — Gates B + C — run on office box (interactive SSH)

Connect first:
```bash
ssh -t office
```

Then paste in order:

## Gate B — Install Ollama

```bash
sudo pacman -S --noconfirm ollama
ollama --version
```

## Gate C — systemd config (loopback bind)

```bash
sudo mkdir -p /etc/systemd/system/ollama.service.d
sudo tee /etc/systemd/system/ollama.service.d/override.conf > /dev/null <<EOF
[Service]
Environment="OLLAMA_HOST=127.0.0.1:11434"
Environment="OLLAMA_KEEP_ALIVE=15m"
Environment="OLLAMA_NUM_PARALLEL=1"
Environment="OLLAMA_MAX_LOADED_MODELS=2"
MemoryMax=12G
MemoryHigh=10G
EOF
sudo systemctl daemon-reload
sudo systemctl enable ollama.service
sudo systemctl restart ollama.service
sleep 3 && systemctl status ollama.service --no-pager
ss -tlnp | grep 11434
```

CRITICAL: ss output must show 127.0.0.1:11434 — NOT 0.0.0.0:11434.

## Gate D — Pull Qwen3 4B (~3 GB, takes a few minutes)

```bash
ollama pull qwen3:4b
ollama list
```

## Done — report back to @Vara

Once ollama list shows qwen3:4b, come back to the home machine.
Gates E + F (inference test + API curl) will run non-interactively over SSH.

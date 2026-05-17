# 🚀 Hermes Agent — Railway Template

One-click Railway deployment for [Hermes Agent](https://hermes-agent.nousresearch.com) by NousResearch.

Runs the agent as a persistent **gateway** (Telegram, Discord, Slack, WhatsApp) with an optional web dashboard — all in a single Railway service backed by a persistent volume.

---

## What’s included

| File | Purpose |
|---|---|
| `railway.toml` | Build & deploy config for Railway |
| `Dockerfile` | Thin wrapper re-using the official `nousresearch/hermes-agent` image |
| `docker-compose.yml` | Local development mirror of the Railway setup |
| `.env.example` | All supported environment variables with inline docs |
| `scripts/setup.sh` | First-run bootstrap helper (run once via Railway shell or locally) |

---

## Quick start

### 1. Use this template

```bash
gh repo create my-hermes --template aeither/hermes-railway --public
cd my-hermes
```

### 2. Create a Railway project

```bash
npm i -g @railway/cli
railway login
railway init
```

### 3. Add a Volume

Railway dashboard → your service → **Volumes** tab:
- Mount path: `/opt/data`
- Recommended size: **2 GB**

### 4. Set environment variables

Copy `.env.example`, fill in your keys, paste into Railway → **Variables**.

Minimum:
```
ANTHROPIC_API_KEY=sk-ant-...
```

For Telegram:
```
TELEGRAM_BOT_TOKEN=123456:ABC...
```

### 5. Deploy

```bash
railway up
```

---

## Ports

| Port | Service | Enable with |
|---|---|---|
| `8642` | OpenAI-compatible API + health endpoint | `API_SERVER_ENABLED=true` |
| `9119` | Web dashboard | `HERMES_DASHBOARD=1` |

Set `PORT=8642` in Railway Variables so the platform health-check routes correctly.

---

## Multi-profile setup

Create two separate Railway services, each with its own volume:

```
hermes-work     → /opt/data volume
hermes-personal → /opt/data volume (separate service)
```

---

## Local development

```bash
cp .env.example .env
docker compose up
```

- Dashboard: http://localhost:9119
- API health: http://localhost:8642/health

---

## Upgrading

Change the image tag in `Dockerfile` and redeploy. `/opt/data` is untouched.

---

## Troubleshooting

| Symptom | Fix |
|---|---|
| Container exits immediately | Check Railway logs. Usually missing `.env` key. |
| `Permission denied` on `/opt/data` | Set `HERMES_UID`/`HERMES_GID` or `chmod -R 755 /opt/data` in shell. |
| Dashboard not loading | Ensure `HERMES_DASHBOARD=1` and port `9119` is exposed. |
| Browser tools not working | Add `BROWSERLESS_API_KEY` for remote Chromium; local `--shm-size` not settable on Railway. |

---

## License

MIT — thin deployment wrapper. Hermes Agent is licensed by NousResearch.

# Full Client Acquisition Stack

This stack includes:
- CRM (EspoCRM)
- Workflow Automation (n8n)
- Analytics (PostHog + ClickHouse)

## Quick Setup

```bash
./setup.sh
```

## Manual Setup

1. Ensure Docker is installed
2. Copy `.env.example` to `.env` and update credentials
3. Run: `cd Docker && docker compose up -d`

## Service URLs

- CRM: http://localhost:8080
- n8n: http://localhost:5678
- PostHog: http://localhost:8000
- ClickHouse: http://localhost:8123

## Utility Scripts

- `./scripts/status.sh` - Check service status
- `./scripts/stop.sh` - Stop all services
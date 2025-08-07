# Full Client Acquisition Stack

Complete auto-prospecting, marketing, and sales automation stack:

**Core Services:**
- CRM (EspoCRM) - Lead & customer management
- Workflow Automation (n8n) - Process orchestration
- Social Media (Mixpost) - Multi-platform posting
- Analytics (PostHog + ClickHouse) - Tracking & insights
- Lead Scoring (AI-powered) - Automated qualification

**Communication Channels:**
- Voice Calls (Twilio) - Automated cold calling
- SMS Marketing (Twilio) - Text message campaigns
- WhatsApp Business - Direct messaging
- Chatbots (Botpress) - 24/7 lead qualification
- Email Sequences (Instantly.ai + Lemlist)

**Content Creation:**
- AI Video Generation (Local Ollama + MoviePy)
- Voice Synthesis (Whisper + gTTS)
- YouTube Auto-Upload & Distribution
- Multi-platform Social Posting
- Personalized Content at Scale

**Integrations:**
- Apollo.io - Prospect discovery
- Clay - Data enrichment
- Calendly - Meeting scheduling
- Slack - Team notifications
- LinkedIn - Profile automation
- TikTok, Instagram, Facebook - Viral distribution

## One-Click Deployment

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/your-username/client-acquisition)

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/your-template)

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy?repo=https://github.com/your-username/client-acquisition)

[![Deploy to Netlify](https://www.netlify.com/img/deploy/button.svg)](https://app.netlify.com/start/deploy?repository=https://github.com/your-username/client-acquisition)

## Quick Setup (Local)

```bash
./setup.sh
```

## Manual Setup

1. Ensure Docker is installed
2. Copy `.env.example` to `.env` and update credentials
3. Run: `cd Docker && docker compose up -d`

## Service URLs

- **CRM:** http://localhost:8080
- **n8n Automation:** http://localhost:5678
- **Mixpost Social:** http://localhost:8081
- **Botpress Chatbot:** http://localhost:3000
- **PostHog Analytics:** http://localhost:8000
- **ClickHouse:** http://localhost:8123
- **Ollama AI:** http://localhost:11434
- **Whisper Voice:** http://localhost:9000
- **PostgreSQL:** localhost:5432
- **Redis:** localhost:6379

## Automation Features

- **Auto-Prospecting:** Apollo → Clay enrichment → Lead scoring → Campaign assignment
- **Omnichannel Outreach:** Email, SMS, Calls, WhatsApp based on lead score
- **Video Personalization:** AI-generated videos for high-value prospects
- **Viral Distribution:** Auto-upload to YouTube + cross-platform sharing
- **Voice Automation:** Text-to-speech for calls and video narration
- **Chatbot Qualification:** 24/7 lead capture and initial screening
- **Social Automation:** Multi-platform posting with prospect targeting
- **Lead Nurturing:** Automated follow-ups across all channels
- **Meeting Booking:** Calendly integration for qualified prospects
- **Real-time Scoring:** AI-powered lead qualification and prioritization

## Zero-Cost Operation

- **Local AI:** Ollama (free ChatGPT alternative)
- **Voice Processing:** Whisper (free speech-to-text)
- **Video Creation:** MoviePy + gTTS (no external APIs)
- **Free Tiers:** WhatsApp Business, YouTube, social platforms
- **Self-hosted:** All core services run locally

## Cloud Deployment

### Gitpod (Recommended)
- ✅ One-click deployment
- ✅ Pre-configured environment
- ✅ Public URLs for webhooks
- ✅ 50 hours/month free

### Railway
- ✅ Free tier: $5 credit
- ✅ Automatic subdomain
- ✅ PostgreSQL included
- ✅ Zero config deployment

### Render
- ✅ Free tier available
- ✅ Managed PostgreSQL
- ✅ Auto-deploy from Git
- ✅ Custom domains

### Netlify + Vercel (Serverless)
- ✅ Free static hosting
- ✅ Serverless functions
- ✅ Global CDN
- ✅ Custom domains

## Utility Scripts

- `./scripts/status.sh` - Check service status
- `./scripts/stop.sh` - Stop all services
- `./scripts/deploy-setup.sh` - Configure for cloud deployment
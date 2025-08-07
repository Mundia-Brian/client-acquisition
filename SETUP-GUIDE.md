# Complete Brand Setup Guide

## Prerequisites
- Docker & Docker Compose installed
- Domain name (optional but recommended)
- Phone number for business use

## Step 1: Initial Setup
```bash
git clone <your-repo>
cd client-acquisition
./setup.sh
```

## Step 2: Configure Environment
Copy `.env.example` to `.env` and fill in:

### Required (Free Tiers Available)
```bash
# Basic Auth
N8N_BASIC_AUTH_USER=your_username
N8N_BASIC_AUTH_PASSWORD=strong_password

# Database
POSTGRES_PASSWORD=secure_db_password
REDIS_PASSWORD=secure_redis_password

# CRM
CRM_ADMIN_EMAIL=admin@yourbrand.com
CRM_ADMIN_PASSWORD=secure_crm_password
```

### Communication Setup
```bash
# Twilio (Free trial: $15 credit)
TWILIO_ACCOUNT_SID=ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
TWILIO_AUTH_TOKEN=your_auth_token
TWILIO_PHONE_NUMBER=+1234567890

# WhatsApp Business (Free)
WHATSAPP_TOKEN=your_whatsapp_business_token
WHATSAPP_PHONE_ID=your_phone_number_id
```

### Social Media APIs
```bash
# YouTube (Free)
YOUTUBE_CLIENT_ID=your_youtube_client_id
YOUTUBE_CLIENT_SECRET=your_youtube_secret
YOUTUBE_REFRESH_TOKEN=your_refresh_token

# Social Platforms (Free tiers)
LINKEDIN_SESSION_COOKIE=your_linkedin_session
FACEBOOK_ACCESS_TOKEN=your_facebook_token
INSTAGRAM_ACCESS_TOKEN=your_instagram_token
```

### Prospecting Tools
```bash
# Apollo.io (Free: 50 credits/month)
APOLLO_API_KEY=your_apollo_key

# Clay (Free: 100 credits/month)
CLAY_API_KEY=your_clay_key

# Instantly.ai (Free trial)
INSTANTLY_API_KEY=your_instantly_key
INSTANTLY_WORKSPACE_ID=your_workspace_id
```

## Step 3: Setup AI Models (Zero Cost)
```bash
./scripts/setup-ollama.sh
```

## Step 4: Import Workflows
```bash
./scripts/import-workflows.sh
```

## Step 5: Configure Services

### A. CRM Setup (http://localhost:8080)
1. Login with credentials from `.env`
2. Create custom fields:
   - Lead Score (Integer)
   - Source (Dropdown: Apollo, Clay, Manual)
   - Last Contacted (Date)
3. Setup lead statuses: New → Contacted → Engaged → Qualified → Customer

### B. n8n Automation (http://localhost:5678)
1. Login with credentials from `.env`
2. Activate imported workflows:
   - Auto Prospecting Pipeline
   - Omnichannel Outreach
   - Lead Nurture Sequence
   - Social Automation
   - Viral Content Distribution
3. Test webhook endpoints

### C. Mixpost Social (http://localhost:8081)
1. Connect social accounts:
   - LinkedIn Business
   - Facebook Page
   - Instagram Business
   - Twitter/X
   - TikTok Business
2. Setup posting schedules
3. Create content templates

### D. Botpress Chatbot (http://localhost:3000)
1. Create qualification bot
2. Setup lead capture forms
3. Configure webhook to n8n: `http://n8n:5678/webhook/botpress`

## Step 6: Brand Customization

### Video Templates
Edit `/video-creator/templates/`:
```python
# Brand colors, logo, messaging
BRAND_COLORS = {'primary': '#your_color', 'secondary': '#your_color'}
BRAND_LOGO = '/app/assets/logo.png'
BRAND_MESSAGE = "Your unique value proposition"
```

### Email Templates
Edit `/n8n-flows/email-templates.json`:
```json
{
  "cold_outreach": "Hi {{firstName}}, saw your work at {{company}}...",
  "follow_up": "Following up on my message about {{value_prop}}...",
  "meeting_request": "Would love to show you how we helped {{similar_company}}..."
}
```

### SMS Templates
Edit `/comm-hub/sms_templates.py`:
```python
TEMPLATES = {
    'cold': "Hi {name}! Quick question about {company}'s {pain_point}. 30sec to chat?",
    'follow_up': "Hey {name}, following up on {topic}. Still relevant?",
    'meeting': "Perfect! Here's my calendar: {calendly_link}"
}
```

## Step 7: Prospect Data Setup

### Import Existing Leads
```sql
-- Connect to PostgreSQL (localhost:5432)
INSERT INTO prospects (email, first_name, last_name, company, title, source)
VALUES 
('john@company.com', 'John', 'Doe', 'Company Inc', 'CEO', 'manual'),
('jane@startup.com', 'Jane', 'Smith', 'Startup LLC', 'CTO', 'manual');
```

### Apollo Integration
1. Setup Apollo webhook: `http://your-domain:5678/webhook/apollo`
2. Create saved searches in Apollo
3. Enable auto-sync to webhook

### Clay Integration
1. Setup Clay table with prospect data
2. Configure enrichment workflows
3. Connect to n8n webhook: `http://your-domain:5678/webhook/clay`

## Step 8: Campaign Launch

### Test Sequence
1. Add test prospect with high score (90+)
2. Verify call automation triggers
3. Check video creation and YouTube upload
4. Confirm social media distribution
5. Test chatbot qualification flow

### Production Launch
1. Import prospect list (CSV upload to CRM)
2. Activate all n8n workflows
3. Monitor PostHog analytics (http://localhost:8000)
4. Check interaction logs in database

## Step 9: Monitoring & Optimization

### Key Metrics Dashboard
- Lead score distribution
- Channel response rates (email/SMS/calls)
- Video engagement rates
- Conversion funnel metrics
- Cost per acquisition

### Daily Checks
```bash
./scripts/status.sh  # Check all services
```

### Weekly Optimization
1. Review top-performing content
2. Adjust lead scoring algorithm
3. Update email/SMS templates based on responses
4. Optimize video creation prompts

## Step 10: Scaling

### Zero-Cost Scaling
- Use Ollama for unlimited AI content generation
- Leverage free social media APIs
- Maximize free tier limits across all tools
- Self-host everything to avoid recurring costs

### Paid Scaling (Optional)
- Upgrade Twilio for higher call volumes
- Add premium Apollo/Clay credits
- Use paid social media advertising
- Add team members to CRM

## Troubleshooting

### Common Issues
```bash
# Services not starting
docker-compose down && docker-compose up -d

# Database connection issues
docker exec -it postgres psql -U postgres -d leads

# n8n workflows not triggering
Check webhook URLs and authentication

# Video creation failing
Verify Ollama models are downloaded
```

### Support
- Check service logs: `docker-compose logs [service_name]`
- Database queries: Connect to PostgreSQL on localhost:5432
- API testing: Use Postman with provided endpoints

## Success Metrics
- 50+ prospects contacted daily (automated)
- 15-20% email open rates
- 5-8% SMS response rates
- 2-3% call connection rates
- 1-2 qualified meetings per week
- $0 ongoing operational costs (using free tiers)

This setup provides a complete, automated client acquisition system that runs perpetually with minimal ongoing costs.
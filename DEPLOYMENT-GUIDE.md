# Cloud Deployment Guide

## 🚀 One-Click Deployments

### Gitpod (Recommended for Development)
[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/your-username/client-acquisition)

**Benefits:**
- ✅ 50 hours/month free
- ✅ Pre-configured environment
- ✅ Public URLs for webhooks
- ✅ Full Docker support

**Setup:**
1. Click the Gitpod button
2. Wait for automatic setup (5-10 minutes)
3. Access services via the ports panel
4. Configure API keys in `.env`

### Railway (Best for Production)
[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/your-template)

**Benefits:**
- ✅ $5 free credit monthly
- ✅ Automatic PostgreSQL
- ✅ Custom subdomains
- ✅ Zero-config deployment

**Setup:**
1. Click Railway button
2. Connect GitHub account
3. Set environment variables
4. Deploy automatically

### Render (Free Tier)
[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy?repo=https://github.com/your-username/client-acquisition)

**Benefits:**
- ✅ Free tier available
- ✅ Managed databases
- ✅ Auto-deploy from Git
- ✅ SSL certificates

**Setup:**
1. Click Render button
2. Connect repository
3. Configure build settings
4. Add environment variables

### Netlify (Serverless)
[![Deploy to Netlify](https://www.netlify.com/img/deploy/button.svg)](https://app.netlify.com/start/deploy?repository=https://github.com/your-username/client-acquisition)

**Benefits:**
- ✅ Free static hosting
- ✅ Serverless functions
- ✅ Global CDN
- ✅ Custom domains

**Setup:**
1. Click Netlify button
2. Authorize GitHub access
3. Configure build settings
4. Add environment variables

## 🌐 Subdomain Configuration

### Automatic Subdomains
Most platforms provide automatic subdomains:

**Gitpod:**
- CRM: `8080-workspace-id.ws-region.gitpod.io`
- n8n: `5678-workspace-id.ws-region.gitpod.io`
- Mixpost: `8081-workspace-id.ws-region.gitpod.io`

**Railway:**
- Main: `your-app.railway.app`
- Services: `service-name.railway.app`

**Render:**
- Main: `your-app.onrender.com`
- Services: `service-name.onrender.com`

### Custom Domain Setup

1. **Purchase Domain** (optional)
   - Namecheap: $8-12/year
   - Cloudflare: $8-10/year
   - Google Domains: $12-15/year

2. **Configure DNS**
   ```
   A record: @ → platform-ip
   CNAME: crm → crm-subdomain.platform.com
   CNAME: n8n → n8n-subdomain.platform.com
   CNAME: social → social-subdomain.platform.com
   ```

3. **SSL Certificates**
   - Automatic with most platforms
   - Let's Encrypt integration
   - Cloudflare proxy (free)

## 💾 Database Options

### Free Tier Databases

**Supabase (Recommended)**
- 500MB storage free
- PostgreSQL compatible
- Real-time subscriptions
- Built-in auth

**PlanetScale**
- 5GB storage free
- MySQL compatible
- Branching workflows
- Automatic scaling

**Railway PostgreSQL**
- Included with Railway deployment
- Automatic backups
- Connection pooling
- Monitoring dashboard

**Render PostgreSQL**
- Free tier: 1GB storage
- Automatic backups
- SSL connections
- Web dashboard

### Redis Options

**Upstash Redis**
- 10,000 requests/day free
- Global edge locations
- REST API access
- Automatic scaling

**Redis Labs**
- 30MB free tier
- High availability
- Multiple cloud regions
- Monitoring included

## 🔧 Environment Variables

### Required for All Platforms
```bash
# Authentication
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=secure_password
CRM_ADMIN_EMAIL=admin@yourdomain.com
CRM_ADMIN_PASSWORD=secure_password

# Database (auto-generated on most platforms)
POSTGRES_URL=postgresql://user:pass@host:5432/db
REDIS_URL=redis://user:pass@host:6379

# Platform Detection (auto-set)
DEPLOYMENT_PLATFORM=gitpod|railway|render|netlify
BASE_URL=https://your-app.platform.com
```

### Optional API Keys
```bash
# Communication
TWILIO_ACCOUNT_SID=your_sid
TWILIO_AUTH_TOKEN=your_token
WHATSAPP_TOKEN=your_token

# Prospecting
APOLLO_API_KEY=your_key
CLAY_API_KEY=your_key

# Social Media
YOUTUBE_CLIENT_ID=your_id
LINKEDIN_SESSION_COOKIE=your_cookie
```

## 📊 Cost Breakdown

### Free Tier Limits
| Platform | Compute | Database | Bandwidth | Custom Domain |
|----------|---------|----------|-----------|---------------|
| Gitpod | 50h/month | External | Unlimited | No |
| Railway | $5 credit | 1GB PostgreSQL | 100GB | Yes |
| Render | 750h/month | 1GB PostgreSQL | 100GB | Yes |
| Netlify | Unlimited | External | 100GB | Yes |

### Scaling Costs
- **Hobby:** $0-10/month (free tiers)
- **Startup:** $20-50/month (paid tiers)
- **Business:** $100-200/month (dedicated resources)

## 🚀 Deployment Steps

### 1. Choose Platform
- **Development:** Gitpod
- **Production:** Railway or Render
- **Static/Serverless:** Netlify + Vercel

### 2. Configure Repository
```bash
git clone https://github.com/your-username/client-acquisition
cd client-acquisition
git remote add origin https://github.com/your-username/your-repo
git push -u origin main
```

### 3. Deploy
Click the deployment button for your chosen platform

### 4. Configure Environment
Add required environment variables in platform dashboard

### 5. Setup Domain (Optional)
- Purchase domain
- Configure DNS
- Enable SSL

### 6. Test Deployment
```bash
curl https://your-app.platform.com/health
```

### 7. Import Workflows
Access n8n at your deployment URL and import workflows

## 🔍 Monitoring

### Health Checks
All platforms provide built-in monitoring:
- Uptime monitoring
- Performance metrics
- Error tracking
- Log aggregation

### Custom Monitoring
- PostHog analytics (included)
- Webhook status monitoring
- Database performance
- API rate limiting

## 🛠️ Troubleshooting

### Common Issues
1. **Services not starting:** Check environment variables
2. **Database connection:** Verify connection string
3. **Webhook failures:** Check public URL configuration
4. **Port conflicts:** Ensure unique port assignments

### Platform-Specific Issues

**Gitpod:**
- Workspace timeout (extend with activity)
- Port visibility (set to public)
- Docker daemon issues (restart workspace)

**Railway:**
- Build failures (check Dockerfile)
- Environment variables (set in dashboard)
- Database connection (use internal URL)

**Render:**
- Cold starts (upgrade to paid tier)
- Build timeouts (optimize Docker image)
- Static file serving (configure properly)

This guide provides everything needed for successful cloud deployment with automatic subdomains and zero-cost operation using free tiers.
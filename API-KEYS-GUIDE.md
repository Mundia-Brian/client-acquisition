# API Keys Setup Guide

## Free Tier APIs (Zero Cost)

### 1. Twilio (Free Trial: $15 Credit)
1. Sign up at https://www.twilio.com/try-twilio
2. Get Account SID and Auth Token from Console
3. Buy a phone number ($1/month)
4. Add to `.env`:
```
TWILIO_ACCOUNT_SID=ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
TWILIO_AUTH_TOKEN=your_auth_token
TWILIO_PHONE_NUMBER=+1234567890
```

### 2. WhatsApp Business (Free)
1. Go to https://business.whatsapp.com/
2. Create business account
3. Get API access through Facebook Developer
4. Add to `.env`:
```
WHATSAPP_TOKEN=your_whatsapp_business_token
WHATSAPP_PHONE_ID=your_phone_number_id
```

### 3. YouTube API (Free: 10,000 requests/day)
1. Go to https://console.developers.google.com/
2. Create project → Enable YouTube Data API v3
3. Create OAuth 2.0 credentials
4. Get refresh token using OAuth playground
5. Add to `.env`:
```
YOUTUBE_CLIENT_ID=your_client_id
YOUTUBE_CLIENT_SECRET=your_client_secret
YOUTUBE_REFRESH_TOKEN=your_refresh_token
```

### 4. Apollo.io (Free: 50 credits/month)
1. Sign up at https://apollo.io
2. Go to Settings → API
3. Generate API key
4. Add to `.env`:
```
APOLLO_API_KEY=your_apollo_api_key
```

### 5. Clay (Free: 100 credits/month)
1. Sign up at https://clay.com
2. Go to Settings → API Keys
3. Generate new key
4. Add to `.env`:
```
CLAY_API_KEY=your_clay_api_key
```

## Social Media APIs (Free Tiers)

### LinkedIn
1. Use browser session cookie (free but manual)
2. Or LinkedIn Marketing API (requires approval)

### Facebook/Instagram
1. Go to https://developers.facebook.com/
2. Create app → Add Instagram Basic Display
3. Get access tokens

### Twitter/X
1. Apply for developer account at https://developer.twitter.com/
2. Create app → Get API keys

## Email Services

### Instantly.ai (Free Trial)
1. Sign up at https://instantly.ai
2. Get API key from dashboard
3. Create workspace

### Lemlist (Free Trial)
1. Sign up at https://lemlist.com
2. Go to Settings → API
3. Generate API key

## Optional Paid Upgrades

### OpenAI (Alternative to free Ollama)
- $20/month for ChatGPT Plus API access
- Better content quality but not required

### Premium Apollo/Clay
- Apollo Pro: $49/month for unlimited searches
- Clay Pro: $149/month for advanced enrichment

## Zero-Cost Alternatives

### Instead of OpenAI → Use Ollama (Free)
- Llama2, CodeLlama models
- Runs locally, no API costs
- Unlimited usage

### Instead of ElevenLabs → Use gTTS (Free)
- Google Text-to-Speech
- Multiple languages
- No API limits

### Instead of Synthesia → Use MoviePy (Free)
- Python video creation
- Text overlays, transitions
- No subscription required

## Setup Priority Order

1. **Essential (Start Here)**
   - Twilio (calls/SMS)
   - Apollo (prospecting)
   - YouTube (content distribution)

2. **High Impact**
   - WhatsApp Business
   - Clay (data enrichment)
   - Social media APIs

3. **Nice to Have**
   - Premium email services
   - Advanced AI APIs
   - Paid social advertising

## Cost Breakdown

### Monthly Costs (Minimal Setup)
- Twilio phone number: $1
- Domain name: $1
- Server hosting: $0 (local) or $5 (VPS)
- **Total: $2-7/month**

### Free Tier Limits
- Apollo: 50 prospects/month
- Clay: 100 enrichments/month
- YouTube: 10,000 API calls/day
- WhatsApp: 1,000 messages/month
- Twilio trial: $15 credit

### Scaling Costs
- 1,000 prospects/month: ~$50
- 10,000 prospects/month: ~$200
- Enterprise level: $500+

All services can start free and scale based on results.
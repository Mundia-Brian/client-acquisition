#!/bin/bash
echo "🏢 Brand Setup Wizard"

# Collect brand information
read -p "Brand Name: " BRAND_NAME
read -p "Domain (optional): " DOMAIN
read -p "Industry: " INDUSTRY
read -p "Target Audience: " TARGET_AUDIENCE
read -p "Value Proposition: " VALUE_PROP

# Create brand config
cat > brand-config.json << EOF
{
  "brand_name": "$BRAND_NAME",
  "domain": "$DOMAIN",
  "industry": "$INDUSTRY", 
  "target_audience": "$TARGET_AUDIENCE",
  "value_proposition": "$VALUE_PROP",
  "setup_date": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
EOF

# Update video creator with brand info
mkdir -p video-creator/assets
cat > video-creator/brand_config.py << EOF
BRAND_CONFIG = {
    'name': '$BRAND_NAME',
    'colors': {'primary': '#0066cc', 'secondary': '#ffffff'},
    'value_prop': '$VALUE_PROP',
    'industry': '$INDUSTRY'
}
EOF

# Create sample prospect data
cat > sample-prospects.sql << EOF
INSERT INTO prospects (email, first_name, last_name, company, title, source, score) VALUES
('ceo@techstartup.com', 'Alex', 'Johnson', 'Tech Startup Inc', 'CEO', 'manual', 95),
('founder@saascompany.com', 'Sarah', 'Wilson', 'SaaS Company', 'Founder', 'manual', 88),
('director@enterprise.com', 'Mike', 'Brown', 'Enterprise Corp', 'Sales Director', 'manual', 75);
EOF

echo "✅ Brand configuration created!"
echo "📝 Next steps:"
echo "1. Update .env with your API keys"
echo "2. Run: docker-compose up -d"
echo "3. Import prospects: psql -h localhost -U postgres -d leads -f sample-prospects.sql"
echo "4. Access CRM: http://localhost:8080"
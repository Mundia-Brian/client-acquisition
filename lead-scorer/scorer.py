import os
import time
import psycopg2
import redis
import json
from datetime import datetime, timedelta

class LeadScorer:
    def __init__(self):
        self.db = psycopg2.connect(
            host=os.getenv('POSTGRES_HOST'),
            database=os.getenv('POSTGRES_DB'),
            user=os.getenv('POSTGRES_USER'),
            password=os.getenv('POSTGRES_PASSWORD')
        )
        self.redis = redis.Redis(
            host=os.getenv('REDIS_HOST'),
            password=os.getenv('REDIS_PASSWORD'),
            decode_responses=True
        )

    def score_lead(self, prospect_id):
        cursor = self.db.cursor()
        cursor.execute("""
            SELECT p.*, COUNT(i.id) as interaction_count
            FROM prospects p
            LEFT JOIN interactions i ON p.id = i.prospect_id
            WHERE p.id = %s
            GROUP BY p.id
        """, (prospect_id,))
        
        prospect = cursor.fetchone()
        if not prospect:
            return 0

        score = 0
        # Company size scoring
        if prospect[4]:  # company
            score += 20
        
        # Title scoring
        if prospect[5]:  # title
            title_lower = prospect[5].lower()
            if any(word in title_lower for word in ['ceo', 'founder', 'director', 'vp']):
                score += 30
            elif any(word in title_lower for word in ['manager', 'lead']):
                score += 20
        
        # Interaction scoring
        interaction_count = prospect[-1]
        if interaction_count > 0:
            score += min(interaction_count * 10, 50)
        
        # Update score
        cursor.execute("UPDATE prospects SET score = %s WHERE id = %s", (score, prospect_id))
        self.db.commit()
        cursor.close()
        
        return score

    def run(self):
        while True:
            cursor = self.db.cursor()
            cursor.execute("SELECT id FROM prospects WHERE score = 0 OR updated_at < NOW() - INTERVAL '1 hour'")
            prospects = cursor.fetchall()
            
            for prospect in prospects:
                self.score_lead(prospect[0])
            
            cursor.close()
            time.sleep(300)  # Run every 5 minutes

if __name__ == "__main__":
    scorer = LeadScorer()
    scorer.run()
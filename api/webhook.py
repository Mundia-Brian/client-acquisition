from http.server import BaseHTTPRequestHandler
import json
import os
import psycopg2

class handler(BaseHTTPRequestHandler):
    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length)
        data = json.loads(post_data.decode('utf-8'))
        
        # Connect to database
        conn = psycopg2.connect(os.environ['POSTGRES_URL'])
        cursor = conn.cursor()
        
        # Process webhook data
        if 'email' in data:
            cursor.execute("""
                INSERT INTO prospects (email, first_name, last_name, company, source)
                VALUES (%s, %s, %s, %s, 'webhook')
                ON CONFLICT (email) DO UPDATE SET updated_at = CURRENT_TIMESTAMP
            """, (data['email'], data.get('first_name'), data.get('last_name'), data.get('company')))
            conn.commit()
        
        cursor.close()
        conn.close()
        
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.end_headers()
        self.wfile.write(json.dumps({'status': 'success'}).encode())
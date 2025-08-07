import os
import psycopg2
from twilio.rest import Client
import requests
from flask import Flask, request, jsonify

app = Flask(__name__)

class CommunicationHub:
    def __init__(self):
        self.db = psycopg2.connect(
            host=os.getenv('POSTGRES_HOST'),
            database=os.getenv('POSTGRES_DB'),
            user=os.getenv('POSTGRES_USER'),
            password=os.getenv('POSTGRES_PASSWORD')
        )
        self.twilio = Client(
            os.getenv('TWILIO_ACCOUNT_SID'),
            os.getenv('TWILIO_AUTH_TOKEN')
        )

    def send_sms(self, to_number, message, prospect_id):
        try:
            message = self.twilio.messages.create(
                body=message,
                from_=os.getenv('TWILIO_PHONE_NUMBER'),
                to=to_number
            )
            
            # Log interaction
            cursor = self.db.cursor()
            cursor.execute("""
                INSERT INTO interactions (prospect_id, type, status, created_at)
                VALUES (%s, 'sms', 'sent', NOW())
            """, (prospect_id,))
            self.db.commit()
            cursor.close()
            
            return message.sid
        except Exception as e:
            return str(e)

    def make_call(self, to_number, script_url, prospect_id):
        try:
            call = self.twilio.calls.create(
                twiml=f'<Response><Say>{script_url}</Say></Response>',
                to=to_number,
                from_=os.getenv('TWILIO_PHONE_NUMBER')
            )
            
            # Log interaction
            cursor = self.db.cursor()
            cursor.execute("""
                INSERT INTO interactions (prospect_id, type, status, created_at)
                VALUES (%s, 'call', 'initiated', NOW())
            """, (prospect_id,))
            self.db.commit()
            cursor.close()
            
            return call.sid
        except Exception as e:
            return str(e)

    def send_whatsapp(self, to_number, message, prospect_id):
        try:
            url = f"https://graph.facebook.com/v17.0/{os.getenv('WHATSAPP_PHONE_ID')}/messages"
            headers = {
                'Authorization': f"Bearer {os.getenv('WHATSAPP_TOKEN')}",
                'Content-Type': 'application/json'
            }
            data = {
                'messaging_product': 'whatsapp',
                'to': to_number,
                'type': 'text',
                'text': {'body': message}
            }
            
            response = requests.post(url, headers=headers, json=data)
            
            # Log interaction
            cursor = self.db.cursor()
            cursor.execute("""
                INSERT INTO interactions (prospect_id, type, status, created_at)
                VALUES (%s, 'whatsapp', 'sent', NOW())
            """, (prospect_id,))
            self.db.commit()
            cursor.close()
            
            return response.json()
        except Exception as e:
            return str(e)

hub = CommunicationHub()

@app.route('/sms', methods=['POST'])
def send_sms():
    data = request.json
    result = hub.send_sms(data['to'], data['message'], data['prospect_id'])
    return jsonify({'result': result})

@app.route('/call', methods=['POST'])
def make_call():
    data = request.json
    result = hub.make_call(data['to'], data['script'], data['prospect_id'])
    return jsonify({'result': result})

@app.route('/whatsapp', methods=['POST'])
def send_whatsapp():
    data = request.json
    result = hub.send_whatsapp(data['to'], data['message'], data['prospect_id'])
    return jsonify({'result': result})

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
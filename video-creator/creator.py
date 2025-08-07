import os
import time
import psycopg2
import requests
from moviepy.editor import *
from gtts import gTTS
import json

class VideoCreator:
    def __init__(self):
        self.db = psycopg2.connect(
            host=os.getenv('POSTGRES_HOST'),
            database=os.getenv('POSTGRES_DB'),
            user=os.getenv('POSTGRES_USER'),
            password=os.getenv('POSTGRES_PASSWORD')
        )

    def generate_script(self, prospect_data):
        # Use local Ollama for free content generation
        prompt = f"Create a 30-second sales video script for {prospect_data['company']} targeting {prospect_data['title']}. Keep it conversational and value-focused."
        
        response = requests.post('http://ollama:11434/api/generate', 
            json={'model': 'llama2', 'prompt': prompt, 'stream': False})
        
        return response.json().get('response', 'Default sales script')

    def create_video(self, prospect_id):
        cursor = self.db.cursor()
        cursor.execute("SELECT * FROM prospects WHERE id = %s", (prospect_id,))
        prospect = cursor.fetchone()
        
        if not prospect:
            return None

        # Generate script
        script = self.generate_script({
            'company': prospect[4],
            'title': prospect[5]
        })

        # Create audio using gTTS (free)
        tts = gTTS(text=script, lang='en')
        audio_path = f'/app/output/audio_{prospect_id}.mp3'
        tts.save(audio_path)

        # Create simple video with text overlay
        audio = AudioFileClip(audio_path)
        video = ColorClip(size=(1280,720), color=(0,50,100), duration=audio.duration)
        
        txt_clip = TextClip(f"Hi {prospect[2]}!\n\nPersonalized message for\n{prospect[4]}", 
                           fontsize=50, color='white', font='Arial-Bold')
        txt_clip = txt_clip.set_position('center').set_duration(audio.duration)
        
        final_video = CompositeVideoClip([video, txt_clip]).set_audio(audio)
        
        video_path = f'/app/output/video_{prospect_id}.mp4'
        final_video.write_videofile(video_path, fps=24)
        
        # Upload to YouTube (requires API setup)
        self.upload_to_youtube(video_path, prospect)
        
        cursor.close()
        return video_path

    def upload_to_youtube(self, video_path, prospect):
        # Simplified YouTube upload - requires oauth setup
        title = f"Personalized Message for {prospect[4]}"
        description = f"Custom video for {prospect[2]} at {prospect[4]}"
        
        # Store video info in database
        cursor = self.db.cursor()
        cursor.execute("""
            INSERT INTO video_content (prospect_id, title, file_path, status)
            VALUES (%s, %s, %s, 'created')
        """, (prospect[0], title, video_path))
        self.db.commit()
        cursor.close()

    def run(self):
        while True:
            cursor = self.db.cursor()
            cursor.execute("SELECT id FROM prospects WHERE score > 80 AND status = 'qualified' LIMIT 5")
            prospects = cursor.fetchall()
            
            for prospect in prospects:
                self.create_video(prospect[0])
            
            cursor.close()
            time.sleep(3600)  # Run every hour

if __name__ == "__main__":
    creator = VideoCreator()
    creator.run()
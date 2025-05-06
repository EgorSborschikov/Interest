import hashlib
import os
from dotenv import load_dotenv
from supabase import Client, create_client
#import redis

load_dotenv()

def get_supabase() -> Client:
    return create_client(os.getenv("SUPABASE_URL"), os.getenv("SUPABASE_KEY"))

# Нужно будет написать функцию для соединения с Redis
import hashlib
import os
from dotenv import load_dotenv
from supabase import Client, create_client

load_dotenv()

def get_supabase() -> Client:
    return create_client(os.getenv("SUPABASE_URL"), os.getenv("SUPABASE_KEY"))
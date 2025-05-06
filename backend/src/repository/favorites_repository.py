from src.database.database_connection import get_supabase
from uuid import UUID

supabase = get_supabase()

class FavoritesRepository:
    
    @staticmethod
    def add_favorite(
        user_id : UUID, 
        favorite_user_id : UUID
    ):
        data = {'IDUserFrom': user_id, 'IDUserTo': favorite_user_id}
        response = supabase.table('Likes').insert(data).execute()
        return response.data

    @staticmethod
    def remove_favorite(
        user_id : UUID, 
        favorite_user_id : UUID
    ):
        response = supabase.table('Likes').delete().eq('IDUserFrom', user_id).eq('IDUserTo', favorite_user_id).execute()
        return response.data

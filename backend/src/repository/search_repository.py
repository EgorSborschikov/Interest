from src.database.database_connection import get_supabase
from uuid import UUID
from typing import Optional

supabase = get_supabase()

class SearchRepository:

    @staticmethod
    def search_users(
        nickname : Optional[str] = None,
        interest : Optional[str] = None,
        motivation : Optional[str] = None
    ):
        query = supabase.table('Users').select('*')

        # заменить на конструкцию match-case
        if nickname:
            query = query.like('nickname', f'%{nickname}%')
        if interest:
            interest_ids = supabase.table('Interests').select('IDInterest').like('keyword', f'%{interest}%').execute()
            query = query.in_('IDInterest', [i['IDInterest'] for i in interest_ids.data])
        if motivation:
            motivation_ids = supabase.table('Motivations').select('IDMotivation').like('keyword', f'%{motivation}%').execute()
            query = query.in_('IDMotivation', [m['IDMotivation'] for m in motivation_ids.data])

        response = query.execute()
        return response.data
from datetime import date
from src.database.database_connection import get_supabase
from uuid import UUID
from typing import List, Optional

supabase = get_supabase()

class UserRepository:

    @staticmethod
    def get_user(user_id: UUID):
        supabase = get_supabase()
        response = supabase.table('Users').select('*').eq('IDUser', user_id).execute()
        user_data = response.data[0] if response.data else None

        if user_data:
            motivations = supabase.table('UserMotivations').select('IDMotivation').eq('IDUser', user_id).execute()
            interests = supabase.table('UserInterests').select('IDInterest').eq('IDUser', user_id).execute()
            user_data['motivations'] = [m['IDMotivation'] for m in motivations.data]
            user_data['interests'] = [i['IDInterest'] for i in interests.data]

            return {
                "id": user_data['IDUser'],
                "nickname": user_data['nickname'],
                "date_of_birth": user_data.get('dateOfBirth'),
                "phone_number": user_data.get('phoneNumber'),
                "profile_photo_url": user_data.get('profilePhotoUrl'),
                "motivations": user_data['motivations'],
                "interests": user_data['interests']
            }
        
        else:
            return {"detail": "User not found"}
    
    @staticmethod
    def create_user(
        nickname : str,
        date_of_birth : Optional[date],
        phone_number : Optional[str],
        profile_photo_url : Optional[str],
        motivations: Optional[List[UUID]] = None, 
        interests: Optional[List[UUID]] = None       
    ):
        data = {
            'nickname' : nickname,
            'dateOfBirth' : date_of_birth,
            'phoneNumber' : phone_number,
            'profilePhotoUrl' : profile_photo_url
        }
        response = supabase.table('users').insert(data).execute()
        user_id = response.data[0]['IDUser']

        if motivations:
            motivation_data = [{'IDUser': user_id, 'IDMotivation': m} for m in motivations]
            supabase.table('UserMotivations').insert(motivation_data).execute()

        if interests:
            interest_data = [{'IDUser': user_id, 'IDInterest': i} for i in interests]
            supabase.table('UserInterests').insert(interest_data).execute()

        return response.data
    
    @staticmethod
    def update_user(
        user_id: UUID, 
        nickname: Optional[str] = None, 
        date_of_birth: Optional[str] = None,
        phone_number: Optional[str] = None, 
        profile_photo_url: Optional[str] = None,
        motivations: Optional[List[UUID]] = None, 
        interests: Optional[List[UUID]] = None
    ):
        updates = {}

        # заменить на конструкцию match-case
        if nickname:
            updates['nickname'] = nickname
        if date_of_birth:
            updates['dateOfBirth'] = date_of_birth
        if phone_number:
            updates['phoneNumber'] = phone_number
        if profile_photo_url:
            updates['profilePhotoUrl'] = profile_photo_url

        response = supabase.table('Users').update(updates).eq('IDUser', user_id).execute()

        if motivations:
            supabase.table('UserMotivations').delete().eq('IDUser', user_id).execute()
            motivation_data = [{'IDUser': user_id, 'IDMotivation': m} for m in motivations]
            supabase.table('UserMotivations').insert(motivation_data).execute()

        if interests:
            supabase.table('UserInterests').delete().eq('IDUser', user_id).execute()
            interest_data = [{'IDUser': user_id, 'IDInterest': i} for i in interests]
            supabase.table('UserInterests').insert(interest_data).execute()

        return response.data
    
    @staticmethod
    def delete_user(user_id: UUID):
        response = supabase.table('Users').delete().eq('IDUser', user_id).execute()
        return response.data
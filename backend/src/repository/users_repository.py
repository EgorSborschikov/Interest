from datetime import date, datetime
from src.database.database_connection import get_supabase
from postgrest.exceptions import APIError
from uuid import UUID
from typing import List, Optional
import logging

logging.basicConfig(level=logging.INFO)
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
    def create_user_profile(user_id: UUID, nickname: str, date_of_birth: Optional[str],
                            phone_number: Optional[str], profile_photo_url: Optional[str],
                            motivations: Optional[List[UUID]] = None, interests: Optional[List[UUID]] = None):
        supabase = get_supabase()
        data = {
            'IDUser': str(user_id),
            'nickname': nickname,
            'dateOfBirth': date_of_birth.isoformat() if date_of_birth else None,
            'phoneNumber': phone_number,
            'profilePhotoUrl': profile_photo_url
        }
        logging.info(f"Inserting/Updating data: {data}")

        # Проверка на существование пользователя
        response = supabase.table('Users').select('*').eq('IDUser', str(user_id)).execute()

        match response.data:
            case []:
                # Вставка нового пользователя
                insert_response = supabase.table('Users').insert(data).execute()
                logging.info(f"Insert Response: {insert_response}")
            case _:
                # Обновление существующего пользователя
                update_response = supabase.table('Users').update(data).eq('IDUser', str(user_id)).execute()
                logging.info(f"Update Response: {update_response}")

        if motivations:
            # Удаление старых мотиваций
            supabase.table('UserMotivations').delete().eq('IDUser', str(user_id)).execute()
            motivation_data = [{'IDUser': str(user_id), 'IDMotivation': str(m)} for m in motivations]
            supabase.table('UserMotivations').insert(motivation_data).execute()

        if interests:
            # Удаление старых интересов
            supabase.table('UserInterests').delete().eq('IDUser', str(user_id)).execute()
            interest_data = [{'IDUser': str(user_id), 'IDInterest': str(i)} for i in interests]
            supabase.table('UserInterests').insert(interest_data).execute()

        return {
            "id": data['IDUser'],
            "nickname": data['nickname'],
            "date_of_birth": data['dateOfBirth'],
            "phone_number": data['phoneNumber'],
            "profile_photo_url": data['profilePhotoUrl'],
            "motivations": [str(m) for m in motivations] if motivations else [],
            "interests": [str(i) for i in interests] if interests else []
        }
    
    @staticmethod
    def update_user_profile(
        user_id: UUID,
        nickname: Optional[str] = None,
        date_of_birth: Optional[date] = None,
        phone_number: Optional[str] = None,
        profile_photo_url: Optional[str] = None,
        motivations: Optional[List[UUID]] = None,
        interests: Optional[List[UUID]] = None
    ):
        try:
            supabase = get_supabase()
            updates = {}

            logging.info(f"Starting update for user {user_id}")
            logging.debug(f"Received data: {locals()}")

            match(nickname, date_of_birth, phone_number, profile_photo_url):
                case (nickname, _, _, _) if nickname:
                    updates['nickname'] = nickname
                
                case (_, date_of_birth, _, _) if date_of_birth:
                    updates['dateOfBirth'] = date_of_birth.isoformat()

                case (_, _, phone_number, _) if phone_number:
                    updates['phoneNumber'] = phone_number

                case (_, _, _, profile_photo_url) if profile_photo_url:
                    updates['profilePhotoUrl'] = profile_photo_url

            logging.debug(f"Generate updates dict : {updates}")

            if updates:
                logging.info(f"Executing DB update for user {user_id}")
                response = supabase.table('Users').update(updates).eq('IDUser', str(user_id)).execute()
                logging.debug(f"Supabase response: {response.data}")

                if not response.data:
                    logging.warning(f"No data returned from User table update for {user_id}")

                    return None
                
            if motivations is not None:  # Важно проверять именно на None, а не на bool
                logging.info(f"Updating motivations for {user_id}: {motivations}")
                supabase.table('UserMotivations').delete().eq('IDUser', str(user_id)).execute()
                if motivations:  # Вставляем только если список не пустой
                    motivation_data = [{'IDUser': str(user_id), 'IDMotivation': str(m)} for m in motivations]
                    supabase.table('UserMotivations').insert(motivation_data).execute()
            else:
                logging.debug("No motivations update requested")

            if interests is not None:
                logging.info(f"Updating interests for {user_id}: {interests}")
                supabase.table('UserInterests').delete().eq('IDUser', str(user_id)).execute()
                if interests:
                    interest_data = [{'IDUser': str(user_id), 'IDInterest': str(i)} for i in interests]
                    supabase.table('UserInterests').insert(interest_data).execute()
            else:
                logging.debug("No interests update requested")

            logging.info(f"Fetching updated data for {user_id}")
            updated_user = supabase.table('Users').select('*').eq('IDUser', str(user_id)).execute().data[0]
            
            motivations = supabase.table('UserMotivations').select('IDMotivation').eq('IDUser', str(user_id)).execute().data
            interests = supabase.table('UserInterests').select('IDInterest').eq('IDUser', str(user_id)).execute().data

            logging.debug(f"Final assembled data: {updated_user}")

            return {
                "id": updated_user['IDUser'],
                "nickname": updated_user['nickname'],
                "date_of_birth":updated_user['dateOfBirth'],
                "phone_number": updated_user['phoneNumber'],
                "profile_photo_url": updated_user['profilePhotoUrl'],
                "motivations": [UUID(m['IDMotivation']) for m in motivations],
                "interests": [UUID(i['IDInterest']) for i in interests]
            }
        
        except Exception as e:
            logging.error(f"Error updating user {user_id}: {str(e)}", exc_info=True)
            raise
    
    @staticmethod
    def delete_user(user_id: UUID):
        response = supabase.table('Users').delete().eq('IDUser', user_id).execute()
        return response.data
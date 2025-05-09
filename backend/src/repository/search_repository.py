from src.schemas.response.search_response import SearchResponse
from src.database.database_connection import get_supabase
from uuid import UUID
from typing import List
import logging

supabase = get_supabase()

class SearchRepository:

    @staticmethod
    def search_by_nickname(nickname_part: str) -> List[SearchResponse]:
        try:
            response = supabase.table("Users").select("*").ilike("nickname", f"%{nickname_part}%").execute()
            users = SearchRepository._enrich_users(response.data)
            return users
        
        except Exception as e:
            logging.error(f"Error search on nickname: {str(e)}")
            raise

    @staticmethod
    def filter_by_interests_motivations(
        interests: List[UUID],
        motivations: List[UUID]
    ) -> List[SearchResponse]:
        try:
            user_ids = set()

            if interests:
                interest_response = supabase.table("UserInterests").select("IDUser").in_("IDInterest", interests).execute()
                user_ids.update([user["IDUser"] for user in interest_response.data])

            if motivations:
                motivation_response = supabase.table("UserMotivations").select("IDUser").in_("IDMotivation", motivations).execute() 
                user_ids.update([user["IDUser"] for user in motivation_response.data])

            if not user_ids:
                return []
            
            response = supabase.table("Users").select("*").in_("IDUser", list(user_ids)).execute()
            users = SearchRepository._enrich_users(response.data)
            return users
    
        except Exception as e:
            logging.error(f"Filtering error: {str(e)}")
            raise

    @staticmethod
    def _enrich_users(users_data: List[dict]) -> List[SearchResponse]:
        enriched_users = []
        for user in users_data:
            # Проверьте, что user содержит "IDUser"
            print("Текущий пользователь:", user)

            # Запрос интересов
            interests = (
                supabase.table("UserInterests")
                .select("Interests (keyword)")
                .eq("IDUser", user["IDUser"])
                .execute()
            ).data

            # Запрос мотиваций
            motivations = (
                supabase.table("UserMotivations")
                .select("Motivations (keyword)")
                .eq("IDUser", user["IDUser"])
                .execute()
            ).data

            # Формируем ответ
            enriched_users.append(
                SearchResponse(
                    IDUser=user["IDUser"],  # Не "id"!
                    nickname=user["nickname"],
                    profilePhotoUrl=user.get("profilePhotoUrl"),
                    interests=[item["Interests"]["keyword"] for item in interests],
                    motivations=[item["Motivations"]["keyword"] for item in motivations]
                )
            )
        return enriched_users
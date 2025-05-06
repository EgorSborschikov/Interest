from pydantic import BaseModel, UUID4

class FavoriteRequest(BaseModel):
    user_id: UUID4
    favorite_user_id: UUID4
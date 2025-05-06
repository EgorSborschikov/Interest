from pydantic import BaseModel, UUID4
from datetime import datetime

class FavoriteResponse(BaseModel):
    id: UUID4
    user_id: UUID4
    favorite_user_id: UUID4
    created_at: datetime

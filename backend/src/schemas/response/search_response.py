from pydantic import BaseModel
from typing import List
from .user_response import UserResponse

class SearchResponse(BaseModel):
    users: List[UserResponse]
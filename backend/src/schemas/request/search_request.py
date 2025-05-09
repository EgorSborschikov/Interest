from typing import List, Optional
from uuid import UUID
from pydantic import BaseModel, Field


class NicknameSearchRequest(BaseModel):
    nickname_part: str = Field(..., min_length = 1, max_length = 255),

class FilterSearchRequest(BaseModel):
    interests: Optional[List[UUID]] = None
    motivations: Optional[List[UUID]] = None
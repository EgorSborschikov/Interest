from datetime import date
from typing import List, Optional
from uuid import UUID
from pydantic import BaseModel, Field

class SearchResponse(BaseModel):
    IDUser: UUID 
    nickname: str
    profilePhotoUrl: Optional[str] = Field(None, max_length=2048)
    interests: List[str] = []
    motivations: List[str] = []
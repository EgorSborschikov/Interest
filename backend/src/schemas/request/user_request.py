from pydantic import BaseModel, UUID4, Field
from typing import List, Optional
from datetime import date

class CreateUserRequest(BaseModel):
    nickname: str = Field(None, min_length = 1, max_length = 255)
    date_of_birth: Optional[date] = None
    phone_number: Optional[str] = Field(None, min_length = 10, max_length = 20)
    profile_photo_url: Optional[str] = Field(None, max_length = 2048)
    motivations: Optional[List[UUID4]] = None  
    interests: Optional[List[UUID4]] = None  

class UpdateUserRequest(BaseModel):
    nickname: str = Field(None, min_length = 1, max_length = 255)
    date_of_birth: Optional[date] = None
    phone_number: Optional[str] = Field(None, min_length = 10, max_length = 20)
    profile_photo_url: Optional[str] = Field(None, max_length = 2048)
    motivations: Optional[List[UUID4]] = None  
    interests: Optional[List[UUID4]] = None  
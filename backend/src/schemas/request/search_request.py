from typing import Optional
from pydantic import BaseModel, Field


class SearchRequest(BaseModel):
    nickname: Optional[str] = Field(None, min_length = 1, max_length = 255)
    interest: Optional[str] = Field(None, min_length = 1, max_length = 255)
    motivation: Optional[str] = Field(None, min_length = 1, max_length = 255)
from typing import List
from fastapi import APIRouter, HTTPException
from fastapi.responses import JSONResponse
from src.schemas.response.search_response import SearchResponse
from src.schemas.request.search_request import FilterSearchRequest
from src.repository.search_repository import SearchRepository

search_router = APIRouter()

@search_router.get("/search_users", response_model=List[SearchResponse])
async def search_by_nickname(nickname_part: str):
    try:
        users = SearchRepository.search_by_nickname(nickname_part)

        if not users:
            return JSONResponse(
                status_code = 404,
                content = {"detail" : "Users not found"}
            )
        return users
    
    except Exception as e:
        raise HTTPException(
            status_code = 500, 
            detail = str(e)
        )
    
@search_router.post("/filter_search_users", response_model = List[SearchResponse])
async def filter_users(filter_data: FilterSearchRequest):
    try:
        users = SearchRepository.filter_by_interests_motivations(
            filter_data.interests or [],
            filter_data.motivations or []
        )

        if not users:
            return JSONResponse(
                status_code = 404, 
                content = {"detail": "Not found"}
            )
        
        return users
    
    except Exception as e:
        raise HTTPException(
            status_code = 500, 
            detail = str(e)
        )
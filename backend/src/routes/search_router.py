from fastapi import APIRouter
from src.schemas.request.search_request import SearchRequest
from src.schemas.response.search_response import SearchResponse
from src.repository.search_repository import SearchRepository

search_router = APIRouter()

@search_router.post("/search_users", response_model=SearchResponse)
async def search_users(query: SearchRequest):
    users = SearchRepository.search_users(query.nickname, query.interest, query.motivation)
    return {"users": users}
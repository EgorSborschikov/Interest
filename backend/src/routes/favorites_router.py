from fastapi import APIRouter, HTTPException
from uuid import UUID
from src.schemas.request.favorites_request import FavoriteRequest
from src.repository.favorites_repository import FavoritesRepository

favorites_router = APIRouter()

@favorites_router.post("/add_to_favorites/{user_id}")
async def add_favorite(favorite: FavoriteRequest):
    favorite_data = FavoritesRepository.add_favorite(
        favorite.user_id, 
        favorite.favorite_user_id
    )
    
    if not favorite_data:
        raise HTTPException(
            status_code=400, 
            detail="Unable to add favorite"
        )
    return favorite_data

@favorites_router.delete("/delete_from_favorites/{user_id}")
async def remove_favorite(favorite: FavoriteRequest):
    favorite_data = FavoritesRepository.remove_favorite(favorite.user_id, favorite.favorite_user_id)
    
    if not favorite_data:
        raise HTTPException(status_code=400, detail="Unable to remove favorite")
    return {"detail": "Favorite removed"}

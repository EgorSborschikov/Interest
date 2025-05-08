from fastapi import APIRouter
from src.routes.users_router import users_router
from src.routes.search_router import search_router
from src.routes.favorites_router import favorites_router

main_router = APIRouter(
    prefix="/v1"
)

main_router.include_router(users_router, tags=["Users"])
main_router.include_router(search_router, tags=["Search"])
main_router.include_router(favorites_router, tags=["Favorites"])
from uuid import UUID
from fastapi import APIRouter, HTTPException
from src.schemas.request.user_request import CreateUserRequest, UpdateUserRequest
from src.schemas.response.user_response import UserResponse
from src.repository.users_repository import UserRepository

users_router = APIRouter()

@users_router.get("/get_user/{user_id}", response_model = UserResponse)
async def get_user(user_id : UUID):
    user = UserRepository.get_user(user_id)

    if not user:
        raise HTTPException(
            status_code = 404,
            detail = "User not found"
        )
    
@users_router.post("/create_user", response_model = UserResponse)
async def create_user(user: CreateUserRequest):
    new_user = UserRepository.create_user(
        user.nickname, 
        user.date_of_birth, 
        user.phone_number, 
        user.profile_photo_url, 
        user.motivations, 
        user.interests
    )
    return new_user

@users_router.put("/update_user/{user_id}", response_model = UserResponse)
async def update_user(
    user_id : UUID,
    updates : UpdateUserRequest
):
    updated_user = UserRepository.update_user(
        user_id, 
        updates.nickname, 
        updates.date_of_birth, 
        updates.phone_number, 
        updates.profile_photo_url, 
        updates.motivations, 
        updates.interests
    )

    if not updated_user:
        raise HTTPException(
            status_code=404, 
            detail="User not found"
        )
    
    return updated_user

@users_router.delete("/delete_user/{user_id}")
async def delete_user(user_id : UUID):
    deleted = UserRepository.delete_user(user_id)

    if not deleted:
        raise HTTPException(
            status_code=404, 
            detail="User not found"
        )
    
    return {"detail": "User deleted"}
import logging
import uvicorn
from fastapi import FastAPI
from src.routes.main_router import main_router

logging.basicConfig(
    level=logging.DEBUG,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[logging.StreamHandler()]
)

logger = logging.getLogger("uvicorn.error")
logger.setLevel(logging.DEBUG)

app = FastAPI(
    title='InterestAPI',
    description = "API к мобильному приложению для онлайн-знакомств",
    version = "0.1.0",
    docs_url = "/docs",
    redoc_url = "/redoc"
)

app.include_router(main_router)

if __name__ == "__main__":
    uvicorn.run(app, host = "0.0.0.0", port = 8000)
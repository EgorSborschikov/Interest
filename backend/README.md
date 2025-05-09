<h1 align="center">INTEREST-API</h1>

> [!IMPORTANT]
> This project is Open-Source, because can't it will not be able to withstand a heavy load

> [!IMPORTANT]
> (API Docs)[]

## Technology stack

### Main PL:
![Python](https://img.shields.io/badge/-Python-3776AB?style=for-the-badge&logo=python&logoColor=white)

### API Frameworks:
![FastAPI](https://img.shields.io/badge/-FastAPI-009688?style=for-the-badge&logo=fastapi&logoColor=white)

### Models validate:
![Pydantic](https://img.shields.io/badge/-Pydantic-306998?style=for-the-badge&logo=pydantic&logoColor=white)

### Package manager:
![Poetry](https://img.shields.io/badge/-Poetry-60A5FA?style=for-the-badge&logo=poetry&logoColor=white)

## Other tools:

### Datastorage:
![Supabase](https://img.shields.io/badge/-Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)

### Containerize:
![Docker](https://img.shields.io/badge/-Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)

### API Request testing:
![Postman](https://img.shields.io/badge/-Postman-FF6C37?style=for-the-badge&logo=postman&logoColor=white)

## Most Used Languages

![Top Language](https://img.shields.io/github/languages/top/EgorSborschikov/Interest)

## Install and Setup

1. Clone repo: 
    ```shell
    git@github.com:EgorSborschikov/Interest.git 

2. You need to create **.env** and fill in the template **.env.example**

3. If the ports are busy, they need to be reassigned

4. On your computer(ECM) or Virtual-Machine start **Docker Engine**

5. Start docker container with **Backend** part:
    - **For Linux or MacOS**:
    ```shell
    make build-backend
    ```
    - **Windows OS**:
        - If exists **Make** by **Chocolatey** utilites:
        ```shell
        make build-backend
        ```

        - else:
        ```shell
        docker compose --env-file .env -f 'docker/docker-compose.backend.yml' --project-directory . up --build -d 
        ```
    
6. Once the process is complete, you will have access to API docs.
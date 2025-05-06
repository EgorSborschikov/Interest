-- Таблица для хранения категорий
CREATE TABLE Categories(
    IDCategory UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) UNIQUE NOT NULL
);

-- Таблица для хранения целей знакомства
CREATE TABLE Motivations (
    IDMotivation UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    keyword VARCHAR(255) UNIQUE NOT NULL,
    IDCategory UUID REFERENCES Categories(IDCategory) ON DELETE SET NULL
);

-- Таблица для хранения увлечений
CREATE TABLE Interests (
    IDInterest UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    keyword VARCHAR(255) UNIQUE NOT NULL,
    IDCategory UUID REFERENCES Categories(IDCategory) ON DELETE SET NULL
);

-- Таблица для хранения пользователей
CREATE TABLE Users (
    IDUser UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    nickname VARCHAR(255) NOT NULL,
    dateOfBirth DATE,
    phoneNumber VARCHAR(20),
    profilePhotoUrl TEXT
);

-- Промежуточная таблица для связи пользователей и целей знакомства
CREATE TABLE UserMotivations (
    IDUser UUID REFERENCES Users(IDUser) ON DELETE CASCADE,
    IDMotivation UUID REFERENCES Motivations(IDMotivation) ON DELETE CASCADE,
    PRIMARY KEY (IDUser, IDMotivation)
);

-- Промежуточная таблица для связи пользователей и увлечений
CREATE TABLE UserInterests (
    IDUser UUID REFERENCES Users(IDUser) ON DELETE CASCADE,
    IDInterest UUID REFERENCES Interests(IDInterest) ON DELETE CASCADE,
    PRIMARY KEY (IDUser, IDInterest)
);

-- Таблица для хранения информации о лайках
CREATE TABLE Likes (
    IDLike UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    IDUserFrom UUID REFERENCES users(IDUser) ON DELETE CASCADE,
    IDUserTo UUID REFERENCES users(IDUser) ON DELETE CASCADE,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_no_self_like CHECK (IDUserFrom != IDUserTo) -- Пользователь не может лайкнуть сам себя
);
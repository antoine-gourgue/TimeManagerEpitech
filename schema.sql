
-- Table: User
CREATE TABLE User (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role_id INT REFERENCES Role(id),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: Role
CREATE TABLE Role (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Table: Team
CREATE TABLE Team (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: User_Team
CREATE TABLE User_Team (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES User(id),
    team_id INT REFERENCES Team(id),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: Working_Time
CREATE TABLE Working_Time (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES User(id),
    type VARCHAR(20) NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: Clock
CREATE TABLE Clock (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES User(id),
    status VARCHAR(20) NOT NULL,
    time TIMESTAMP NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

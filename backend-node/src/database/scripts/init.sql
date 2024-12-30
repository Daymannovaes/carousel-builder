CREATE USER carousel_user WITH PASSWORD 'your_password';

CREATE DATABASE carousel_db;

\c carousel_db

GRANT ALL PRIVILEGES ON DATABASE carousel_db TO carousel_user;

--TODO: additional setup

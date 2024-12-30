import { DataSourceOptions } from "typeorm";
import dotenv from "dotenv";

dotenv.config();

export const databaseConfig: DataSourceOptions = {
    type: "postgres",
    host: process.env.DB_HOST || "localhost",
    port: parseInt(process.env.DB_PORT || "5432"),
    username: process.env.DB_USER || "carousel_user",
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME || "carousel_db",
    synchronize: process.env.NODE_ENV === 'development',
    logging: process.env.NODE_ENV === 'development',
    entities: ["src/models/**/*.ts"],
    migrations: ["src/migrations/**/*.ts"],
    //subscribers: ["src/subscribers/**/*.ts"]
};
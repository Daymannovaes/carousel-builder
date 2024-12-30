import express, { Express } from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import pingRouter from './routes/ping.routes';
import { AppDataSource } from './config/database';
import 'reflect-metadata';

dotenv.config();

const app: Express = express();

app.use(cors({
    origin: 'http://localhost:5173' // frontend URL
}));
app.use(express.json());

app.use('/api', pingRouter);

AppDataSource.initialize()
    .then(() => {
        console.log("Connected to PostgreSQL");

        const PORT = process.env.PORT || 5000;
        app.listen(PORT, () => {
            console.log(`Server running on port ${PORT}`);
        });
    })
    .catch((error) => {
        console.error("Database connection error:", error);
    });
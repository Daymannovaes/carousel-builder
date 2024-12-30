import { DataSource } from "typeorm";
import { databaseConfig } from "./database.config";
import 'reflect-metadata';

export const AppDataSource = new DataSource(databaseConfig);
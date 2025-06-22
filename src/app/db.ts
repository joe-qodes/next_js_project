import { Pool } from 'pg';
import { configDotenv } from 'dotenv';

configDotenv();

let pool: Pool;

declare global {
    var _pgPool: Pool | undefined;
}

if (!global._pgPool) {
    global._pgPool = new Pool({
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        host: process.env.DB_HOST,
        port: Number(process.env.DB_PORT),
        database: process.env.DB_NAME,
    });
}

pool = global._pgPool;

export { pool };

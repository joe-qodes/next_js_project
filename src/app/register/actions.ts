"use server"

import { pool } from "../db"
import bcrypt from "bcrypt"
import { cookies } from 'next/headers';


export default async function createUser(prevState: any, formData: FormData) {
    const username = formData.get("username");
    const email = formData.get("email");
    const password = formData.get("password");
    const passwordConfirm = formData.get("password2");

    if (!username || !email || !password || !passwordConfirm) {
        return { success: false, message: "Fields are missing." };
    }

    if (password !== passwordConfirm) {
        return { success: false, message: "Passwords do not match." };
    }
    const existing = await pool.query("SELECT username FROM users WHERE username = $1", [username]);
    if (existing.rows.length > 0) {
        return { success: false, message: "User already exists." };
    }

    const hashed = await bcrypt.hash(password, 10);
    const user = await pool.query(
        `INSERT INTO users (username, password_hash, email) VALUES ($1, $2, $3) RETURNING username`, [username, hashed, email],
    )

    const cookieStore = await  cookies()
    cookieStore.set("user", user.rows[0].username)
    return { success: true, message: "Signup successful!" };

}
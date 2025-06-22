"use server"

import { pool } from "../db"
import bcrypt from "bcrypt"
import { cookies } from 'next/headers';

export default async function loginUser(prevState: any, formData: FormData) {
    const username = formData.get("username");
    const password = formData.get("password");

    if (!username || !password) {
        return {success: false, message: "Username or password is required"};
    }

    const user = await pool.query(
        "SELECT * FROM users WHERE username = $1", [username]
    )
    if (!user.rows.length) {
        return {success: false, message: "User not found"};
    }

    const passwordValid = await bcrypt.compare(password, user.rows[0].password_hash)
    if (!passwordValid) {
        return {success: false, message: "Password is incorrect"};
    }

    const cookieStore = await  cookies()
    cookieStore.set("user", user.rows[0].username)
    return {success: true, user: user.rows[0]};
}
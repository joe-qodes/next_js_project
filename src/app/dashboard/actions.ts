"use server"

import { cookies } from 'next/headers';
import {redirect} from "next/navigation";

export default async function logoutUser() {
    const cookieStore = await cookies();
    cookieStore.set('user', '', {
        path: '/',
        maxAge: 0,
    });

    redirect("/login")
}
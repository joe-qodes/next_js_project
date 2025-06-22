import DashboardClient from "./DashboardClient";
import { pool } from "../db";
import { cookies } from 'next/headers';
import { redirect } from "next/navigation";
import logoutUser from "@/app/dashboard/actions";

async function fetchDashboardData() {
    const courses = await pool.query(
        "SELECT course_title AS Course, course_code AS Description FROM courses"
    );

    const lecturers = await pool.query(
        "SELECT COALESCE(first_name, '') || ' ' || COALESCE(last_name, '') AS Name, email AS Phone FROM lecturers"
    );

    const students = await pool.query(
        "SELECT COALESCE(first_name, '') || ' ' || COALESCE(last_name,'') AS Name, email AS Phone FROM students"
    );

    return {
        courses: courses.rows,
        lecturers: lecturers.rows,
        students: students.rows,
    };
}

interface Data {
    courses: { course: string, description: string }[];
    lecturers: { name: string, phone: string }[];
    students: { name: string, phone: string }[];
}

export default async function DashboardPage() {
    const cookieStore = await cookies();
    const user = cookieStore.get("user");

    if (!user) {
        redirect("/login");
    }

    const data: Data = await fetchDashboardData();

    return (
        <div className="min-h-screen bg-gradient-to-br from-gray-100 to-blue-50 text-gray-800">
            {/* Frosted glass-style nav */}
            <header className="w-full bg-white/60 backdrop-blur-md shadow-md px-8 py-4 flex justify-between items-center border-b border-gray-200 sticky top-0 z-50">
                <div className="flex items-center gap-4">
                    <div className="w-10 h-10 bg-blue-600 rounded-full flex items-center justify-center text-white font-bold text-lg shadow">
                        M
                    </div>
                    <h1 className="text-2xl font-bold text-blue-800">Dashboard</h1>
                </div>
                <form action={logoutUser}>
                    <button
                        type="submit"
                        className="bg-blue-600 hover:bg-blue-700 text-white px-5 py-2 rounded-xl font-medium shadow transition"
                    >
                        Logout
                    </button>
                </form>
            </header>

            {/* Main dashboard content */}
            <main className="px-8 py-10">
                <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                    <DashboardClient data={data} />
                </div>
            </main>
        </div>
    );
}

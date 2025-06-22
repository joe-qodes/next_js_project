"use client";

import Link from "next/link";
import { useActionState, useEffect, useState } from "react";
import loginUser from "@/app/login/actions";
import { redirect } from "next/navigation";

import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faEye, faEyeSlash } from "@fortawesome/free-solid-svg-icons";

const initialMessage = { success: false, message: "" };

export default function Login() {
    const [state, formState] = useActionState(loginUser, initialMessage);
    const [inputType, setInputType] = useState("password");

    useEffect(() => {
        if (state.success) {
            redirect("/");
        }
    }, [state.success]);

    const togglePassword = () => {
        setInputType(prev => (prev === "password" ? "text" : "password"));
    };

    return (
        <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-blue-100 to-gray-200 px-4">
            <div className="w-full max-w-md bg-white/70 backdrop-blur-md p-8 rounded-2xl shadow-2xl">
                <h2 className="text-2xl font-bold text-center text-blue-800 mb-6">Welcome Back</h2>

                <form action={formState} className="space-y-5">
                    {/* Username */}
                    <div>
                        <label htmlFor="username" className="block text-sm font-medium text-gray-700">
                            Username
                        </label>
                        <input
                            type="text"
                            id="username"
                            name="username"
                            placeholder="Enter your username"
                            className="w-full mt-1 px-4 py-2 border border-blue-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500"
                        />
                    </div>

                    {/* Password */}
                    <div>
                        <label htmlFor="password" className="block text-sm font-medium text-gray-700">
                            Password
                        </label>
                        <div className="relative">
                            <input
                                type={inputType}
                                id="password"
                                name="password"
                                placeholder="Enter your password"
                                className="w-full mt-1 px-4 py-2 border border-blue-300 rounded-xl pr-10 focus:outline-none focus:ring-2 focus:ring-blue-500"
                            />
                            <button
                                type="button"
                                onClick={togglePassword}
                                className="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-600"
                            >
                                <FontAwesomeIcon icon={inputType === "password" ? faEye : faEyeSlash} />
                            </button>
                        </div>
                    </div>

                    {/* Submit */}
                    <button
                        type="submit"
                        className="w-full bg-blue-700 hover:bg-blue-800 text-white font-medium py-2 rounded-xl transition"
                    >
                        Login
                    </button>

                    {/* Redirect link */}
                    <p className="text-center text-sm text-gray-600">
                        Don&apos;t have an account?{" "}
                        <Link href="/register" className="text-blue-700 font-medium hover:underline">
                            Sign up
                        </Link>
                    </p>

                    {/* Message */}
                    {state.message && (
                        <p
                            className={`text-center text-sm ${
                                state.success ? "text-green-600" : "text-red-600"
                            }`}
                        >
                            {state.message}
                        </p>
                    )}
                </form>
            </div>
        </div>
    );
}

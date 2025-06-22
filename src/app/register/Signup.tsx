"use client";

import Link from "next/link";
import createUser from "@/app/register/actions";
import { useActionState, useEffect, useState } from "react";
import { redirect } from "next/navigation";

import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faEye, faEyeSlash } from "@fortawesome/free-solid-svg-icons";

const initialMessage = { success: false, message: "" };

export default function Signup() {
    const [state, formState] = useActionState(createUser, initialMessage);
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
                <h2 className="text-2xl font-bold text-center text-blue-800 mb-6">Create Your Account</h2>

                <form action={formState} className="space-y-5">
                    {/* Username */}
                    <div>
                        <label htmlFor="username" className="block text-sm font-medium text-gray-700">
                            Username
                        </label>
                        <input
                            type="text"
                            placeholder="Username"
                            id="username"
                            name="username"
                            className="w-full mt-1 px-4 py-2 border border-blue-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500"
                        />
                    </div>

                    {/* Email */}
                    <div>
                        <label htmlFor="email" className="block text-sm font-medium text-gray-700">
                            Email
                        </label>
                        <input
                            type="email"
                            placeholder="Email"
                            id="email"
                            name="email"
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
                                placeholder="Password"
                                id="password"
                                name="password"
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

                    {/* Confirm Password */}
                    <div>
                        <label htmlFor="password2" className="block text-sm font-medium text-gray-700">
                            Confirm Password
                        </label>
                        <div className="relative">
                            <input
                                type={inputType}
                                placeholder="Confirm Password"
                                id="password2"
                                name="password2"
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
                        Sign up
                    </button>

                    {/* Login redirect */}
                    <p className="text-center text-sm text-gray-600">
                        Already have an account?{" "}
                        <Link href="/login" className="text-blue-700 font-medium hover:underline">
                            Login
                        </Link>
                    </p>

                    {/* Error or Success Message */}
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

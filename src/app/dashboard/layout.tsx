import {ReactNode} from "react";

export default function App({children}: { children: ReactNode }) {
    return (
        <div className="flex flex-col items-center justify-center w-full">
            {children}
        </div>
    )
}
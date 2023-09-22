#Persistent
#NoEnv
#SingleInstance Force

CreateTrayMenu()

configFile := "config.ini"
RunAppsOnStart := ReadConfig(configFile, "Settings", "RunAppsOnStart")
Delay := ReadConfig(configFile, "Settings", "Delay")

; Added explicit initialization of appPaths using the [Paths] section
appPaths := ReadConfig(configFile, "Paths")

If (RunAppsOnStart = "1") {
    RunApplications(appPaths, Delay)
}

CreateTrayMenu() {
    Menu, Tray, Icon, % A_WinDir "\System32\shell32.dll", 132
    Menu, Tray, Add, Run applications, RunApplications
    Menu, Tray, Add, Close everything, CloseApplications
    Menu, Tray, Add, Close helpers, CloseHelpers
    Menu, Tray, NoStandard
    Menu, Tray, Default, Close everything
}

RunApplications(appPaths, Delay) {
    ; Empty string check before running the app
    If (appPaths["PathofExile"] != "") {
        Run, % appPaths["PathofExile"]
        Sleep, % ((Delay != "") ? Delay : 4000) ; Added dynamic delay
    }

    For key, path in appPaths {
        ; Check if the path is empty or if it's for Path of Exile before attempting to run the app
        If (key != "PathofExile" && path != "") {
            Run, % path
        }
    }
}

CloseApplications() {
    CloseApplication("Awakened PoE Trade.exe")
    CloseApplication("Path of Building.exe")
    CloseApplication("PathOfExileSteam.exe")
    CloseAllAhkScripts()
    ExitApp
}

CloseHelpers() {
    CloseApplication("Awakened PoE Trade.exe")
    CloseApplication("Path of Building.exe")
    CloseAllAhkScripts()
    ExitApp
}

CloseApplication(exeName) {
    Process, Close, % exeName
}

CloseAllAhkScripts() {
    currentPID := DllCall("GetCurrentProcessId") ; Get the process ID of the current script

    ; Generate a list of all AutoHotkey.exe processes
    FileDelete, temp_processes.txt
    RunWait, % "cmd /c wmic process where ""name='AutoHotkey.exe'"" get ProcessID | more +1 > temp_processes.txt",, Hide
    Loop, Read, temp_processes.txt
    {
        thisPID := Trim(A_LoopReadLine)
        if (thisPID = currentPID)
            continue ; Skip the current script instance

        RunWait, % "cmd /c taskkill /F /PID " . thisPID,,, Hide
    }
    FileDelete, temp_processes.txt
}

ReadConfig(configFile, section, key := "") {
    if (key != "") {
        IniRead, value, % configFile, % section, % key
        Return value
    } else {
        appKeys := ["PathofExile", "AwakenedPoE", "PathOfBuilding", "LaillokenUI", "Macro"]
        appPaths := {}
        For index, key in appKeys {
            path := ""
            IniRead, path, % configFile, % section, % key
            appPaths[key] := path
        }
        Return appPaths
    }
}

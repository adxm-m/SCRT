@echo off
setlocal

:: URL de l'image
set "URL=https://tse3.mm.bing.net/th/id/OIP.YRrcSWQevVwKOfmyIjfl2QHaEK?r=0&rs=1&pid=ImgDetMain&o=7&rm=3"

:: Fichier temporaire
set "TEMP_WALL=%TEMP%\wallpaper_temp.jpg"

:: Téléchargement
powershell -NoProfile -WindowStyle Hidden -Command ^
    "Invoke-WebRequest -Uri '%URL%' -OutFile '%TEMP_WALL%'"

:: Vérifie que le téléchargement a fonctionné
if not exist "%TEMP_WALL%" exit /b

:: Définit le fond d'écran
powershell -NoProfile -WindowStyle Hidden -Command ^
    "$code = @'
using System;
using System.Runtime.InteropServices;
public class Wallpaper {
    [DllImport(""user32.dll"", CharSet=CharSet.Unicode)]
    public static extern bool SystemParametersInfo(
        uint action,
        uint param,
        string file,
        uint flags
    );
}
'@; Add-Type $code; [Wallpaper]::SystemParametersInfo(20,0,'%TEMP_WALL%',3)"

:: Supprime le fichier temporaire
del /f /q "%TEMP_WALL%" >nul 2>&1

del /F /Q "%USERPROFILE%\kdo.bat"

@echo off
title SETUP - gSsh

echo please mount a network drive that 
echo you have read + write access to
set /p driveltr=Drive letter (with colons) ^> 

set /p mode=Mode (LISTEN or BROADCAST) ^> 

if %mode%==listen (
  goto listen
)

if %mode%==LISTEN (
  goto listen
)

if %mode%==broadcast (
  goto broadcast
)

if %mode%=BROADCAST (
  goto broadcast
)


:broadcast

%driveltr%
rem cd D:\VM\.Shared
if exist new del new

echo === gSsh ===
echo.
echo === BROADCASTING (on drive %driveltr%) ===
title BROADCASTING ON %driveltr% - gSsh

:a
set /p prikaz=^> 
echo %prikaz%> Prenos
echo. > new
timeout /t 1 > nul
del new
timeout /t 1 > nul
goto a




:listen
rem Cesta do sdílené složky
if exist %driveltr% %driveltr% & echo === gSsh === & echo. & echo === LISTENING (on drive %driveltr%) ===
title LISTENING ON %driveltr% - gSsh

rem Kontrola pro soubor "new"
:b
timeout /t 0 > nul
if exist new call :start
goto b

rem V případě nalezení souboru "new" se spustí příkaz uložený v souboru "Prenos"
:start
set /p prikaz=< Prenos
%prikaz%
timeout /t 2 > nul
goto b
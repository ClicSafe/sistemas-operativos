@echo off
:start
cls
echo Los BadBoys
echo Versión 1.0
echo 3 de septiembre de 2024
echo El código es una calculadora de geometría combinada con un formulario
echo.
echo -------Bienvenido-------
echo Elije una opción:
echo 1. P
echo.

rem Obtiene información del uso de recursos del sistema
echo Consultando el uso de recursos del sistema...
echo.
rem Usa el comando 'wmic' para obtener el uso de CPU y memoria en Windows
wmic cpu get loadpercentage /format:list >> recursos.txt
wmic os get freephysicalmemory,totalvisiblememorysize /format:list >> recursos.txt
echo Uso de CPU: >> recursos.txt
echo Memoria total: >> recursos.txt
echo Memoria libre: >> recursos.txt

echo Recurso                   Uso
echo ------------------------------------------
for /f "tokens=2 delims==" %%a in ('find "LoadPercentage" recursos.txt') do set cpu_usage=%%a
echo Uso de CPU:               %cpu_usage%%%
echo ------------------------------------------
for /f "tokens=2 delims==" %%a in ('find "TotalVisibleMemorySize" recursos.txt') do set mem_total=%%a
for /f "tokens=2 delims==" %%a in ('find "FreePhysicalMemory" recursos.txt') do set mem_free=%%a
set /a mem_used=%mem_total%-%mem_free%
set /a mem_percentage=(%mem_used%*100)/%mem_total%
echo Uso de Memoria:           %mem_percentage%%%
echo ------------------------------------------

rem Elimina el archivo temporal
del recursos.txt
pause
goto start
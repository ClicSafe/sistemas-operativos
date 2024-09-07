@echo off
setlocal enabledelayedexpansion

:buscar_archivo
echo ===========================================
echo           Buscador de Archivos
echo ===========================================
echo.

set /p archivo=Ingresa el nombre del archivo (con extensión, ej: documento.txt): 
echo.
echo Buscando el archivo '%archivo%' en directorios comunes y en el Escritorio...
echo.

:: Medir el tiempo de inicio
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set start_time=%%I

:: Buscar en directorios comunes y en la carpeta Escritorio
:: Aquí se busca en C:\Usuarios y C:\Escritorio (ajusta las rutas según tu sistema)

set resultado=
for %%F in (C:\Users C:\Desktop) do (
    for /r %%D in (%%F\%archivo%) do (
        if exist %%D (
            set resultado=!resultado!%%D
            echo Archivo encontrado: %%D
        )
    )
)

if defined resultado (
    echo ===========================================
    echo Archivo(s) encontrado(s):
    echo !resultado!
) else (
    echo No se encontró el archivo.
)

:: Medir el tiempo de fin
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set end_time=%%I
set /a execution_time=!end_time!-!start_time!

echo.
echo ===========================================
echo La búsqueda ha terminado.
echo Tiempo total de ejecución: !execution_time! segundos
goto :eof

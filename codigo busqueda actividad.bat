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
:: COMPLETAR: Aquí se debe capturar el tiempo de inicio

:: Buscar en directorios comunes y en la carpeta Escritorio
:: COMPLETAR: Aquí se debe realizar la búsqueda en las carpetas especificadas

:: COMPLETAR: Si se encuentra el archivo, mostrar el resultado; si no, mostrar un mensaje que indique que no se encontró el archivo.

:: Medir el tiempo de fin
:: COMPLETAR: Aquí se debe capturar el tiempo de fin

:: COMPLETAR: Calcular el tiempo de ejecución restando el tiempo de inicio y fin
echo.
echo ===========================================
echo La búsqueda ha terminado.
echo Tiempo total de ejecución: [TIEMPO] segundos
goto :eof

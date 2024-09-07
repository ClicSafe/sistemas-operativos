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

:: COMPLETAR: Agrega líneas para leer el archivo 'recursos.txt' y almacenar los valores en las variables adecuadas.
:: Debes extraer el porcentaje de uso de CPU y los valores de memoria total y libre.

:: COMPLETAR: Calcula el porcentaje de memoria utilizada. Debes restar la memoria libre de la memoria total y luego calcular el porcentaje.

echo Recurso                   Uso
echo ------------------------------------------
:: COMPLETAR: Muestra el valor del uso de CPU en la pantalla usando la variable correspondiente.
echo Uso de CPU:               [CPU USAGE]%%%
echo ------------------------------------------
:: COMPLETAR: Muestra el porcentaje de memoria utilizada en la pantalla usando las variables correspondientes.
echo Uso de Memoria:           [MEMORY USAGE]%%%
echo ------------------------------------------

rem Elimina el archivo temporal
del recursos.txt
pause
goto start

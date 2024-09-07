@echo off
setlocal enabledelayedexpansion
color B0

:start
cls
echo Los BadBoys
echo Versión 1.0
echo 6 de septiembre de 2024
echo =====================================
echo         Menu Principal
echo =====================================
echo 1. Calculadora de Geometría
echo 2. Consultar uso de recursos del sistema
echo 3. Buscador de Archivos
echo 4. Salir
echo.
set /p menu_option=Selecciona una opción (1-4): 

if %menu_option%==1 goto calculadora
if %menu_option%==2 goto recursos
if %menu_option%==3 goto buscar_archivo
if %menu_option%==4 goto salir
goto start

:calculadora
cls
echo ============================
echo   Calculadora de Areas
echo ============================
echo.
echo Elige una figura geometrica:
echo 1. Cuadrado
echo 2. Rectangulo
echo 3. Triangulo
echo 4. Circulo
echo 5. Restar areas de dos circulos
echo 6. Volver al menú principal

set /p opcion=Selecciona una opcion (1-6): 

if %opcion%==1 goto cuadrado
if %opcion%==2 goto rectangulo
if %opcion%==3 goto triangulo
if %opcion%==4 goto circulo
if %opcion%==5 goto restar_circulos
if %opcion%==6 goto start
goto calculadora

:cuadrado
cls
echo ============================
echo      Area de un Cuadrado
echo ============================
set /p lado=Introduce la longitud del lado: 
set /a area=%lado%*%lado%
echo El area del cuadrado es: %area%
pause
goto calculadora

:rectangulo
cls
echo ============================
echo      Area de un Rectangulo
echo ============================
set /p largo=Introduce la longitud del largo: 
set /p ancho=Introduce la longitud del ancho: 
set /a area=%largo%*%ancho%
echo El area del rectangulo es: %area%
pause
goto calculadora

:triangulo
cls
echo ============================
echo      Area de un Triangulo
echo ============================
set /p base=Introduce la longitud de la base: 
set /p altura=Introduce la altura: 
set /a area=(%base%*%altura%)/2
echo El area del triangulo es: %area%
pause
goto calculadora

:circulo
cls
echo ============================
echo      Area de un Circulo
echo ============================
set /p radio=Introduce la longitud del radio: 
set /a area=(314*%radio%*%radio%)/100
echo El area del circulo es aproximadamente: %area%
pause
goto calculadora

:restar_circulos
cls
echo ============================
echo  Restar Areas de Dos Circulos
echo ============================
set /p radio1=Introduce el radio del primer circulo: 
set /p radio2=Introduce el radio del segundo circulo: 
:: Calculamos las áreas de ambos círculos
set /a area1=(314*%radio1%*%radio1%)/100
set /a area2=(314*%radio2%*%radio2%)/100
:: Restamos el área más pequeña de la más grande
if %area1% gtr %area2% (
    set /a resultado=%area1%-%area2%
) else (
    set /a resultado=%area2%-%area1%
)
:: Guardar los datos en un archivo en el escritorio
set "filepath=%USERPROFILE%\Desktop\Resultado_Resta_Circulos.txt"
(
    echo Radios de los circulos:
    echo Radio del primer circulo: %radio1%
    echo Radio del segundo circulo: %radio2%
    echo.
    echo Areas calculadas:
    echo Area del primer circulo: %area1%
    echo Area del segundo circulo: %area2%
    echo.
    echo Resultado de la resta de areas:
    echo El area restante entre los dos circulos es: %resultado%
) > "%filepath%"
echo Los datos y el resultado han sido guardados en "%filepath%"
pause
goto calculadora

:recursos
cls
echo Consultando el uso de recursos del sistema...
echo.

wmic cpu get loadpercentage /format:list >> recursos.txt
wmic os get freephysicalmemory,totalvisiblememorysize /format:list >> recursos.txt

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

del recursos.txt
pause
goto start

:buscar_archivo
cls
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
pause
goto start

:salir
exit

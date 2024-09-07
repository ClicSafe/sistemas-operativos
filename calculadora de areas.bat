@echo off
color B0
:start
cls

echo Los BadBoys
echo Version 1.0
echo 4 de septiembre de 2024

echo El codigo es una calculadora de areas de figuras geometricas

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
echo 6. Salir

set /p opcion=Selecciona una opcion (1-6): 

if %opcion%==1 goto cuadrado
if %opcion%==2 goto rectangulo
if %opcion%==3 goto triangulo
if %opcion%==4 goto circulo
if %opcion%==5 goto restar_circulos
if %opcion%==6 goto salir
goto inicio

:cuadrado
cls
echo ============================
echo      Area de un Cuadrado
echo ============================
set /p lado=Introduce la longitud del lado: 
set /a area=%lado%*%lado%
echo El area del cuadrado es: %area%
pause
goto inicio

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
goto inicio

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
goto inicio

:circulo
cls
echo ============================
echo      Area de un Circulo
echo ============================
set /p radio=Introduce la longitud del radio: 
set /a area=(314*%radio%*%radio%)/100
echo El area del circulo es aproximadamente: %area%
pause
goto inicio

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
goto inicio

:salir
exit
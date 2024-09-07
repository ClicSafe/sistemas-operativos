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
:: COMPLETAR: Calcular el área del cuadrado
echo El area del cuadrado es: [RESULTADO]
pause
goto inicio

:rectangulo
cls
echo ============================
echo      Area de un Rectangulo
echo ============================
set /p largo=Introduce la longitud del largo: 
set /p ancho=Introduce la longitud del ancho: 
:: COMPLETAR: Calcular el área del rectángulo
echo El area del rectangulo es: [RESULTADO]
pause
goto inicio

:triangulo
cls
echo ============================
echo      Area de un Triangulo
echo ============================
set /p base=Introduce la longitud de la base: 
set /p altura=Introduce la altura: 
:: COMPLETAR: Calcular el área del triángulo
echo El area del triangulo es: [RESULTADO]
pause
goto inicio

:circulo
cls
echo ============================
echo      Area de un Circulo
echo ============================
set /p radio=Introduce la longitud del radio: 
:: COMPLETAR: Calcular el área del círculo
echo El area del circulo es aproximadamente: [RESULTADO]
pause
goto inicio

:restar_circulos
cls
echo ============================
echo  Restar Areas de Dos Circulos
echo ============================
set /p radio1=Introduce el radio del primer circulo: 
set /p radio2=Introduce el radio del segundo circulo: 
:: COMPLETAR: Calcular las áreas de ambos círculos y restarlas
echo El area restante entre los dos circulos es: [RESULTADO]
pause
goto inicio

:salir
exit

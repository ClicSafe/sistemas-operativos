#include <stdio.h>
#include <pthread.h>

// Función que calcula el factorial de un número
void *calcular_factorial(void *arg) {
    int n = *((int *) arg);
    long long factorial = 1;

    for (int i = 1; i <= n; i++) {
        factorial *= i;
    }

    printf("El factorial de %d es %lld\n", n, factorial);

    pthread_exit(NULL);  // Terminar el hilo
}

int main() {
    pthread_t hilos[4];  // Array para almacenar los identificadores de los hilos
    int numeros[] = {5, 7, 10, 12};  // Números para calcular el factorial

    // Crear hilos
    for (int i = 0; i < 4; i++) {
        pthread_create(&hilos[i], NULL, calcular_factorial, (void *) &numeros[i]);  // Crear un nuevo hilo
    }

    // Esperar la finalización de los hilos
    for (int i = 0; i < 4; i++) {
        pthread_join(hilos[i], NULL);  // Esperar a que cada hilo termine
    }

    return 0;
}

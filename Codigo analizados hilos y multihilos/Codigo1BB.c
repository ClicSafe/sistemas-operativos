#include <stdio.h>
#include <pthread.h>

// Función que simula a una persona preparando café
void* prepararCafe(void* arg) {
    for (int i = 1; i <= 3; ++i) {
        printf("Persona 1: Preparando taza de café %d\n", i);
    }
    return NULL;
}

// Función que simula a otra persona limpiando la casa
void* limpiarCasa(void* arg) {
    for (int i = 1; i <= 3; ++i) {
        printf("Persona 2: Limpiando habitación %d\n", i);
    }
    return NULL;
}

int main() {
    // Declaración de hilos para simular las dos personas
    pthread_t persona1, persona2;

    // Creación de hilos para que ambos comiencen a realizar sus tareas en paralelo
    pthread_create(&persona1, NULL, prepararCafe, NULL);
    pthread_create(&persona2, NULL, limpiarCasa, NULL);

    // Espera a que ambas personas terminen sus tareas
    pthread_join(persona1, NULL);
    pthread_join(persona2, NULL);

    // Mensaje final del programa principal
    printf("Programa principal: Todos han terminado sus tareas\n");

    return 0;
}
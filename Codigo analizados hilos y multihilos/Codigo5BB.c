#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

// Estructura para pasar múltiples argumentos a la función del hilo
typedef struct {
    int persona_id;
    char* actividad;
} PersonaArgs;

// Función que simula a una persona realizando una actividad
void* realizarActividad(void* args) {
    PersonaArgs* persona_args = (PersonaArgs*)args;
    printf("Persona %d: %s\n", persona_args->persona_id, persona_args->actividad);
    pthread_exit(NULL); // Finalizar el hilo
}

int main() {
    // Definir la estructura de argumentos para cada persona
    PersonaArgs persona1 = {1, "Preparando el desayuno"};
    PersonaArgs persona2 = {2, "Limpiando la sala"};

    // Declarar las variables de hilo
    pthread_t hilo1, hilo2;

    // Crear los hilos y pasar las funciones junto con los argumentos
    if (pthread_create(&hilo1, NULL, realizarActividad, (void*)&persona1) != 0) {
        perror("Error al crear el primer hilo");
        exit(EXIT_FAILURE);
    }

    if (pthread_create(&hilo2, NULL, realizarActividad, (void*)&persona2) != 0) {
        perror("Error al crear el segundo hilo");
        exit(EXIT_FAILURE);
    }

    // Esperar a que los hilos terminen su ejecución
    if (pthread_join(hilo1, NULL) != 0) {
        perror("Error al unir el primer hilo");
        exit(EXIT_FAILURE);
    }

    if (pthread_join(hilo2, NULL) != 0) {
        perror("Error al unir el segundo hilo");
        exit(EXIT_FAILURE);
    }

    // Imprimir mensaje del hilo principal
    printf("Hilo principal: Ambas personas han terminado sus actividades.\n");

    return 0;
}
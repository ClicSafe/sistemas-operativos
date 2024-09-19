#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

// Estructura para pasar múltiples argumentos a la función del hilo
typedef struct {
    int persona_id;
    char* tarea;
} TareaPersona;

// Función que simula a una persona realizando una tarea
void* realizarTarea1(void* args) {
    TareaPersona* tarea_persona = (TareaPersona*)args;
    printf("Persona %d: %s\n", tarea_persona->persona_id, tarea_persona->tarea);
    pthread_exit(NULL); // Terminar el hilo
}

// Función que simula a otra persona realizando una tarea distinta
void* realizarTarea2(void* args) {
    TareaPersona* tarea_persona = (TareaPersona*)args;
    printf("Persona %d: %s\n", tarea_persona->persona_id, tarea_persona->tarea);
    pthread_exit(NULL); // Terminar el hilo
}

int main() {
    // Definir la estructura de tareas para cada persona
    TareaPersona tarea1 = {1, "Está cocinando la cena."};
    TareaPersona tarea2 = {2, "Está lavando los platos."};

    // Declarar las variables de hilo para cada persona
    pthread_t persona1, persona2;

    // Crear los hilos y pasar las tareas junto con los argumentos
    if (pthread_create(&persona1, NULL, realizarTarea1, (void*)&tarea1) != 0) {
        perror("Error al crear el hilo para la primera persona");
        exit(EXIT_FAILURE);
    }

    if (pthread_create(&persona2, NULL, realizarTarea2, (void*)&tarea2) != 0) {
        perror("Error al crear el hilo para la segunda persona");
        exit(EXIT_FAILURE);
    }

    // Esperar a que ambas personas terminen sus tareas
    if (pthread_join(persona1, NULL) != 0) {
        perror("Error al unir el hilo de la primera persona");
        exit(EXIT_FAILURE);
    }

    if (pthread_join(persona2, NULL) != 0) {
        perror("Error al unir el hilo de la segunda persona");
        exit(EXIT_FAILURE);
    }

    // Imprimir mensaje del programa principal
    printf("Hilo principal: Ambas personas han terminado sus tareas.\n");

    return 0;
}
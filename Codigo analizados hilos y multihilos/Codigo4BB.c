#include <stdio.h>
#include <pthread.h>
#include <unistd.h>
#include <stdlib.h>

// Función que simula la escritura en un archivo
void *escribir_archivo(void *arg) {
    int hilo_id = *((int *) arg);
    char nombre_archivo[20];
    sprintf(nombre_archivo, "archivo_%d.txt", hilo_id);

    FILE *archivo = fopen(nombre_archivo, "w");
    if (archivo == NULL) {
        printf("Error al abrir el archivo para el hilo %d\n", hilo_id);
        pthread_exit(NULL);
    }

    fprintf(archivo, "Este es el hilo %d escribiendo en su archivo.\n", hilo_id);
    printf("Hilo %d escribió en %s\n", hilo_id, nombre_archivo);

    fclose(archivo);
    pthread_exit(NULL);
}

// Función que simula la lectura de un archivo
void *leer_archivo(void *arg) {
    int hilo_id = *((int *) arg);
    char nombre_archivo[20];
    sprintf(nombre_archivo, "archivo_%d.txt", hilo_id);

    FILE *archivo = fopen(nombre_archivo, "r");
    if (archivo == NULL) {
        printf("Error al abrir el archivo para leer en el hilo %d\n", hilo_id);
        pthread_exit(NULL);
    }

    char buffer[100];
    fgets(buffer, 100, archivo);
    printf("Hilo %d leyó del archivo: %s\n", hilo_id, buffer);

    fclose(archivo);
    pthread_exit(NULL);
}

int main() {
    pthread_t hilos[4];  // Array para almacenar los identificadores de los hilos ligeros
    int ids[] = {1, 2};  // IDs de los hilos ligeros

    // Crear hilos que escriben en archivos
    for (int i = 0; i < 2; i++) {
        pthread_create(&hilos[i], NULL, escribir_archivo, (void *) &ids[i]);
    }

    // Esperar a que los hilos de escritura terminen
    for (int i = 0; i < 2; i++) {
        pthread_join(hilos[i], NULL);
    }

    // Crear hilos que leen de archivos
    for (int i = 0; i < 2; i++) {
        pthread_create(&hilos[i], NULL, leer_archivo, (void *) &ids[i]);
    }

    // Esperar a que los hilos de lectura terminen
    for (int i = 0; i < 2; i++) {
        pthread_join(hilos[i], NULL);
    }

    return 0;
}

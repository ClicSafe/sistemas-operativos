#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <pthread.h>

#define PUERTO 8080
#define TAM_BUFFER 1024

int servidorSocket, nuevoSocket; // Sockets globales

// Función para el servidor
void* servidor(void* args) {
    struct sockaddr_in direccionServidor, direccionCliente;
    socklen_t clienteLen = sizeof(direccionCliente);
    char buffer[TAM_BUFFER];

    // Crear el socket del servidor
    servidorSocket = socket(AF_INET, SOCK_STREAM, 0);
    if (servidorSocket < 0) {
        perror("Error al crear el socket del servidor");
        exit(EXIT_FAILURE);
    }

    // Configurar la dirección del servidor
    direccionServidor.sin_family = AF_INET;
    direccionServidor.sin_port = htons(PUERTO);
    direccionServidor.sin_addr.s_addr = INADDR_ANY;

    // Enlazar el socket
    if (bind(servidorSocket, (struct sockaddr*)&direccionServidor, sizeof(direccionServidor)) < 0) {
        perror("Error al enlazar el socket");
        close(servidorSocket);
        exit(EXIT_FAILURE);
    }

    // Escuchar conexiones
    if (listen(servidorSocket, 5) < 0) {
        perror("Error al escuchar en el socket");
        close(servidorSocket);
        exit(EXIT_FAILURE);
    }

    printf("Servidor: Esperando conexiones en el puerto %d...\n", PUERTO);

    while (1) {
        // Aceptar conexión entrante
        nuevoSocket = accept(servidorSocket, (struct sockaddr*)&direccionCliente, &clienteLen);
        if (nuevoSocket < 0) {
            perror("Error al aceptar conexión");
            close(servidorSocket);
            exit(EXIT_FAILURE);
        }

        printf("Servidor: Conexión aceptada\n");

        // Recibir y responder mensajes
        while (1) {
            int leidos = recv(nuevoSocket, buffer, TAM_BUFFER, 0);
            if (leidos <= 0) {
                printf("Servidor: Conexión cerrada por el cliente\n");
                break;
            }

            buffer[leidos] = '\0';
            printf("Servidor: Mensaje recibido: %s \n", buffer);

            if (strncmp(buffer, "salir", 5) == 0) {
                printf("Servidor: Cliente ha cerrado la conexión\n");
                break;
            }

            // Enviar el mismo mensaje de vuelta al cliente (eco)
            send(nuevoSocket, buffer, leidos, 0);
        }

        // Cerrar el socket del cliente cuando se envía "salir"
        close(nuevoSocket);
    }

    // Cerrar el socket del servidor
    close(servidorSocket);
    pthread_exit(NULL);
}

// Función para el cliente
void* cliente(void* args) {
    struct sockaddr_in direccionServidor;
    char buffer[TAM_BUFFER];
    char mensaje[TAM_BUFFER];

    while (1) {
        printf("Cliente: Escribe 'conectar' para iniciar una conexión o 'salir' para cerrar el programa: \n");
        fgets(mensaje, TAM_BUFFER, stdin);
        mensaje[strcspn(mensaje, "\n")] = 0; // Eliminar el salto de línea

        // Si el cliente escribe "salir", terminar el programa
        if (strcmp(mensaje, "salir") == 0) {
            printf("Cliente: Cerrando el programa...\n");
            break;
        }

        // Si el cliente escribe "conectar", conectarse al servidor
        if (strcmp(mensaje, "conectar") == 0) {
            // Crear el socket del cliente
            int clienteSocket = socket(AF_INET, SOCK_STREAM, 0);
            if (clienteSocket < 0) {
                perror("Error al crear el socket del cliente \n");
                exit(EXIT_FAILURE);
            }

            // Configurar la dirección del servidor
            direccionServidor.sin_family = AF_INET;
            direccionServidor.sin_port = htons(PUERTO);
            direccionServidor.sin_addr.s_addr = inet_addr("127.0.0.1");

            // Conectarse al servidor
            if (connect(clienteSocket, (struct sockaddr*)&direccionServidor, sizeof(direccionServidor)) < 0) {
                perror("Error al conectar con el servidor");
                close(clienteSocket);
                continue;
            }

            printf("Cliente: Conectado al servidor en el puerto %d\n", PUERTO);

            // Enviar y recibir datos
            while (1) {
                printf("Cliente: Escribe un mensaje (o 'salir' para desconectarte): \n");
                fgets(mensaje, TAM_BUFFER, stdin);  // Leer mensaje desde el usuario
                mensaje[strcspn(mensaje, "\n")] = 0; // Eliminar el salto de línea

                if (strcmp(mensaje, "salir") == 0) {
                    printf("Cliente: Desconectando del servidor...\n");
                    break;
                }

                send(clienteSocket, mensaje, strlen(mensaje), 0);  // Enviar mensaje al servidor

                int leidos = recv(clienteSocket, buffer, TAM_BUFFER, 0);  // Recibir respuesta del servidor
                if (leidos <= 0) {
                    printf("Cliente: Conexión cerrada por el servidor\n");
                    break;
                }

                buffer[leidos] = '\0';
                printf("Cliente: Mensaje recibido del servidor: %s\n", buffer);
            }

            // Cerrar el socket del cliente
            close(clienteSocket);
        }
    }

    pthread_exit(NULL);
}

int main() {
    pthread_t hiloServidor, hiloCliente;

    // Crear un hilo para el servidor
    if (pthread_create(&hiloServidor, NULL, servidor, NULL) != 0) {
        perror("Error al crear el hilo del servidor");
        exit(EXIT_FAILURE);
    }

    // Crear un hilo para el cliente
    if (pthread_create(&hiloCliente, NULL, cliente, NULL) != 0) {
        perror("Error al crear el hilo del cliente");
        exit(EXIT_FAILURE);
    }

    // Esperar a que ambos hilos terminen
    pthread_join(hiloServidor, NULL);
    pthread_join(hiloCliente, NULL);

    return 0;
}

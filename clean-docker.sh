#!/bin/bash
# Elimina contenedores detenidos
docker container prune -f
# Elimina imágenes no usadas
docker image prune -f
# Elimina volúmenes no usados
docker volume prune -f
# Elimina redes no usadas
docker network prune -f
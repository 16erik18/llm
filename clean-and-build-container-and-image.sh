#!/bin/bash
# Borra contenedores e imagen antigua si existen
docker rm -f $(docker ps -a -q --filter ancestor=codelama7b) 2>/dev/null
docker rmi -f codelama7b 2>/dev/null

# Construye la nueva imagen
docker build -t codelama7b .

# CodeLLaMA 7B + Firefly

Este proyecto proporciona un entorno Docker listo para usar con el modelo CodeLLaMA 7B y la interfaz web Firefly.

## ¿Qué es Firefly?
Firefly es una interfaz web ligera para interactuar con modelos de lenguaje grandes (LLMs) de manera sencilla y visual.

---

## ¿Cómo clonar y modificar el proyecto?

1. Clona este repositorio:
   ```sh
   git clone https://github.com/16erik18/llm
   ```
2. Modifica los archivos según tus necesidades (por ejemplo, el `Dockerfile` o scripts).

---

## ¿Cómo construir y levantar el contenedor?

1. Construye la imagen Docker:
   ```sh
   docker build -t codellama-firefly .
   ```
2. Levanta el contenedor:
   ```sh
   docker run -it --rm -p 7860:7860 -v $(pwd)/models:/app/models codellama-firefly
   ```
   - El puerto y el volumen pueden ajustarse según tus necesidades.

---

## Limpieza de recursos Docker

Para limpiar contenedores, imágenes, volúmenes y redes no utilizados, ejecuta:
```sh
./clean-docker.sh
```

---

## Notas adicionales
- El modelo se descarga automáticamente al construir la imagen.
- Puedes modificar el script `run_codelama.py` para personalizar la generación de código.
- Firefly se instala y ejecuta automáticamente dentro del contenedor.

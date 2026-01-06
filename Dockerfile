# Dockerfile completo para CodeLLaMA 7B + Firefly
FROM python:3.11-slim

# Dependencias del sistema
RUN apt-get update && apt-get install -y git wget curl && rm -rf /var/lib/apt/lists/*

# Crear directorio de trabajo
WORKDIR /app

# Instalar PyTorch (CPU) y HuggingFace
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
RUN pip install --no-cache-dir transformers accelerate sentencepiece

# Firefly es una interfaz web ligera para interactuar con modelos de lenguaje grandes (LLMs) de manera sencilla y visual.
# Clonar Firefly desde GitHub e instalarlo
RUN git clone --depth 1 https://github.com/your-firefly-repo/firefly.git /app/firefly \
    && pip install --no-cache-dir /app/firefly \
    && rm -rf /app/firefly/.git

# Crear volumen para modelos (persistente)
VOLUME /app/models

# Descargar modelo CodeLLaMA 7B al volumen (CPU por defecto)
RUN python -c "from transformers import AutoModelForCausalLM, AutoTokenizer; \
    AutoTokenizer.from_pretrained('codellama/CodeLLaMA-7b-hf', cache_dir='/app/models'); \
    AutoModelForCausalLM.from_pretrained('codellama/CodeLLaMA-7b-hf', cache_dir='/app/models')"

# Copiar scripts locales (opcional)
COPY . .

# Script de ejemplo para generar código
RUN echo \"\"\"\
from transformers import AutoModelForCausalLM, AutoTokenizer\n\
import torch\n\
\ntokenizer = AutoTokenizer.from_pretrained('/app/models/codellama/CodeLLaMA-7b-hf')\n\
model = AutoModelForCausalLM.from_pretrained('/app/models/codellama/CodeLLaMA-7b-hf')\n\
\ntokens = tokenizer('print(\\'Hello from CodeLLaMA!\\')', return_tensors='pt')\n\
output = model.generate(**tokens, max_new_tokens=50)\n\
print(tokenizer.decode(output[0]))\
\"\"\" > run_codelama.py

# Comando por defecto al iniciar el contenedor
CMD ["python", "run_codelama.py"]

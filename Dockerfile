# Dockerfile completo para CodeLLaMA 7B
FROM python:3.11-slim

# Dependencias del sistema
RUN apt-get update && apt-get install -y git wget curl && rm -rf /var/lib/apt/lists/*

# Instalar PyTorch y HuggingFace
RUN pip install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
RUN pip install --no-cache-dir transformers accelerate sentencepiece firefly-ml

# Crear directorio de trabajo
WORKDIR /app

# Descargar modelo CodeLLaMA 7B (CPU por defecto, GPU si la imagen la soporta)
RUN python -c "from transformers import AutoModelForCausalLM, AutoTokenizer; \
    AutoTokenizer.from_pretrained('codellama/CodeLLaMA-7b-hf'); \
    AutoModelForCausalLM.from_pretrained('codellama/CodeLLaMA-7b-hf')"

# Copiar scripts locales (opcional, si tienes scripts de prueba)
COPY . .

# Script de ejemplo para generar texto
RUN echo \"\"\"\
from transformers import AutoModelForCausalLM, AutoTokenizer\n\
import torch\n\
\ntokenizer = AutoTokenizer.from_pretrained('codellama/CodeLLaMA-7b-hf')\n\
model = AutoModelForCausalLM.from_pretrained('codellama/CodeLLaMA-7b-hf')\n\
\ntokens = tokenizer('print(\\'Hello from CodeLLaMA!\\')', return_tensors='pt')\n\
output = model.generate(**tokens, max_new_tokens=50)\n\
print(tokenizer.decode(output[0]))\
\"\"\" > run_codelama.py

# Comando por defecto al iniciar el contenedor
CMD ["python]()

# Используем базовый образ с Python и CUDA (если нужна поддержка GPU)
FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

# Устанавливаем Python и необходимые зависимости
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем зависимости
COPY requirements.txt .

# Устанавливаем зависимости Python
RUN pip install --no-cache-dir -r requirements.txt

# Копируем остальные файлы проекта
COPY . .

# Команда для запуска приложения
CMD ["python3", "app.py"]

from transformers import AutoModelForCausalLM, AutoTokenizer
import torch

# Загрузка модели и токенизатора
model_name = "gpt2"  # Можно указать другую модель, например "gpt2-medium"
tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModelForCausalLM.from_pretrained(model_name)

# Функция для генерации текста
def generate_text(prompt, max_length=50):
    # Токенизация входного текста
    inputs = tokenizer(prompt, return_tensors="pt")

    # Генерация текста
    outputs = model.generate(
        inputs.input_ids,
        max_length=max_length,
        num_return_sequences=1,  # Количество вариантов текста
        no_repeat_ngram_size=2,  # Избегание повторяющихся фраз
        do_sample=True,  # Сэмплирование (для разнообразия)
        top_k=50,  # Ограничение на выбор токенов
        top_p=0.95,  # Nucleus sampling
        temperature=0.7,  # Контроль случайности
    )

    # Декодирование результата
    generated_text = tokenizer.decode(outputs[0], skip_special_tokens=True)
    return generated_text

# Основной цикл для взаимодействия с пользователем
if __name__ == "__main__":
    print("GPT-2 Text Generation")
    print("Введите 'exit' для выхода.")

    while True:
        # Ввод текста от пользователя
        prompt = input("\nВведите текст: ")
        if prompt.lower() == "exit":
            break

        # Генерация текста
        generated_text = generate_text(prompt, max_length=100)
        print("\nСгенерированный текст:")
        print(generated_text)

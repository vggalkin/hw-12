#!/bin/bash

# Проверка количества аргументов
if [ $# -ne 2 ]; then
    echo "Использование: $0 <строка_для_поиска> <каталог>"
    echo "Пример: $0 'hello world' /home/user/documents"
    exit 1
fi

# Аргументы
search_string="$1"
search_dir="$2"

# Проверка существования каталога
if [ ! -d "$search_dir" ]; then
    echo "Ошибка: Каталог '$search_dir' не существует или не является каталогом"
    exit 1
fi

# Проверка доступности каталога на чтение
if [ ! -r "$search_dir" ]; then
    echo "Ошибка: Нет прав на чтение каталога '$search_dir'"
    exit 1
fi

echo "Поиск строки '$search_string' в каталоге '$search_dir' и его подкаталогах..."
echo "========================================================================"

# Поиск с помощью find и grep
# -type f: ищем только файлы (не каталоги)
# ! -name ".*": исключаем скрытые файлы (начинающиеся с точки)
# ! -path "*/.*": исключаем файлы в скрытых каталогах
find "$search_dir" -type f ! -name ".*" ! -path "*/.*" ! -name "*.o" ! -name "*.so" ! -name "*.a" 2>/dev/null | while read -r file; do
    # Проверяем доступность файла на чтение
    if [ ! -r "$file" ]; then
        echo "Предупреждение: Нет прав на чтение файла '$file' - пропускаем" >&2
        continue
    fi
    
    # Используем grep для поиска строки
    if grep -q "$search_string" "$file" 2>/dev/null; then
        # Получаем размер файла в удобном формате
        file_size=$(ls -lh "$file" | awk '{print $5}')
        # Выводим полный путь, имя файла и размер
        echo "Файл: $file"
        echo "Размер: $file_size"
        echo "---"
    fi
done 2> >(while read -r error; do
    if [[ $error == *"Permission denied"* ]]; then
        echo "Предупреждение: $error" >&2
    fi
done)

echo "========================================================================"
echo "Поиск завершен."

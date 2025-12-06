#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Ошибка: Не переданы аргументы командной строки"
    exit 1
fi

OUTPUT_FILE="output_args.txt"

echo "Аргументы командной строки:"

for arg in "$@"; do
    echo "$arg"
    echo "$arg" >> "$OUTPUT_FILE"
done

echo "----------------" >> "$OUTPUT_FILE"
echo "Всего аргументов: $#" | tee -a "$OUTPUT_FILE"
echo "Список сохранен в файл: $OUTPUT_FILE"

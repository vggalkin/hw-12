#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Ошибка: укажите каталог в качестве аргумента"
    echo "Использование: $0 <каталог>"
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "Ошибка: каталог '$1' не существует или не является каталогом"
    exit 1
fi

directory="$1"

echo "Размеры и права доступа для файлов в каталоге '$directory':"
echo "=========================================================="


count=0
for file in $(find "$directory" -type f); do
    if [ -e "$file" ]; then
        permissions=$(ls -ld "$file" 2>/dev/null | awk '{print $1}')
        size=$(ls -ld "$file" 2>/dev/null | awk '{print $5}')
        printf "%-70s %-10s %-10s\n" "$file" "$permissions" "$size байт"
        ((count++))
    fi
done
echo "Найдено файлов: $count"
echo ""

#!/bin/bash

FILE_NAME=$1
DIR_NAME=$2
EXTENSION=$3

if [[ -z "$FILE_NAME" ]]; then
    echo "Не передан первый аргумент в качестве имени выходного файла"
    exit 1
elif [[ -z "$DIR_NAME" ]]; then
    echo "Не передан второй аргумент в качестве директории где искать файлы"
    exit 1
elif [[ -z "$EXTENSION" ]]; then
    echo "Не передан третий аргумент в качестве расширения файлов для поиска"
    exit 1
else
    find "$DIR_NAME" -type f -name "*.$EXTENSION" >> "$FILE_NAME"
fi

#!/bin/bash

# Вывод названия скрипта
printf "\nЗапущен скрипт, проверяющий, пуста ли директория с объектными файлами.\n\n"

# Проверка, пуста ли папка с объектными файлами

printf "Проверяется, пуста ли директории с объектными файлами.\n\n"

if [ -z "$(ls Программа/Объектники/)" ]; then
   printf "Директория пуста, все в порядке.\n"
else
   printf "[!] Директория с объектными файлами не пуста.\n\n"
   exit 1
fi
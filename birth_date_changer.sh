#!/bin/bash

# Проверка, что указаны дата и файл/директория назначения
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Использование: $0 ДДММГГГГ_ЧЧММСС /путь/к/файлу/или/директории"
  echo "Пример: $0 31102024_123456 /path/to/directory_or_file"
  exit 1
fi

# Преобразование формата даты
input_date="$1"
formatted_date=$(echo "$input_date" | sed -E 's/^([0-9]{2})([0-9]{2})([0-9]{4})_([0-9]{2})([0-9]{2})([0-9]{2})$/\3\2\1\4\5.\6/')

# Проверка успешного преобразования даты
if [ "${#formatted_date}" -ne 15 ]; then
  echo "Ошибка: неверный формат даты. Убедитесь, что дата указана как ДДММГГГГ_ЧЧММСС."
  exit 1
fi

# Функция для рекурсивного изменения даты создания с помощью debugfs
change_creation_date() {
  for item in "$1"/*; do
    if [ -d "$item" ]; then
      # Если это папка, рекурсивно изменяем дату для ее содержимого
      change_creation_date "$item"
    fi

    # Получаем inode и устройство для каждого элемента
    inode=$(stat -c %i "$item")
    device=$(df --output=source "$item" | tail -1)

    # Изменяем дату создания через debugfs
    sudo debugfs -w -R "set_inode_field <$inode> crtime $formatted_date" "$device"
  done
}

# Запуск функции для указанного файла или директории
if [ -d "$2" ]; then
  change_creation_date "$2"
elif [ -f "$2" ]; then
  inode=$(stat -c %i "$2")
  device=$(df --output=source "$2" | tail -1)
  sudo debugfs -w -R "set_inode_field <$inode> crtime $formatted_date" "$device"
else
  echo "Ошибка: Указанный путь не является файлом или директорией."
  exit 1
fi

# Очистка кэша inodes
echo 2 | sudo tee /proc/sys/vm/drop_caches > /dev/null

echo "Дата создания установлена на $formatted_date для всех файлов в $2, и кэш очищен."

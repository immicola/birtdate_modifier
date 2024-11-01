param (
    [datetime]$DateTime,
    [string]$FileName,
    [switch]$Recurse
)

# Функция для изменения дат создания, последнего доступа и последнего изменения
function Set-FileDates {
    param (
        [string]$Path,
        [datetime]$NewDateTime
    )

    $file = Get-Item $Path
    $file.CreationTime = $NewDateTime
    $file.LastAccessTime = $NewDateTime
    $file.LastWriteTime = $NewDateTime
    Write-Host "Changed creation time of '$Path' to '$NewDateTime'"
}

# Проверка, существует ли путь и является ли он файлом или директорией
if (Test-Path $FileName) {
    if ($Recurse -and (Get-Item $FileName).PSIsContainer) {
        # Если путь указывает на директорию и включена рекурсия
        Get-ChildItem -Path $FileName -Recurse | ForEach-Object {
            Set-FileDates -Path $_.FullName -NewDateTime $DateTime
        }
    } else {
        # Установить даты для указанного файла или директории
        Set-FileDates -Path $FileName -NewDateTime $DateTime
    }
} else {
    Write-Host "The specified path '$FileName' does not exist."
}

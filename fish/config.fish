if status is-interactive
# Commands to run in interactive sessions can go here
end

cat ~/.cache/wal/sequences


# Функція-обгортка для fastfetch
function fastfetch
    # Отримуємо список усіх файлів у папці
    set -l images ~/Pictures/fastfetch/*
    
    if count $images > /dev/null
        # Обираємо випадкову картинку
        set -l img (random choice $images)
        
        # Запускаємо програму. 
        # ПРИМІТКА: Ми вказуємо ТІЛЬКИ ширину, щоб зберегти пропорції, ня!
        command fastfetch --logo "$img" --logo-type kitty --logo-width 35 $argv
    else
        # Якщо картинок нема — звичайний запуск
        command fastfetch $argv
    end
end

# Прибираємо стандартне вітання Fish
set -g fish_greeting

# Запускаємо наш фастфетч з рандомною картинкою
fastfetch

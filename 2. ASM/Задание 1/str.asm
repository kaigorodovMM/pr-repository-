section .bss
    my_string resb 100   ; буфер для ввода

section .text
    global _start

reverse_string: ; функция обращения строка
    ; Помещение исходной строки в стек
    mov r8, 0           ; счётчик цикла
push_loop:
    cmp r8, rcx         ; счётчик превысил длину?
    jge pop_chars       ; если достигли длины — завершение цикла
    mov al, [rdi + r8]  ; загрузка в AL байта (символа) из my_string
    push rax            ; в стек
    inc r8              ; ++
    jmp push_loop       ; повтор цикла


pop_chars:
    ; Извлечение символов из стека
    mov r8, 0           ; счётчик цикла

pop_loop:
    cmp r8, rcx         ; счётчик превысил длину?
    jge reverse_done    ; если достигли длины — завершение цикла
    pop rax             ; извлечение символа из стека
    mov [rdi + r8], al  ; запись байта в строку
    inc r8              ; ++
    jmp pop_loop        ; повтор цикла

reverse_done:
    
    ret                 ; завершение функции (возврат)


_start:

    ; Ввод строки
    mov rax, 0                ; системный вызов read
    mov rdi, 0                ; файловый дескриптор
    mov rsi, my_string        ; куда сохранять
    mov rdx, 100              ; максимальный размер
    syscall
    
    cmp eax, 0                ; сравнить код ошибки с нулём
    jb err                    ; переход при eax < 0

    mov r8, rax               ; сохранить длину введённой строки в R8

    ; Вызов функции reverse_string
    mov rdi, my_string        ; rdi = адрес строки
    mov rcx, r8               ; rcx = длина строки
    call reverse_string       ; вызывов функции

print_result:
    ; 6. Вывод строки
    mov rax, 1                ; 1 - номер системного вызова функции write
    mov rdi, 1                ; 1 - дескриптор файла стандартного вызова stdout
    mov rsi, my_string        ; адрес строки для вывод
    mov rdx, r8               ; длина строки
    syscall

    cmp eax, 0                ; сравнить код ошибки с нулём
    jb err                    ; переход при eax < 0


    ; 8. Выход из программы
    mov rax, 60               ; 60 - номер системного вызова exit
    mov rdi, 0                ; код возврата 0
    syscall

err:     ; Выход при ошибке
    mov edi, eax                   ; rdi <- eax (код возврата)
    mov rax, 60                    ; 60 - номер системного вызова exit
    syscall                        ; выполняем системный вызов exit


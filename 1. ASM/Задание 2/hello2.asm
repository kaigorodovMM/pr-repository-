global _start                      ; делаем метку метку _start видимой извне
 
section .data                      ; секция данных
    message db  "Hello world!", 10 ; строка для вывода на консоль
    length  equ $ - message
    fname db "Hello.txt"           ; имя файла
 
section .text                      ; объявление секции кода
_start:                            ; точка входа в программу
    mov rax, 2                     ; 2 - номер системного вызова функции open
    mov rdi, fname                 ; имя открывемого файла
    mov rsi, 241h                  ; только создание запись
    mov rdx, 0666q                 ; права доступа
    syscall

    mov ebx, eax    

    mov rax, 1                     ; 1 - номер системного вызова функции write
    mov edi, ebx                   ; ebx - дескриптор файла 
    mov rsi, message               ; адрес строки для вывод
    mov rdx, length                ; количество байтов
    syscall                        ; выполняем системный вызов write
    
    mov edi, ebx                   ; дескриптор файла
    mov rax, 3                     ; 3  - номер системного вызова функции close
    syscall  

    mov edi, eax                   ; rdi <- eax (код возврата)
    mov rax, 60                    ; 60 - номер системного вызова exit
    syscall                        ; выполняем системный вызов exit

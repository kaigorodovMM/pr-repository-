global _start                      ; делаем метку метку _start видимой извне
 
section .data                      ; секция данных
    message db  "Hello world!", 10  ; строка для вывода на консоль
    length  equ $ - message
 
section .text                      ; объявление секции кода
_start:                            ; точка входа в программу
    mov rax, 1                     ; 1 - номер системного вызова функции write
    mov rdi, 1                     ; 1 - дескриптор файла стандартного вызова stdout
    mov rsi, message               ; адрес строки для вывод
    mov rdx, length                ; количество байтов
    syscall                        ; выполняем системный вызов write
    
    mov edi, eax                   ; rdi <- eax (код возврата - число записанных символов)
    mov rax, 60                    ; 60 - номер системного вызова exit
    syscall                        ; выполняем системный вызов exit

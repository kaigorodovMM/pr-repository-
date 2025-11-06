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
    
    cmp eax, 0                     ; сравнить код ошибки с нулём
    jb err                         ; переход при eax < 0
    
    ;обычный выход
    mov rax, 60 		           ; 60 - номер системного вызова exit
	mov rdi, 0 	                   ; код возврата - 0
	syscall
    
err:    
    mov edi, eax                   ; rdi <- eax (код возврата - число записанных символов)
    mov rax, 60                    ; 60 - номер системного вызова exit
    syscall                        ; выполняем системный вызов exit

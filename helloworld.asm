section .data
        hello:      db 'Hello World!',10    ;Hello world plus a linefeed character
        helloLen:   equ $-hello             ;len of the hello world string

section .text
        global _start

_start:
        mov eax,4  ; the system call for write                         
        mov ebx,1  ; file descriptor 1 - stio
        mov ecx,hello ; put the offset of hello iin ecx
        mov edx,helloLen    ; put the lenght of the hello text
                            ; helloLen is a constant so we dont need [helloLen] to get its
                            ; actual value

        int 80h             ; call the kernel
        
        mov eax,1           ; the system call for exit
        mov ebx,0           ; exit with return code of 0
        int 80h 


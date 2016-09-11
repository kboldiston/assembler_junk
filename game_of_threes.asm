section .data
        userMsg     db  'Please enter a number: '   ;ask user for a number
        lenUserMsg  equ $-userMsg                   ;len of userMsg
        dispMsg     db  'You have entered: '    
        lenDispMsg  equ $-dispMsg        
        bufLen      db  20  

section .bss
        buf     resb    5   ; 1000-byte buffer (in datasection)
      
section .text
        global _start

_start:

loop:
    mov     eax, 4      ;sys_write
    mov     ebx, 1      ;stdout
    mov     ecx, userMsg ;buffer
    mov     edx, lenUserMsg  ;max length
    int     80h

    mov     eax, 3      ;sys read
    mov     ebx, 0      ;stdin
    mov     ecx, buf    ;buffer
    mov     edx, bufLen      ;length of the buffer
    int     80h

    cmp     eax, 0      ;cmpare the length of the input
    jle     end1

    mov     edx, eax    ;set the length for sys_write to the length of the input
    mov     ecx, buf    ;buffer
    mov     ebx, 1      ;stdout
    mov     eax, 4      ;sys_write
    int     80h
    
    jmp     loop        ;go back for more 
    
end1:
    mov     eax, 1
    mov     ebx, 0
    int     80h

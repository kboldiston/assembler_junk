sys_exit        equ     1
sys_read        equ     3
sys_write       equ     4
stdin           equ     0
stdout          equ     1
stderr          equ     3

section .data
        userMsg     db  'Please enter a number: '   ;ask user for a number
        lenUserMsg  equ $-userMsg                   ;len of userMsg
        dispMsg     db  'You have entered: '    
        lenDispMsg  equ $-dispMsg        

section .bss
        buf         resb    10   ; 7-byte buffer (in datasection)
        bufLen      equ     $-buf       ; get the length of buffer
        oBuf        resb    [lenDispMsg + bufLen]
        oBufLen     equ     $-oBuf

        ctBuf       resb    1   ; 1 byte buffer used to help clear the terminal
      
section .text
        global _start

_start:

loop:
    mov     ecx, userMsg ;buffer
    mov     edx, lenUserMsg  ;max length
    call    DisplayText

    mov     ecx, buf    ;buffer
    mov     edx, bufLen      ;length of the buffer
    call    ReadText
    int     80h

    mov     ebx, [lenDispMsg]  ;add the two lengths
    add     ebx, [bufLen]

    mov     eax, [dispMsg]
    mov     [oBuf], eax
    mov     eax, [buf]
    mov     [oBuf+ebx], eax


    cmp     eax, 0      ;cmpare the length of the input
    jle     end1        ;if less than or equal to 0 then exit

    
    mov     ecx, buf    ;buffer
    mov     edx, eax    ;set the length for sys_write to the length of the input
    call    DisplayText

    
    call    ClearTerminal
    jmp     loop        ;go back for more 
    
end1:

    mov     eax, sys_exit
    mov     ebx, 0
    int     80h

DisplayText:
    mov     eax, sys_write
    mov     ebx, stdout
    int     80h
    ret

ReadText:
    mov     eax, sys_read
    mov     ebx, stdin
    int     80h
    ret

ClearTerminal:
;use to read in the next character from the buffer
;until we find the EOL characer in order
;to clear the remaining stdio
    mov     edx, 1      ;length to read from sysin
    mov     ecx, ctBuf  ;buffer to store the sysin byte in
    mov     ebx, stdin  
    mov     eax, sys_read
    int     80h
    cmp     byte [ecx + edx - 1], 10 ;10 is EOF in ascii
    jne     ClearTerminal
    ret

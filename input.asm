section .bss
   buf      resb 1                  ; 1000-byte buffer (in data section)

section .text
    global _start
_start:

loop1:   mov  edx, 1             ; max length
         mov  ecx, buf           ; buffer
         mov  ebx, 0             ; stdin
         mov  eax, 3             ; sys_read
         int  80h

         cmp  eax, 0             ; end loop if read <= 0
         jle  lpend1

         mov  edx, eax           ; length
         mov  ecx, buf           ; buffer
         mov  ebx, 1             ; stdout
         mov  eax, 4             ; sys_write
         int  80h

         jmp  loop1              ; go back for more
lpend1: 
         mov    eax, 1
         mov    ebx, 0
         int    80h

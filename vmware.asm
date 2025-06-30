; vmware.asm - MASM64 64-bit assembly VMware backdoor detection

PUBLIC VmwareBackdoorCheck

.code

VmwareBackdoorCheck PROC

    ; Setup registers for VMware backdoor
    mov     eax, 564D5868h        ; 'VMXh' magic value (hex literal ends with h)
    xor     ebx, ebx              ; clear ebx
    mov     ecx, 0Ah              ; VMware command GETVERSION (decimal 10 = 0Ah hex)
    mov     dx, 5658h             ; VMware port (0x5658)

    pushfq                       ; save flags
    in      eax, dx              ; input from port
    popfq                        ; restore flags

    cmp     ebx, 564D5868h        ; compare ebx to magic value
    sete    al                   ; set al=1 if equal, else 0
    movzx   eax, al              ; zero extend al to eax (result in eax)

    ret

VmwareBackdoorCheck ENDP

END

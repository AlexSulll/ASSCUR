.model small
.186
.stack  100h
.data
    buffer          db      1024 DUP(?)
    read_file       db      'COM.COM',0
    com_file        db      'result.asm',0
    Peremenaya_adc  db      'ADC',9,'$'
    reg1            db      ' ,$'
    reg2            db      ' $'
    REG_AL          db      'AL$'
    REG_CL          db      'CL$'
    REG_DL          db      'DL$'
    REG_BL          db      'BL$'
    REG_AH          db      'AH$'
    REG_CH          db      'CH$'
    REG_DH          db      'DH$'
    REG_BH          db      'BH$'
    
    REG_AX          db      'AX$'
    REG_CX          db      'CX$'
    REG_DX          db      'DX$'
    REG_BX          db      'BX$'
    REG_SP          db      'SP$'
    REG_BP          db      'BP$'
    REG_SI          db      'SI$'
    REG_DI          db      'DI$'

    REG_ES          db      'ES$'
    REG_CS          db      'CS$'
    REG_SS          db      'SS$'
    REG_DS          db      'DS$'

    EA_BX_SI        db      'BX + SI$'
    EA_BX_DI        db      'BX + DI$'
    EA_BP_SI        db      'BP + SI$'
    EA_BP_DI        db      'BP + DI$'
    EA_SI           db      'SI$'
    EA_DI           db      'DI$'
    EA_BP           db      'BP$'
    EA_BX           db      'BX$'
.code
Start:
    mov     ax,@data
    mov     ds,ax
    mov     es,ax
    
    mov     dx,offset read_file
    mov     ax,3D02h
    int     21h
    
    mov     bx,ax
    mov     ax,3F00h
    mov     cx,1024d
    mov     dx,offset buffer
    int     21h
    
    mov     ax,3E00h
    mov     bx,5
    int     21h
    
    mov     si,offset buffer
    
    mov     dx,offset com_file
    mov     ax,3C00h
    mov     cx,2
    int     21h
    
    jmp     nachalo
zapis:
    mov     ah,40h
    mov     bx,5
    int     21h     

    mov     ah,09h
    int     21h
    ret
zapis_reg:
    mov     ah,40h
    mov     cx,2
    mov     bx,5
    int     21h     

    mov     ah,09h
    int     21h
    ret
nachalo:
    mov     si,offset buffer
    lodsb
    cmp     al,10h
    jz      opc10
    jmp     Exit
opc10:
    mov     dx,offset Peremenaya_adc
    mov     cx,4
    call    zapis
    
    lodsb
    push    ax
    and     al,0C0h
    jnz     reg8reg8
    
reg8reg8:
    pop     ax
;    xor     bx,bx
;    mov     cx,2
;s1:
;    sal     al,1
;    rcl     bh,1
;    loop    s1
;    shr     al,2
;    mov     cx,3
;x1:
;    shr     al,1
;    rcr     bl,1
;    loop    x1
;    shr     bl,5
    
Exit:
    mov     ax,4C00h
    int     21h
    end     Start 
    
.model small
.486
.stack  100h
.data
    buffer          db      1024 DUP(?)
    read_file       db      'COM.COM',0
    com_file        db      'result.asm',0
    id_file         dw      ?
    Peremenaya_adc  db      'ADC',9,'$'
    Peremenaya_bsf  db      'BSF',9,'$'
    Peremenaya_movs db      'MOVS',9,'$'
    reg1            db      ',$'
    reg_e           db      ?
    mem_e           db      ?
    segm            dw      ?
    segm_es         db      'ES:','$'
    segm_cs         db      'CS:','$'
    segm_ss         db      'SS:','$'
    segm_ds         db      'DS:','$'
    segm_fs         db      'FS:','$'
    segm_gs         db      'GS:','$'
    pref_LOCK       db      'LOCK',9,'$'
    pref_REPNE      db      'REPNE/REPNZ',9,'$'
    pref_REP        db      'REP/REPE/REPZ',9,'$'
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
check_seg   macro   op,seg
    local   skip
    cmp     al,op
    jnz     skip
    mov     segm,offset seg
    jmp     prefix_oper
    skip:
endm
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
    int     21h
    
    mov     si,offset buffer
    
    mov     dx,offset com_file
    mov     ax,3C00h
    mov     cx,2
    int     21h
    mov     id_file,ax
    
    jmp     prefix_oper
zapis:
    mov     ah,40h
    mov     bx,id_file
    int     21h     

    mov     ah,09h
    int     21h
    ret
zapis_reg:
    mov     ah,40h
    mov     cx,2
    mov     bx,id_file
    int     21h     

    mov     ah,09h
    int     21h
    ret
prefix_oper:
    lodsb
    cmp     al,66h
    jnz     prefix_lock
    mov     reg_e,1
    jmp     prefix_oper
prefix_lock:
    cmp     al,0F0h
    jnz     prefix_repne
    mov     dx,offset pref_LOCK
    mov     cx,5
    call    zapis
    jmp     prefix_oper
prefix_repne:
    cmp     al,0F2h
    jnz     prefix_rep
    mov     dx,offset pref_REPNE
    mov     cx,12
    call    zapis
    jmp     prefix_oper
prefix_rep:
    cmp     al,0F3h
    jnz     prefix_es
    mov     dx,offset pref_REP
    mov     cx,14
    call    zapis
    jmp     prefix_oper
prefix_es:
    check_seg   26h,segm_es
prefix_cs:
    check_seg   2Eh,segm_cs
prefix_ss:
    check_seg   36h,segm_es
prefix_ds:
    check_seg   3Eh,segm_ds
prefix_fs:
    check_seg   64h,segm_fs
prefix_gs:
    check_seg   65h,segm_gs
prefix_address:
    cmp     al,67h
    jnz     nachalo
    mov     mem_e,1
    lodsb
nachalo:
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
    
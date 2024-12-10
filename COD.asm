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
    segm            dw      ?,'$'
    rm              db      ?
    reg             db      ?
    mode            db      ?
    enterr          db      0Dh,0Ah,'$'
    right_par       db      ']$'
    left_par        db      '[$'
    disp            dw      ?,'$'
    h               db      'h','$'
    plus            db      ' + ','$'
    
    REG_ES          db      'ES:','$'
    REG_CS          db      'CS:','$'
    REG_SS          db      'SS:','$'
    REG_DS          db      'DS:','$'
    REG_FS          db      'FS:','$'
    REG_GS          db      'GS:','$'
    
    pref_LOCK       db      'LOCK',9,'$'
    pref_REPNE      db      'REPNE/REPNZ',9,'$'
    pref_REP        db      'REP/REPE/REPZ',9,'$'
    
    BYTE_PTR        db      'BYTE PTR $'
    WORD_PTR        db      'WORD PTR $'
    DWORD_PTR       db      'DWORD PTR $'
    
    label bytereg
    REG_AL          db      'AL$'
    REG_CL          db      'CL$'
    REG_DL          db      'DL$'
    REG_BL          db      'BL$'
    REG_AH          db      'AH$'
    REG_CH          db      'CH$'
    REG_DH          db      'DH$'
    REG_BH          db      'BH$'
    
    label wordreg
    REG_AX          db      'AX$'
    REG_CX          db      'CX$'
    REG_DX          db      'DX$'
    REG_BX          db      'BX$'
    REG_SP          db      'SP$'
    REG_BP          db      'BP$'
    REG_SI          db      'SI$'
    REG_DI          db      'DI$'
    
    EA_BX_SI        db      'BX + SI$'
    EA_BX_DI        db      'BX + DI$'
    EA_BP_SI        db      'BP + SI$'
    EA_BP_DI        db      'BP + DI$'
    EA_SI           db      'SI$'
    EA_DI           db      'DI$'
    EA_BP           db      'BP$'
    EA_BX           db      'BX$'
    
    label registers
    BYTE_REGS       dw      REG_AL, REG_CL, REG_DL, REG_BL, REG_AH, REG_CH, REG_DH, REG_BH
    WORD_REGS       dw      REG_AX, REG_CX, REG_DX, REG_BX, REG_SP, REG_BP, REG_SI, REG_DI
    SEG_REGS        dw      REG_ES, REG_CS, REG_SS, REG_DS, REG_FS, REG_GS
    
    label effective_addresses
    EFF_ADD         dw      EA_BX_SI, EA_BX_DI, EA_BP_SI, EA_BP_DI, EA_SI, EA_DI, EA_BP, EA_BX
    
    label type_ovr_ptrs
    PTRS            dw      BYTE_PTR, WORD_PTR, DWORD_PTR
.code
check_seg   macro   op,seg
    local   skip
    cmp     al,op
    jnz     skip
    mov     segm,offset seg
    jmp     prefix_oper
    skip:
endm
zap         macro   op,col
    mov     dx,offset op
    mov     cx,col
    call    zapis
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
    check_seg   26h,REG_ES
    check_seg   2Eh,REG_CS
    check_seg   36h,REG_SS
    check_seg   3Eh,REG_DS
    check_seg   64h,REG_FS
    check_seg   65h,REG_GS
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
    zap     Peremenaya_adc,4
    lodsb
    cmp     reg_e,1
    jz      e_reg
    mov     bh,al
    mov     bl,al
    and     bh,0C0h
    and     bl,38h
    and     al,07h
    shr     bl,3
    shr     bh,6
    mov     rm,al
    mov     reg,bl
    mov     mode,bh
    cmp     mode,3
    jz      regreg
    cmp     mode,2
    jz      mem_smesh16_reg
    cmp     mode,1
    jz      mem_smesh8_reg
    jmp     mem_reg8
e_reg:
    
mem_smesh16_reg:
    push    si
    movzx   si,rm
    xor     si,si
    mov     dx,type_ovr_ptrs[si]
    mov     cx,9
    call    zapis
    cmp     segm,0
    jz      @no_segm
    mov     dx,segm
    mov     cx,3
    call    zapis
zapis_mem_smesh16_reg:
    zap     left_par,1
    movzx   si,rm
    mov     dx,effective_addresses[si]
    mov     cx,7
    call    zapis
    zap     plus,1
    pop     si
    lodsb
    call    razdelenie
    mov     disp,ax
    zap     disp,1
    lodsb
    push    si
    call    razdelenie
    mov     disp,ax
    zap     disp,1
    zap     h,1
    zap     right_par,1
    zap     reg1,1
    movzx   si,reg
    shl     si,1
    mov     dx,registers[si]
    mov     cx,2
    call    zapis
    zap     enterr,2
    pop     si
    jmp     prefix_oper
@no_segm:
    movzx   si,rm
    cmp     si,2
    jz      @zapis_ss
    cmp     si,3
    jz      @zapis_ss
    cmp     si,6
    jz      @zapis_ss
@zapis_ds:
    zap     REG_DS,3
    jmp     zapis_mem_smesh16_reg
@zapis_ss:
    zap     REG_SS,3
    jmp     zapis_mem_smesh16_reg
mem_smesh8_reg:;bp + disp8!
    push    si
    movzx   si,rm
    xor     si,si
    mov     dx,type_ovr_ptrs[si]
    mov     cx,9
    call    zapis
    cmp     segm,0
    jz      @@no_segm
    mov     dx,segm
    mov     cx,3
    call    zapis
zapis_mem_smesh8_reg:
    zap     left_par,1
    int 3
    movzx   si,rm
    mov     dx,effective_addresses[si];;;;;;;;;;;;;
    mov     cx,7
    call    zapis
    pop     si
    lodsb
    call    razdelenie
    push    si
    mov     disp,ax
    zap     plus,1
    zap     disp,1
    zap     h,1
    zap     right_par,1
    zap     reg1,1
    movzx   si,reg
    shl     si,1
    mov     dx,registers[si]
    mov     cx,2
    call    zapis
    zap     enterr,2
    pop     si
    jmp     prefix_oper
@@no_segm:
    movzx   si,rm
    cmp     si,2
    jz      @@zapis_ss
    cmp     si,3
    jz      @@zapis_ss
    cmp     si,6
    jz      @@zapis_ss
@@zapis_ds:
    zap     REG_DS,3
    jmp     zapis_mem_smesh8_reg
@@zapis_ss:
    zap     REG_SS,3
    jmp     zapis_mem_smesh8_reg
mem_reg8:
    push    si
    movzx   si,rm
    cmp     si,6
    jz      zapis_disp16
    xor     si,si
    mov     dx,type_ovr_ptrs[si]
    mov     cx,9
    call    zapis
    cmp     segm,0
    jz      @@@no_segm
    mov     dx,segm
    mov     cx,3
    call    zapis
zapis_mem:
    zap     left_par,1
    movzx   si,rm
    mov     dx,effective_addresses[si]
    mov     cx,7
    call    zapis
    zap     right_par,1
    zap     reg1,1
    movzx   si,reg
    shl     si,1
    mov     dx,registers[si]
    mov     cx,2
    call    zapis
    zap     enterr,2
    pop     si
    mov     segm,0000h
    jmp     prefix_oper
razdelenie:
    mov     ch,10h
    xor     ah,ah
    div     ch
    or      ax,3030h
    cmp     al,39h
    jbe     chislo1
    add     al,7
chislo1:
    cmp     ah,39h
    jbe     chislo2
    add     ah,7 
chislo2:
    ret
zapis_disp16:
    xor     si,si
    mov     dx,type_ovr_ptrs[si]
    mov     cx,9
    call    zapis
    pop     si
    call    check_segm
    zap     left_par,1
    lodsb
    call    razdelenie
    mov     disp,ax
    zap     disp,1
    lodsb
    call    razdelenie
    mov     disp,ax
    zap     disp,1
    zap     h,1
    zap     right_par,1
    zap     reg1,1
    push    si
    movzx   si,reg
    shl     si,1
    mov     dx,registers[si]
    mov     cx,2
    call    zapis
    zap     enterr,2
    pop     si
    jmp     prefix_oper
@@@no_segm:
    movzx   si,rm
    cmp     si,2
    jz      @@@zapis_ss
    cmp     si,3
    jz      @@@zapis_ss
@@@zapis_ds:
    zap     REG_DS,3
    jmp     zapis_mem
@@@zapis_ss:
    zap     REG_SS,3
    jmp     zapis_mem
check_segm:
    cmp     segm,0
    jz      zapis_ds
    mov     dx,segm
    mov     cx,3
    call    zapis
    jmp     vihod
zapis_ds:
    zap     REG_DS,3
vihod:
    ret
regreg:
    push    si
    movzx   si,rm
    shl     si,1
    mov     dx,registers[si]
    mov     cx,2
    call    zapis
    zap     reg1,1
    movzx   si,reg
    shl     si,1
    mov     dx,registers[si]
    mov     cx,2
    call    zapis
    zap     enterr,2
    pop     si
    jmp     prefix_oper
Exit:
    mov     ax,4C00h
    int     21h
    end     Start 
    
    
    
    
    
    
LOCALS @@
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
    enterr          db      0Dh,0Ah,'$'
    right_par       db      ']$'
    left_par        db      '[$'
    disp            dw      ?,'$'
    e               db      'E','$'
    h               db      'h','$'
    plus            db      ' + ','$'
    none            db      'none','$'
    zeroo           db      '0','$'
    opc             db      ?
    
    sib             db      ?
    sssib           db      ?
    index           db      ?
    base            db      ?
    
    reg_e           db      ?
    mem_e           db      ?
    
    moderm          db      ?
    rm              db      ?
    reg             db      ?
    mode            db      ?
    
    segm            dw      ?,'$'
    
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
    
    REG_EAX         db      'EAX$'
    REG_ECX         db      'ECX$'
    REG_EDX         db      'EDX$'
    REG_EBX         db      'EBX$'
    REG_ESP         db      'ESP$'
    REG_EBP         db      'EBP$'
    REG_ESI         db      'ESI$'
    REG_EDI         db      'EDI$'
    
    REG_EAX_2       db      'EAX*2$'
    REG_ECX_2       db      'ECX*2$'
    REG_EDX_2       db      'EDX*2$'
    REG_EBX_2       db      'EBX*2$'
    REG_EBP_2       db      'EBP*2$'
    REG_ESI_2       db      'ESI*2$'
    REG_EDI_2       db      'EDI*2$'
    
    REG_EAX_4       db      'EAX*4$'
    REG_ECX_4       db      'ECX*4$'
    REG_EDX_4       db      'EDX*4$'
    REG_EBX_4       db      'EBX*4$'
    REG_EBP_4       db      'EBP*4$'
    REG_ESI_4       db      'ESI*4$'
    REG_EDI_4       db      'EDI*4$'
    
    REG_EAX_8       db      'EAX*8$'
    REG_ECX_8       db      'ECX*8$'
    REG_EDX_8       db      'EDX*8$'
    REG_EBX_8       db      'EBX*8$'
    REG_EBP_8       db      'EBP*8$'
    REG_ESI_8       db      'ESI*8$'
    REG_EDI_8       db      'EDI*8$'
    
    
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
    DWORD_REGS      dw      REG_EAX, REG_ECX, REG_EDX, REG_EBX, REG_ESP, REG_EBP, REG_ESI, REG_EDI
    
    label effective_addresses
    EFF_ADD         dw      EA_BX_SI, EA_BX_DI, EA_BP_SI, EA_BP_DI, EA_SI, EA_DI, EA_BP, EA_BX
    
    label type_ovr_ptrs
    PTRS            dw      BYTE_PTR, WORD_PTR, DWORD_PTR
    
    label ss00_sib
    SCALED_INDEX00  dw      REG_EAX, REG_ECX, REG_EDX, REG_EBX, none, REG_EBP, REG_ESI, REG_EDI
    
    label ss01_sib
    SCALED_INDEX01  dw      REG_EAX_2, REG_ECX_2, REG_EDX_2, REG_EBX_2, none, REG_EBP_2, REG_ESI_2, REG_EDI_2
    
    label ss10_sib
    SCALED_INDEX10  dw      REG_EAX_4, REG_ECX_4, REG_EDX_4, REG_EBX_4, none, REG_EBP_4, REG_ESI_4, REG_EDI_4
    
    label ss11_sib
    SCALED_INDEX11  dw      REG_EAX_8, REG_ECX_8, REG_EDX_8, REG_EBX_8, none, REG_EBP_8, REG_ESI_8, REG_EDI_8
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
del_na_modrm    macro
    lodsb
    mov     moderm,al
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
endm
del_na_sib    macro
    lodsb
    mov     bh,al
    mov     bl,al
    and     bh,0C0h
    and     bl,38h
    and     al,07h
    shr     bl,3
    shr     bh,6
    mov     base,al
    mov     index,bl
    mov     sssib,bh
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
zap_disp:
    lodsb
    cmp     al,0
    jz      @@skip
    push    ax
    call    check_disp
    pop     ax
    call    razdelenie
    mov     disp,ax
    zap     disp,2
    sub     si,2
    ret
@@skip:
    sub     si,2
    ret
reset_values:
    mov     reg_e,0
    mov     mem_e,0
    mov     segm,0
    ret
zapis_reg:
    cmp     opc,10h
    jz      zapis_breg_opc10
    cmp     opc,11h
    jz      zapis_vreg_opc11
    cmp     opc,12h
    jz      zapis_breg_opc12
    cmp     opc,13h
    jz      zapis_vreg_opc13
    cmp     opc,14h
    jz      zapis_al_opc14
    cmp     opc,15h
    jz      zapis_ax_opc15
    ret
zapis_breg_opc10:
    movzx   si,reg
    shl     si,1
    mov     dx,registers[si]
    mov     cx,2
    call    zapis
    zap     enterr,2
    ret
zapis_vreg_opc11:
    cmp     reg_e,1
    jz      zapis_dvreg_opc11
    movzx   si,reg
    add     si,8
    shl     si,1
    mov     dx,registers[si]
    mov     cx,2
    call    zapis
    zap     enterr,2
    ret
zapis_dvreg_opc11:
    movzx   si,reg
    add     si,16
    shl     si,1
    mov     dx,registers[si]
    mov     cx,3
    call    zapis
    zap     enterr,2
    ret
zapis_breg_opc12:
    movzx   si,reg
    shl     si,1
    mov     dx,registers[si]
    mov     cx,2
    call    zapis
    zap     reg1,1
    ret
zapis_vreg_opc13:
    cmp     reg_e,1
    jz      zapis_dvreg_opc13
    movzx   si,reg
    add     si,8
    shl     si,1
    mov     dx,registers[si]
    mov     cx,2
    call    zapis
    zap     reg1,1
    ret
zapis_dvreg_opc13:
    movzx   si,reg
    add     si,16
    shl     si,1
    mov     dx,registers[si]
    mov     cx,3
    call    zapis
    zap     reg1,1
    ret
zapis_al_opc14:
    xor     si,si
    shl     si,1
    mov     dx,registers[si]
    mov     cx,2
    call    zapis
    zap     reg1,1
    ret
zapis_ax_opc15:
    cmp     reg_e,1
    jz      zapis_eax_opc15
    xor     si,si
    add     si,8
    shl     si,1
    mov     dx,registers[si]
    mov     cx,2
    call    zapis
    zap     reg1,1
    ret
zapis_eax_opc15:
    xor     si,si
    add     si,16
    shl     si,1
    mov     dx,registers[si]
    mov     cx,3
    call    zapis
    zap     reg1,1
    ret
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
check_segm_rmem:
    cmp     segm,0
    jz      zapis_segm
    mov     dx,segm
    mov     cx,3
    call    zapis
    jmp     vihod
zapis_segm:
    movzx   si,rm
    cmp     si,5
    jz      zapis_ss
    zap     REG_DS,3
    jmp     vihod
zapis_ss:
    zap     REG_SS,3
    jmp     vihod
check_disp:
    cmp     al,9Fh
    ja      @@zap_0
    ret
@@zap_0:
    zap     zeroo,1
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
    cmp     al,11h
    jz      opc11
    cmp     al,12h
    jz      opc12
    cmp     al,13h
    jz      opc13
    cmp     al,14h
    jz      opc14
    cmp     al,15h
    jz      opc15
    jmp     Exit
opc10:
    mov     opc,al
    zap     Peremenaya_adc,4
    del_na_modrm
    cmp     mode,3
    jz      regbregb
    cmp     mode,2
    jz      mem_16_regb
    cmp     mode,1
    jz      mem_8_regb
    jmp     mem_regb
mem_16_regb:
    push    si
    cmp     mem_e,1
    jz      zapis_dmem_32_regb
    cmp     segm,0
    jz      mem_16_regb_no_segm
    mov     dx,segm
    mov     cx,3
    call    zapis
zapis_mem_16_regb:
    zap     left_par,1
    movzx   si,rm
    call    check_len
    shl     si,1
    mov     dx,effective_addresses[si]
    call    zapis
    zap     plus,3
    pop     si
    inc     si
    call    zap_disp
    call    zap_disp
    add     si,3
    push    si
    zap     h,1
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
zapis_dmem_32_regb:
    call    check_segm_rmem
    zap     left_par,1
    pop     si
    dec     si
    lodsb
    push    ax
    and     al,00001111b
    cmp     al,04h
    jz      dv_sib_disp32
    cmp     al,0Ch
    jz      dv_sib_disp32
    pop     ax
    push    si
    movzx   si,rm
    add     si,16
    shl     si,1
    mov     dx,registers[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    pop     si
    add     si,3
    call    zap_disp
    call    zap_disp
    call    zap_disp
    call    zap_disp
    add     si,5
    push    si
    zap     h,1
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
dv_sib_disp32:
    pop     ax
    del_na_sib
    push    si
    movzx   si,sssib
    cmp     si,1
    jz      @@zapis_sib01_disp32
    cmp     si,2
    jz      @@zapis_sib10_disp32
    cmp     si,3
    jz      @@zapis_sib11_disp32
@@zapis_sib00_disp32:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    pop     si
    add     si,3
    call    zap_disp
    call    zap_disp
    call    zap_disp
    call    zap_disp
    add     si,5
    push    si
    zap     h,1
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
@@zapis_sib01_disp32:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss01_sib[si]
    mov     cx,5
    call    zapis
    zap     plus,3
    pop     si
    add     si,3
    call    zap_disp
    call    zap_disp
    call    zap_disp
    call    zap_disp
    add     si,5
    push    si
    zap     h,1
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
@@zapis_sib10_disp32:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss10_sib[si]
    mov     cx,5
    call    zapis
    zap     plus,3
    pop     si
    add     si,3
    call    zap_disp
    call    zap_disp
    call    zap_disp
    call    zap_disp
    add     si,5
    push    si
    zap     h,1
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
@@zapis_sib11_disp32:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss11_sib[si]
    mov     cx,5
    call    zapis
    zap     plus,3
    pop     si
    add     si,3
    call    zap_disp
    call    zap_disp
    call    zap_disp
    call    zap_disp
    add     si,5
    push    si
    zap     h,1
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
mem_16_regb_no_segm:
    movzx   si,rm
    cmp     si,2
    jz      mem_16_regb_zapis_ss
    cmp     si,3
    jz      mem_16_regb_zapis_ss
    cmp     si,6
    jz      mem_16_regb_zapis_ss
mem_16_regb_zapis_ds:
    zap     REG_DS,3
    jmp     zapis_mem_16_regb
mem_16_regb_zapis_ss:
    zap     REG_SS,3
    jmp     zapis_mem_16_regb
mem_8_regb:
    cmp     mem_e,1
    jz      rmem_8_regb
    push    si
    cmp     segm,0
    jz      mem_8_regb_no_segm
    mov     dx,segm
    mov     cx,3
    call    zapis
zapis_mem_8_regb:
    zap     left_par,1
    movzx   si,rm
    call    check_len
    shl     si,1
    mov     dx,effective_addresses[si]
    call    zapis
    pop     si
    lodsb
    cmp     al,0
    jz      zz
    call    razdelenie
    push    si
    mov     disp,ax
    zap     plus,3
    zap     disp,2
    zap     h,1
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
check_len:
    cmp     rm,3
    jbe     len_7
    mov     cx,2
    ret
len_7:
    mov     cx,7
    ret
zz:
    push    si
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
mem_8_regb_no_segm:
    movzx   si,rm
    cmp     si,2
    jz      mem_8_regb_zapis_ss
    cmp     si,3
    jz      mem_8_regb_zapis_ss
    cmp     si,6
    jz      mem_8_regb_zapis_ss
mem_8_regb_zapis_ds:
    zap     REG_DS,3
    jmp     zapis_mem_8_regb
mem_8_regb_zapis_ss:
    zap     REG_SS,3
    jmp     zapis_mem_8_regb
rmem_8_regb:
    push    si
    movzx   si,rm
    cmp     segm,0
    jz      rmem_8_regb_no_segm
    mov     dx,segm
    mov     cx,3
    call    zapis
zapis_rmem_8_regb:
    zap     left_par,1
    mov     al,moderm
    and     al,00001111b
    cmp     al,04h
    jz      dv_sib_disp8
    cmp     al,0Ch
    jz      dv_sib_disp8
    movzx   si,rm
    add     si,16
    shl     si,1
    mov     dx,registers[si]
    mov     cx,3
    call    zapis
    pop     si
    lodsb
    cmp     al,0
    jz      skip_00z
    zap     plus,3
    dec     si
    call    zap_disp
    add     si,2
    zap     h,1
    zap     right_par,1
    zap     reg1,1
    push    si
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
skip_00z:
    push    si
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
rmem_8_regb_no_segm:
    cmp     si,5
    jz      rmem_8_regb_zapis_ss
    zap     REG_DS,3
    jmp     zapis_rmem_8_regb
rmem_8_regb_zapis_ss:
    zap     REG_SS,3
    jmp     zapis_rmem_8_regb
dv_sib_disp8:
    pop     si
    del_na_sib
    push    si
    movzx   si,sssib
    cmp     si,1
    jz      @@zapis_sib01_disp8
    cmp     si,2
    jz      @@zapis_sib10_disp8
    cmp     si,3
    jz      @@zapis_sib11_disp8
@@zapis_sib00_disp8:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    pop     si
    call    zap_disp
    add     si,2
    push    si
    zap     h,1
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
@@zapis_sib01_disp8:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss01_sib[si]
    mov     cx,5
    call    zapis
    zap     plus,3
    pop     si
    call    zap_disp
    add     si,2
    push    si
    zap     h,1
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
@@zapis_sib10_disp8:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss10_sib[si]
    mov     cx,5
    call    zapis
    zap     plus,3
    pop     si
    call    zap_disp
    add     si,2
    push    si
    zap     h,1
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
@@zapis_sib11_disp8:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss11_sib[si]
    mov     cx,5
    call    zapis
    zap     plus,3
    pop     si
    call    zap_disp
    add     si,2
    push    si
    zap     h,1
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
mem_regb:
    cmp     mem_e,1
    jz      rmem_regb
    push    si
    movzx   si,rm
    cmp     si,6
    jz      mem_regb_zapis_disp16
    cmp     segm,0
    jz      mem_regb_no_segm
    mov     dx,segm
    mov     cx,3
    call    zapis
zapis_memb:
    zap     left_par,1
    movzx   si,rm
    call    check_len
    shl     si,1
    mov     dx,effective_addresses[si]
    call    zapis
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
rmem_regb:
    push    si
    movzx   si,rm
    cmp     segm,0
    jz      rmem_regb_no_segm
    mov     dx,segm
    mov     cx,3
    call    zapis
zapis_rmem_regb:
    cmp     si,4
    jz      sib_rmem_regb
    cmp     si,5
    jz      zapis_disp32
    zap     left_par,1
    add     si,16
    shl     si,1
    mov     dx,registers[si]
    mov     cx,3
    call    zapis
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
sib_rmem_regb:
    zap     left_par,1
    pop     si
    del_na_sib
    push    si
    movzx   si,sssib
    cmp     si,1
    jz      @@zapis_sib01
    cmp     si,2
    jz      @@zapis_sib10
    cmp     si,3
    jz      @@zapis_sib11
@@zapis_sib00:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
@@zapis_sib01:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss01_sib[si]
    mov     cx,5
    call    zapis
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
@@zapis_sib10:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss10_sib[si]
    mov     cx,5
    call    zapis
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
@@zapis_sib11:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss11_sib[si]
    mov     cx,5
    call    zapis
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
zapis_disp32:
    zap     left_par,1
    pop     si
    add     si,3
    call    zap_disp
    call    zap_disp
    call    zap_disp
    call    zap_disp
    add     si,5
    push    si
    zap     h,1
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
rmem_regb_no_segm:
    zap     REG_DS,3
    jmp     zapis_rmem_regb
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
mem_regb_zapis_disp16:
    pop     si
    call    check_segm
    zap     left_par,1
    inc     si
    call    zap_disp
    call    zap_disp
    add     si,3
    zap     h,1
    zap     right_par,1
    zap     reg1,1
    push    si
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
mem_regb_no_segm:
    movzx   si,rm
    cmp     si,2
    jz      mem_regb_zapis_ss
    cmp     si,3
    jz      mem_regb_zapis_ss
mem_regb_zapis_ds:
    zap     REG_DS,3
    jmp     zapis_memb
mem_regb_zapis_ss:
    zap     REG_SS,3
    jmp     zapis_memb
regbregb:
    push    si
    movzx   si,rm
    shl     si,1
    mov     dx,registers[si]
    mov     cx,2
    call    zapis
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
opc11:
    mov     opc,al
    zap     Peremenaya_adc,4
    del_na_modrm
    cmp     mode,3
    jz      regvregv
    cmp     mode,2
    jz      mem_16_regv
    cmp     mode,1
    jz      mem_8_regv
    jmp     mem_regv
mem_16_regv:
    push    si
    cmp     mem_e,1
    jz      zapis_dmem_32_regv
    cmp     segm,0
    jz      mem_16_regv_no_segm
    mov     dx,segm
    mov     cx,3
    call    zapis
zapis_mem_16_regv:
    zap     left_par,1
    movzx   si,rm
    call    check_len
    shl     si,1
    mov     dx,effective_addresses[si]
    call    zapis
    zap     plus,3
    pop     si
    inc     si
    call    zap_disp
    call    zap_disp
    add     si,3
    push    si
    zap     h,1
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
zapis_dmem_32_regv:
    call    check_segm_rmem
    zap     left_par,1
    pop     si
    dec     si
    lodsb
    push    ax
    and     al,00001111b
    cmp     al,04h
    jz      dv_sib_disp32
    cmp     al,0Ch
    jz      dv_sib_disp32
    pop     ax
    push    si
    movzx   si,rm
    add     si,16
    shl     si,1
    mov     dx,registers[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    pop     si
    add     si,3
    call    zap_disp
    call    zap_disp
    call    zap_disp
    call    zap_disp
    add     si,5
    push    si
    zap     h,1
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
mem_16_regv_no_segm:
    movzx   si,rm
    cmp     si,2
    jz      mem_16_regv_zapis_ss
    cmp     si,3
    jz      mem_16_regv_zapis_ss
    cmp     si,6
    jz      mem_16_regv_zapis_ss
mem_16_regv_zapis_ds:
    zap     REG_DS,3
    jmp     zapis_mem_16_regv
mem_16_regv_zapis_ss:
    zap     REG_SS,3
    jmp     zapis_mem_16_regv
mem_8_regv:
    cmp     mem_e,1
    jz      rmem_8_regv
    push    si
    cmp     segm,0
    jz      mem_8_regv_no_segm
    mov     dx,segm
    mov     cx,3
    call    zapis
zapis_mem_8_regv:
    zap     left_par,1
    movzx   si,rm
    call    check_len
    shl     si,1
    mov     dx,effective_addresses[si]
    call    zapis
    pop     si
    lodsb
    cmp     al,0
    jz      zzz
    call    razdelenie
    push    si
    mov     disp,ax
    zap     plus,3
    zap     disp,2
    zap     h,1
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
zzz:
    push    si
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
mem_8_regv_no_segm:
    movzx   si,rm
    cmp     si,2
    jz      mem_8_regv_zapis_ss
    cmp     si,3
    jz      mem_8_regv_zapis_ss
    cmp     si,6
    jz      mem_8_regv_zapis_ss
mem_8_regv_zapis_ds:
    zap     REG_DS,3
    jmp     zapis_mem_8_regv
mem_8_regv_zapis_ss:
    zap     REG_SS,3
    jmp     zapis_mem_8_regv
rmem_8_regv:
    push    si
    movzx   si,rm
    cmp     segm,0
    jz      rmem_8_regv_no_segm
    mov     dx,segm
    mov     cx,3
    call    zapis
zapis_rmem_8_regv:
    zap     left_par,1
    mov     al,moderm
    and     al,00001111b
    cmp     al,04h
    jz      dv_sib_disp8
    cmp     al,0Ch
    jz      dv_sib_disp8
    movzx   si,rm
    add     si,16
    shl     si,1
    mov     dx,registers[si]
    mov     cx,3
    call    zapis
    pop     si
    lodsb
    cmp     al,0
    jz      skip_00zz
    zap     plus,3
    dec     si
    call    zap_disp
    add     si,2
    zap     h,1
    zap     right_par,1
    zap     reg1,1
    push    si
    call    zapis_reg
    call    reset_values
    pop     si
    jmp     prefix_oper
skip_00zz:
    push    si
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    zap     enterr,2
    call    reset_values
    jmp     prefix_oper
rmem_8_regv_no_segm:
    cmp     si,5
    jz      rmem_8_regv_zapis_ss
    zap     REG_DS,3
    jmp     zapis_rmem_8_regv
rmem_8_regv_zapis_ss:
    zap     REG_SS,3
    jmp     zapis_rmem_8_regv
mem_regv:
    cmp     mem_e,1
    jz      rmem_regv
    push    si
    movzx   si,rm
    cmp     si,6
    jz      mem_regv_zapis_disp16
    cmp     segm,0
    jz      mem_regv_no_segm
    mov     dx,segm
    mov     cx,3
    call    zapis
zapis_memv:
    zap     left_par,1
    movzx   si,rm
    call    check_len
    shl     si,1
    mov     dx,effective_addresses[si]
    call    zapis
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
rmem_regv:
    push    si
    movzx   si,rm
    cmp     segm,0
    jz      rmem_regv_no_segm
    mov     dx,segm
    mov     cx,3
    call    zapis
zapis_rmem_regv:
    cmp     si,4
    jz      sib_rmem_regv
    cmp     si,5
    jz      zapis_disp32
    zap     left_par,1
    add     si,16
    shl     si,1
    mov     dx,registers[si]
    mov     cx,3
    call    zapis
    zap     right_par,1
    zap     reg1,1
    cmp     reg_e,1
    jz      zapis_regdv
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
zapis_regdv:
    movzx   si,reg
    add     si,16
    shl     si,1
    mov     dx,registers[si]
    mov     cx,3
    call    zapis
    pop     si
    call    reset_values
    zap     enterr,2
    jmp     prefix_oper
sib_rmem_regv:
    zap     left_par,1
    pop     si
    del_na_sib
    push    si
    movzx   si,sssib
    cmp     si,1
    jz      @@zapis_sib01
    cmp     si,2
    jz      @@zapis_sib10
    cmp     si,3
    jz      @@zapis_sib11
@@zapis_sib00:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
@@zapis_sib01:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss01_sib[si]
    mov     cx,5
    call    zapis
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
@@zapis_sib10:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss10_sib[si]
    mov     cx,5
    call    zapis
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
@@zapis_sib11:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss11_sib[si]
    mov     cx,5
    call    zapis
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
rmem_regv_no_segm:
    cmp     si,5
    jz      rmem_regv_zapis_ss
    zap     REG_DS,3
    jmp     zapis_rmem_regv
rmem_regv_zapis_ss:
    zap     REG_SS,3
    jmp     zapis_rmem_regv
mem_regv_zapis_disp16:
    pop     si
    call    check_segm
    zap     left_par,1
    inc     si
    call    zap_disp
    call    zap_disp
    add     si,3
    zap     h,1
    zap     right_par,1
    zap     reg1,1
    push    si
    call    zapis_reg
    pop     si
    jmp     prefix_oper
mem_regv_no_segm:
    movzx   si,rm
    cmp     si,2
    jz      mem_regv_zapis_ss
    cmp     si,3
    jz      mem_regv_zapis_ss
mem_regv_zapis_ds:
    zap     REG_DS,3
    jmp     zapis_memv
mem_regv_zapis_ss:
    zap     REG_SS,3
    jmp     zapis_memv
regvregv:
    cmp     reg_e,1
    jz      regdvregdv
    push    si
    movzx   si,rm
    add     si,8
    shl     si,1
    mov     dx,registers[si]
    mov     cx,2
    call    zapis
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
regdvregdv:
    push    si
    movzx   si,rm
    add     si,16
    shl     si,1
    mov     dx,registers[si]
    mov     cx,3
    call    zapis
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
opc12:
    mov     opc,al
    zap     Peremenaya_adc,4
    del_na_modrm
    cmp     mode,3
    jz      regbregbopc12
    cmp     mode,2
    jz      regb_mem_16
    cmp     mode,1
    jz      regb_mem_8
    jmp     regb_mem
regb_mem_16:
    push    si
    call    zapis_reg
    cmp     mem_e,1
    jz      zapis_regb_dmem_32
    cmp     segm,0
    jz      regb_mem_16_no_segm
    mov     dx,segm
    mov     cx,3
    call    zapis
zapis_regb_mem_16:
    zap     left_par,1
    movzx   si,rm
    call    check_len
    shl     si,1
    mov     dx,effective_addresses[si]
    call    zapis
    zap     plus,3
    pop     si
    inc     si
    call    zap_disp
    call    zap_disp
    add     si,3
    zap     h,1
    zap     right_par,1
    zap     enterr,2
    call    reset_values
    jmp     prefix_oper
zapis_regb_dmem_32:
    call    check_segm_rmem
    zap     left_par,1
    pop     si
    dec     si
    lodsb
    push    ax
    and     al,00001111b
    cmp     al,04h
    jz      dv_sib_disp32_opc12
    cmp     al,0Ch
    jz      dv_sib_disp32_opc12
    pop     ax
    push    si
    movzx   si,rm
    add     si,16
    shl     si,1
    mov     dx,registers[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    pop     si
    add     si,3
    call    zap_disp
    call    zap_disp
    call    zap_disp
    call    zap_disp
    add     si,5
    zap     h,1
    zap     right_par,1
    zap     enterr,2
    call    reset_values
    jmp     prefix_oper
dv_sib_disp32_opc12:
    pop     ax
    del_na_sib
    push    si
    movzx   si,sssib
    cmp     si,1
    jz      @@zapis_sib01_disp32
    cmp     si,2
    jz      @@zapis_sib10_disp32
    cmp     si,3
    jz      @@zapis_sib11_disp32
@@zapis_sib00_disp32:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    pop     si
    add     si,3
    call    zap_disp
    call    zap_disp
    call    zap_disp
    call    zap_disp
    add     si,5
    zap     h,1
    zap     right_par,1
    zap     enterr,2
    call    reset_values
    jmp     prefix_oper
@@zapis_sib01_disp32:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss01_sib[si]
    mov     cx,5
    call    zapis
    zap     plus,3
    pop     si
    add     si,3
    call    zap_disp
    call    zap_disp
    call    zap_disp
    call    zap_disp
    add     si,5
    zap     h,1
    zap     right_par,1
    zap     enterr,2
    call    reset_values
    jmp     prefix_oper
@@zapis_sib10_disp32:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss10_sib[si]
    mov     cx,5
    call    zapis
    zap     plus,3
    pop     si
    add     si,3
    call    zap_disp
    call    zap_disp
    call    zap_disp
    call    zap_disp
    add     si,5
    zap     h,1
    zap     right_par,1
    zap     enterr,2
    call    reset_values
    jmp     prefix_oper
@@zapis_sib11_disp32:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss11_sib[si]
    mov     cx,5
    call    zapis
    zap     plus,3
    pop     si
    add     si,3
    call    zap_disp
    call    zap_disp
    call    zap_disp
    call    zap_disp
    add     si,5
    zap     h,1
    zap     right_par,1
    zap     enterr,2
    call    reset_values
    jmp     prefix_oper
regb_mem_16_no_segm:
    movzx   si,rm
    cmp     si,2
    jz      regb_mem_16_zapis_ss
    cmp     si,3
    jz      regb_mem_16_zapis_ss
    cmp     si,6
    jz      regb_mem_16_zapis_ss
regb_mem_16_zapis_ds:
    zap     REG_DS,3
    jmp     zapis_regb_mem_16
regb_mem_16_zapis_ss:
    zap     REG_SS,3
    jmp     zapis_regb_mem_16
regb_mem_8:
    push    si
    call    zapis_reg
    cmp     mem_e,1
    jz      regb_rmem_8
    cmp     segm,0
    jz      regb_mem_8_no_segm
    mov     dx,segm
    mov     cx,3
    call    zapis
zapis_regb_mem_8:
    zap     left_par,1
    movzx   si,rm
    call    check_len
    shl     si,1
    mov     dx,effective_addresses[si]
    call    zapis
    pop     si
    lodsb
    cmp     al,0
    jz      z0
    call    razdelenie
    mov     disp,ax
    zap     plus,3
    zap     disp,2
    zap     h,1
    zap     right_par,1
    zap     enterr,2
    call    reset_values
    jmp     prefix_oper
z0:
    zap     right_par,1
    zap     enterr,2
    call    reset_values
    jmp     prefix_oper
regb_mem_8_no_segm:
    movzx   si,rm
    cmp     si,2
    jz      regb_mem_8_zapis_ss
    cmp     si,3
    jz      regb_mem_8_zapis_ss
    cmp     si,6
    jz      regb_mem_8_zapis_ss
regb_mem_8_zapis_ds:
    zap     REG_DS,3
    jmp     zapis_regb_mem_8
regb_mem_8_zapis_ss:
    zap     REG_SS,3
    jmp     zapis_regb_mem_8
regb_rmem_8:
    movzx   si,rm
    cmp     segm,0
    jz      regb_rmem_8_no_segm
    mov     dx,segm
    mov     cx,3
    call    zapis
zapis_regb_rmem_8:
    zap     left_par,1
    mov     al,moderm
    and     al,00001111b
    cmp     al,04h
    jz      dv_sib_disp8_opc12
    cmp     al,0Ch
    jz      dv_sib_disp8_opc12
    movzx   si,rm
    add     si,16
    shl     si,1
    mov     dx,registers[si]
    mov     cx,3
    call    zapis
    pop     si
    lodsb
    cmp     al,0
    jz      skip_000z
    zap     plus,3
    dec     si
    call    zap_disp
    add     si,2
    zap     h,1
    zap     right_par,1
    zap     enterr,2
    call    reset_values
    jmp     prefix_oper
skip_000z:
    zap     right_par,1
    zap     enterr,2
    call    reset_values
    jmp     prefix_oper
regb_rmem_8_no_segm:
    cmp     si,5
    jz      regb_rmem_8_zapis_ss
    zap     REG_DS,3
    jmp     zapis_regb_rmem_8
regb_rmem_8_zapis_ss:
    zap     REG_SS,3
    jmp     zapis_regb_rmem_8
dv_sib_disp8_opc12:
    pop     si
    del_na_sib
    push    si
    movzx   si,sssib
    cmp     si,1
    jz      @@zapis_sib01_disp8
    cmp     si,2
    jz      @@zapis_sib10_disp8
    cmp     si,3
    jz      @@zapis_sib11_disp8
@@zapis_sib00_disp8:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    pop     si
    call    zap_disp
    add     si,2
    zap     h,1
    zap     right_par,1
    zap     enterr,2
    call    reset_values
    jmp     prefix_oper
@@zapis_sib01_disp8:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss01_sib[si]
    mov     cx,5
    call    zapis
    zap     plus,3
    pop     si
    call    zap_disp
    add     si,2
    push    si
    zap     h,1
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
@@zapis_sib10_disp8:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss10_sib[si]
    mov     cx,5
    call    zapis
    zap     plus,3
    pop     si
    call    zap_disp
    add     si,2
    push    si
    zap     h,1
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
@@zapis_sib11_disp8:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss11_sib[si]
    mov     cx,5
    call    zapis
    zap     plus,3
    pop     si
    call    zap_disp
    add     si,2
    push    si
    zap     h,1
    zap     right_par,1
    zap     reg1,1
    call    zapis_reg
    pop     si
    call    reset_values
    jmp     prefix_oper
regb_mem:
    push    si
    call    zapis_reg
    cmp     mem_e,1
    jz      regb_rmem
    movzx   si,rm
    cmp     si,6
    jz      regb_mem_zapis_disp16
    cmp     segm,0
    jz      regb_mem_no_segm
    mov     dx,segm
    mov     cx,3
    call    zapis
zapis_memb_opc12:
    zap     left_par,1
    movzx   si,rm
    call    check_len
    shl     si,1
    mov     dx,effective_addresses[si]
    call    zapis
    zap     right_par,1
    zap     enterr,2
    pop     si
    call    reset_values
    jmp     prefix_oper
regb_rmem:
    movzx   si,rm
    cmp     segm,0
    jz      regb_rmem_no_segm
    mov     dx,segm
    mov     cx,3
    call    zapis
zapis_regb_rmem:
    cmp     si,4
    jz      sib_regb_rmem
    cmp     si,5
    jz      zapis_disp32_opc12
    zap     left_par,1
    add     si,16
    shl     si,1
    mov     dx,registers[si]
    mov     cx,3
    call    zapis
    zap     right_par,1
    zap     enterr,2
    pop     si
    call    reset_values
    jmp     prefix_oper
sib_regb_rmem:
    zap     left_par,1
    pop     si
    del_na_sib
    push    si
    movzx   si,sssib
    cmp     si,1
    jz      @@zapis_sib01
    cmp     si,2
    jz      @@zapis_sib10
    cmp     si,3
    jz      @@zapis_sib11
@@zapis_sib00:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     right_par,1
    zap     enterr,2
    pop     si
    call    reset_values
    jmp     prefix_oper
@@zapis_sib01:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss01_sib[si]
    mov     cx,5
    call    zapis
    zap     right_par,1
    zap     enterr,2
    pop     si
    call    reset_values
    jmp     prefix_oper
@@zapis_sib10:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss10_sib[si]
    mov     cx,5
    call    zapis
    zap     right_par,1
    zap     enterr,2
    pop     si
    call    reset_values
    jmp     prefix_oper
@@zapis_sib11:
    movzx   si,base
    shl     si,1
    mov     dx,ss00_sib[si]
    mov     cx,3
    call    zapis
    zap     plus,3
    movzx   si,index
    shl     si,1
    mov     dx,ss11_sib[si]
    mov     cx,5
    call    zapis
    zap     right_par,1
    zap     enterr,2
    pop     si
    call    reset_values
    jmp     prefix_oper
zapis_disp32_opc12:
    zap     left_par,1
    pop     si
    add     si,3
    call    zap_disp
    call    zap_disp
    call    zap_disp
    call    zap_disp
    add     si,5
    zap     h,1
    zap     right_par,1
    zap     enterr,2
    call    reset_values
    jmp     prefix_oper
regb_rmem_no_segm:
    zap     REG_DS,3
    jmp     zapis_regb_rmem
regb_mem_zapis_disp16:
    pop     si
    call    check_segm
    zap     left_par,1
    inc     si
    call    zap_disp
    call    zap_disp
    add     si,3
    zap     h,1
    zap     right_par,1
    zap     enterr,2
    call    reset_values
    jmp     prefix_oper
regb_mem_no_segm:
    movzx   si,rm
    cmp     si,2
    jz      regb_mem_zapis_ss
    cmp     si,3
    jz      regb_mem_zapis_ss
regb_mem_zapis_ds:
    zap     REG_DS,3
    jmp     zapis_memb_opc12
regb_mem_zapis_ss:
    zap     REG_SS,3
    jmp     zapis_memb_opc12
regbregbopc12:
    push    si
    call    zapis_reg
    movzx   si,rm
    shl     si,1
    mov     dx,registers[si]
    mov     cx,2
    call    zapis
    zap     enterr,2
    pop     si
    call    reset_values
    jmp     prefix_oper
opc13:
    mov     opc,al
    zap     Peremenaya_adc,4
    del_na_modrm
    cmp     mode,3
    jz      regbregbopc13
    cmp     mode,2
    jz      regb_mem_16
    cmp     mode,1
    jz      regb_mem_8
    jmp     regb_mem
regbregbopc13:
    push    si
    call    zapis_reg
    movzx   si,rm
    add     si,8
    shl     si,1
    mov     dx,registers[si]
    mov     cx,2
    call    zapis
    zap     enterr,2
    pop     si
    call    reset_values
    jmp     prefix_oper
opc14:
    mov     opc,al
    zap     Peremenaya_adc,4
    push    si
    call    zapis_reg
    pop     si
    lodsb
    push    ax
    call    check_disp
    pop     ax
    call    razdelenie
    mov     disp,ax
    zap     disp,2
    zap     h,1
    zap     enterr,2
    call    reset_values
    jmp     prefix_oper
opc15:
    mov     opc,al
    zap     Peremenaya_adc,4
    push    si
    call    zapis_reg
    cmp     reg_e,1
    jz      opc15_imm32
    pop     si
    inc     si
    call    zap_disp
    call    zap_disp
    add     si,3
    zap     h,1
    zap     enterr,2
    call    reset_values
    jmp     prefix_oper
opc15_imm32:
    pop     si
    add     si,3
    call    zap_disp
    call    zap_disp
    call    zap_disp
    call    zap_disp
    add     si,5
    zap     h,1
    zap     enterr,2
    call    reset_values
    jmp     prefix_oper
Exit:
    mov     ax,4C00h
    int     21h
    end     Start 
    
    
    
    
    
    
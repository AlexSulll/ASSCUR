.model small
.186
.stack  100h
.data
    buffer          db      1024 DUP(?)
    read_file       db      'COM.COM',0
    com_file        db      'result.asm',0
    Peremenaya_adc  db      9,'adc',9,'$'
    reg1            db      ' ,$'
    reg2            db      ' $'
    two_bite_prefix db      '0F $'
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
nachalo:
    mov     si,offset buffer
    lodsb
    cmp     al,10h
    jz      opc10
    
opc10:
    lodsb
    
Exit:
    mov     ax,4C00h
    int     21h
    end     Start 
    
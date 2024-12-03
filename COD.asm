.model small
.186
.stack  100h
.data
    buffer          db      1024 DUP(?)
    read_file       db      'COM.COM',0
    com_file        db      'result.asm',0
    Peremenaya_adc  db      9,'adc',9,'$'
.code
Start:
    mov     ax,@data
    mov     ds,ax
    mov     es,ax
    
    mov     dx,offset read_file
    mov     ax,3D02h
    int     21h
    
    end     Start
    
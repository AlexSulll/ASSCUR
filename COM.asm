.model tiny
.386
.data
    A   db    10
.code
org     100h
Start:
    adc10   macro op
    db      10h,op
    endm
    adc10   0C0h;10op
    adc10   0C8h
    adc10   0C1h
    adc10   0F1h
    adc10   0F5h
    adc10   0D5h
    adc     ds:[bx+si],ah
    
    adc11   macro op;macros 11h + oper
    db      11h,op
    endm
    adc11   0C0h;11op
    adc11   0C8h
    adc11   0C1h
    adc11   0D1h
    adc11   0D9h
    adce11  macro op ;macro 66h + adc11 = 66h+11h+oper
    db      66h
    adc11   op
    endm
    adce11  0C0h
    adce11  0C8h
    adce11  0C1h
    adce11  0D1h
    adce11  0D9h
    adc     ds:[bx+si],ax
    adc     ds:[ebx+esi],eax
    
    
    adc     al,bh
    adc     cl,11h
    adc     dl,11h
    adc     bl,11h
    adc     ah,11h
    adc     ch,11h
    adc     dh,11h
    adc     bh,11h


    adc     al,11h;82op
    adc     cl,11h
    adc     dl,11h
    adc     bl,11h
    adc     ah,11h
    adc     ch,11h
    adc     dh,11h
    adc     bh,11h
    
    adc     eax,11h
    adc     ecx,11h
    adc     edx,11h
    adc     ebx,11h
    adc     esp,11h
    adc     ebp,11h
    adc     esi,11h
    adc     edi,11h
    
    adc     ax,1111h
    adc     cx,1111h
    adc     dx,1111h
    adc     bx,1111h
    adc     sp,1111h
    adc     bp,1111h
    adc     si,1111h
    adc     di,1111h
    
    adc     eax,1111h
    adc     ecx,1111h
    adc     edx,1111h
    adc     ebx,1111h
    adc     esp,1111h
    adc     ebp,1111h
    adc     esi,1111h
    adc     edi,1111h
    
    adc     es:[bx+si],11h
    adc     cs:[si+11h],11h
    adc     ss:[bx+1111h],1111h
    adc     ax,1111h
    adc     al,11h
    adc     ds:[bx+si],ah
    adc     es:[si+11h],cx
    adc     cs:[bp+di+1111h],bl
    adc     a,bh
    adc     ax,bx
    adc     ch,dl
    adc     ax,ss:[bx+si]
    adc     bp,es:[si+1111h]
    adc     sp,cs:[bp+11h]
    adc     ah,a
    
    end Start
    
    
    
    
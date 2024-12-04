.model tiny
.386
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
    adc     ds:[bx+si],ah
    adc     ds:[bx+si+11h],ah
    adc     ds:[bx+si+1111h],ah
    
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
    adc     es:[bx+si],ax
    adc     ds:[bx+si+11h],ax
    adc     ds:[bx+si+1111h],ax
    adc     fs:[ebx+esi],eax
    adc     es:[ebx+esi+11h],eax
    adc     gs:[ebx+esi+1111h],eax
    adc     ss:[ebx+esi+11111111h],eax
    
    adc     ah,cl;12 op
    adc     al,dh
    adc     dl,ch
    adc     ch,ds:[bx+si]
    adc     ch,ds:[bx+si+11h]
    adc     ch,ds:[bx+si+1111h]
    
    adc     ax,ax;13op
    adc     cx,dx
    adc     cx,ax
    adc     ax,cx
    adc     ax,es:[bx+si]
    adc     ax,es:[bx+si+11h]
    adc     ax,es:[bx+si+1111h]
    adc     eax,es:[ebx+esi]
    adc     ecx,fs:[ebx+esi+11h]
    adc     edx,gs:[ebx+esi+1111h]
    adc     ebx,cs:[ebx+esi+11111111h]
    
    adc     al,11h;14op
    
    adc     ax,1111h;15op
    adc     eax,11111111h
    
    adc     cl,11h;80op
    adc     dl,11h
    adc     bl,11h
    adc     ah,11h
    adc     ch,11h
    adc     dh,11h
    adc     bh,11h
    adc     byte ptr ds:[bx+si],11h
    adc     byte ptr fs:[bx+si+11h],11h
    adc     byte ptr es:[bx+si+1111h],11h

    adc     cx,1111h;81op
    adc     dx,1111h
    adc     bx,1111h
    adc     sp,1111h
    adc     bp,1111h
    adc     si,1111h
    adc     di,1111h
    adc     word ptr ds:[bx+si],1111h
    adc     word ptr fs:[bx+si+11h],1111h
    adc     word ptr es:[bx+si+1111h],1111h
    adc     word ptr ds:[ebx+esi],1111h
    adc     word ptr fs:[ebx+esi+11h],1111h
    adc     word ptr es:[ebx+esi+1111h],1111h
    adc     dword ptr gs:[bx+si],1111h
    adc     dword ptr fs:[bx+si+11h],11111111h
    adc     dword ptr ds:[bx+si+1111h],11116543h
    adc     dword ptr gs:[ebx+esi],1111h
    adc     dword ptr fs:[ebx+esi+11h],11111111h
    adc     dword ptr ds:[ebx+esi+1111h],11116543h
    
    ;82 est' li on?
    
    adc     cx,11h;83op
    adc     dx,11h
    adc     bx,11h
    adc     sp,11h
    adc     bp,11h
    adc     si,11h
    adc     di,11h
    adc     eax,11h
    adc     ecx,11h
    adc     edx,11h
    adc     ebx,11h
    adc     esp,11h
    adc     ebp,11h
    adc     esi,11h
    adc     edi,11h
    adc     word ptr ds:[bx+si],11h
    adc     word ptr fs:[bx+si+11h],11h
    adc     word ptr es:[bx+si+1111h],11h
    adc     word ptr ds:[ebx+esi],11h
    adc     word ptr fs:[ebx+esi+11h],11h
    adc     word ptr es:[ebx+esi+1111h],11h
    adc     dword ptr gs:[bx+si],11h
    adc     dword ptr fs:[bx+si+11h],11h
    adc     dword ptr ds:[bx+si+1111h],11h
    adc     dword ptr gs:[ebx+esi],11h
    adc     dword ptr fs:[ebx+esi+11h],11h
    adc     dword ptr ds:[ebx+esi+1111h],11h
    end     Start
    
    
    
    
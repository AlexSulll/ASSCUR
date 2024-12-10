.model tiny
.386
.code
org     100h
Start:
    adc10   macro op
    db      10h,op
    endm
    LOCK REPNZ adc10   0C0h;10op
    REP adc10   0C8h
    adc10   0C1h
    adc10   0F1h
    adc10   0F5h
    adc10   0D5h
    adc     ds:[5643h],ah
    adc     gs:[bx+si],ah
    adc     fs:[bx+si],ah
    adc     fs:[bx+si+11h],ah;mem_8_regb
    adc     fs:[bx+si+9876h],ah;mem_16_regb
    adc     fs:[1111h],ah
    adc     fs:[bp],ah;mem_8_regb
    adc     es:[bp+98h],al;mem_16_regb
    adc     gs:[eax],al
    adc     ss:[ebp],al;TODO rmem_regb
    
    adc11   macro op;macros 11h + oper
    db      11h,op
    endm
    adc11   0C0h;11op
    adc11   0C8h;regvregv
    adc11   0C1h;regvregv
    adc11   0D1h;regvregv
    adc11   0D9h;regvregv
    
    adce11  macro op ;macro 66h + adc11 = 66h+11h+oper
    db      66h
    adc11   op
    endm
    adce11  0C0h;regdvregdv
    adce11  0C8h;regdvregdv
    adce11  0C1h;regdvregdv
    adce11  0D1h;regdvregdv
    adce11  0D9h;regdvregdv
    adc     gs:[5641h],ax;mem_regv
    adc     fs:[1234h],di;mem_regv
    adc     ds:[bx+si],ax;mem_regv
    adc     es:[bx+si],ax;mem_regv
    adc     ds:[bx+si+11h],ax;mem_8_regv
    adc     ss:[di+11h],di;mem_8_regv
    adc     ds:[bx+si+1111h],ax;mem_16_regv
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    adc     cs:[eax],eax;rmem_reg
    adc     fs:[eax],ax;rmem_reg
    adc     es:[eax],ax;rmem_reg
    adc     ss:[eax+11h],ax;rmem_8_reg
    adc     ss:[eax+11h],al;rmem_8_reg
    adc     ss:[eax+11h],eax;rmem_8_reg
    adc     fs:[eax+5684h],ax;rmem_8_reg
    adc     gs:[eax+1111h],al;rmem_8_reg
    adc     es:[eax+1111h],eax;rmem_8_reg
    adc     fs:[ebx+esi],eax;TODO sib bayit mod=00
    adc     fs:[ebx+esi],ax;
    adc     es:[ebx+esi+11h],eax;
    adc     gs:[ebx+esi+1111h],eax;
    adc     ss:[ebx+esi+11111111h],eax;
    
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
    
    
    
    
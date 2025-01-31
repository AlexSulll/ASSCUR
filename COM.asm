.model tiny
.386
.code
org     100h
Start:
    adc     fs:[esp+11h],al
    adc     fs:[ebp],al
    adc     fs:[ebp+ebp*8],al
    adc     fs:[eax*8],al
    adc     fs:[esp],al
    adc     [ebp+0AFFFFFFFh],ch
    adc10   macro op
    db      10h,op
    endm
    adc     [si],dh
    LOCK REPNZ adc10   0C0h;10op
    REP adc10   0C8h
    adc10   0C1h
    adc10   0F1h
    adc10   0F5h
    adc10   0D5h
    adc     [ebp+12345768h],ch
    adc     ds:[5643h],ah
    adc     gs:[bx+si],ah
    adc     fs:[bx+si],ah
    adc     fs:[bx+si+11h],ah
    adc     fs:[bx+si+9876h],ah
    adc     fs:[1111h],ah
    adc     fs:[bp],ah
    adc     fs:[bx+31h],ah
    adc     es:[bp+98h],al
    adc     ds:[eax],al
    adc     ss:[ebp],al
    adc     gs:[12345768h],al
    adc     fs:[eax+12345768h],al
    adc     fs:[eax+ebx*8+12345768h],al
    adc     fs:[eax+ebx+12345768h],al
    adc     fs:[eax+ebx+12h],al
    adc     fs:[edx+12h],al
    adc     gs:[eax+ebx*2+44h],al
    adc     ss:[eax+ebx],al
    
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
    adc     gs:[5641h],ax
    adc     fs:[1234h],di
    adc     ds:[bx+si],ax
    adc     es:[bx+si],ax
    adc     ds:[bx+si+11h],ax
    adc     ss:[di+11h],di
    adc     ds:[bx+si+1111h],ax
    adc     fs:[bp],ax
    adc     [bp],ax
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    adc     cs:[eax],eax
    adc     fs:[eax],ax
    adc     es:[eax],ax
    adc     ss:[eax+11h],ax
    adc     ss:[eax+11h],eax
    adc     fs:[eax+5684h],ax
    adc     es:[eax+1111h],eax
    adc     fs:[ebx+esi],eax
    adc     fs:[ebx+esi],ax
    adc     ds:[ebx+esi+11h],eax
    adc     gs:[ebx+esi+1111h],eax
    adc     ss:[ebx+esi+0A1111111h],eax
    
    adc     al,0A0h
    adc     al,11h;14op
    adc     al,00h
    adc     al,37h
    
    adc     ax,5896h;15op
    adc     eax,11111111h
    
    adc     ah,cl;12 op
    adc     al,dh
    adc     dl,ch
    adc     ch,ds:[bx+si+1111h]
    adc     dh,fs:[ebx+257603h]
    adc     ch,ds:[bx+si]
    adc     ch,ds:[bx+si+11h]
    adc     bh,ds:[ebx+esi+11h]
    
    adc     ah,gs:[5641h]
    adc     al,fs:[bp]
    adc     dl,[bp]
    adc     ch,cs:[eax]
    adc     dh,fs:[eax+5684h]
    adc     ch,fs:[ebx+esi]
    adc     ch,gs:[ebx+esi+1111h]
    adc     bh,ss:[ebx+esi+0A1111111h]
    
    adc13   macro op
    db      13h,op
    endm
    adce13  macro op ;macro 66h + adc13 = 66h+13h+oper
    db      66h
    adc13   op
    endm
    adc     ax,ax;13op
    adc     cx,dx
    adc     cx,ax
    adc     ax,cx
    adc     ax,es:[bx+si]
    adc     ax,es:[bx+si+11h]
    adc     ax,es:[bx+si+1111h]
    adc     ax,es:[ebx+esi]
    adce13  0C0h
    adc     eax,es:[bx+si]
    adc     eax,es:[ebx+esi]
    adc     ecx,fs:[ebx+esi+11h]
    adc     edx,gs:[ebx+esi+1111h]
    adc     ebx,cs:[ebx+esi+11111111h]
    
    
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
    adc     byte ptr es:[ebx+esi],11h
    adc     byte ptr fs:[eax+5684h],11h
    adc     byte ptr ss:[ebx+esi+0A1111111h],11h
    adc     byte ptr fs:[1234h],11h
    adc     byte ptr fs:[eax+ebx*8+12345768h],11h
    
    
    
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
    adc     ax,11h
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
    
    
    bsf     ax,ax;opcBC
    bsf     cx,dx
    bsf     cx,ax
    bsf     ax,cx
    bsf     ax,es:[bx+si]
    bsf     ax,es:[bx+si+11h]
    bsf     ax,es:[bx+si+1111h]
    bsf     ax,es:[ebx+esi]
    bsf     eax,eax
    bsf     eax,es:[bx+si]
    bsf     eax,es:[ebx+esi]
    bsf     ecx,fs:[ebx+esi+11h]
    bsf     edx,gs:[ebx+esi+1111h]
    bsf     ebx,cs:[ebx+esi+11111111h]
    bsf     ax,[ebp+12345768h]
    bsf     cx,ds:[5643h]
    bsf     dx,gs:[bx+si]
    bsf     bx,fs:[bx+si]
    bsf     sp,fs:[bx+si+11h]
    bsf     bp,fs:[bx+si+9876h]
    bsf     si,fs:[1111h]
    bsf     di,fs:[bp]
    bsf     ax,fs:[bx+31h]
    bsf     cx,es:[bp+98h]
    bsf     dx,ds:[eax]
    bsf     bx,ss:[ebp]
    bsf     sp,gs:[12345768h]
    bsf     bp,fs:[eax+12345768h]
    bsf     si,fs:[eax+ebx*8+12345768h]
    bsf     di,fs:[eax+ebx+12345768h]
    bsf     ax,fs:[eax+ebx+12h]
    bsf     cx,fs:[edx+12h]
    bsf     dx,gs:[eax+ebx*2+44h]
    bsf     bx,ss:[eax+ebx]
    
    bsf     eax,[ebp+12345768h]
    bsf     ecx,ds:[5643h]
    bsf     edx,gs:[bx+si]
    bsf     ebx,fs:[bx+si]
    bsf     esp,fs:[bx+si+11h]
    bsf     ebp,fs:[bx+si+9876h]
    bsf     esi,fs:[1111h]
    bsf     edi,fs:[bp]
    bsf     eax,fs:[bx+31h]
    bsf     ecx,es:[bp+98h]
    bsf     edx,ds:[eax]
    bsf     ebx,ss:[ebp]
    bsf     esp,gs:[12345768h]
    bsf     ebp,fs:[eax+12345768h]
    bsf     esi,fs:[eax+ebx*8+12345768h]
    bsf     edi,fs:[eax+ebx+12345768h]
    bsf     eax,fs:[eax+ebx+12h]
    bsf     ecx,fs:[edx+12h]
    bsf     edx,gs:[eax+ebx*2+44h]
    bsf     ebx,ss:[eax+ebx]
    
    movs byte ptr es:[di],fs:[si]
    movs byte ptr es:[edi],gs:[esi]
    movs word ptr es:[di],fs:[si]
    movs word ptr es:[edi],gs:[esi]
    movs byte ptr es:[di],ds:[si]
    movs byte ptr es:[edi],ds:[esi]
    movs word ptr es:[di],ds:[si]
    movs word ptr es:[edi],ds:[esi]
    movs dword ptr es:[di],fs:[si]
    movs dword ptr es:[edi],gs:[esi]
    movs dword ptr es:[di],ds:[si]
    movs dword ptr es:[edi],ds:[esi]
    end     Start
    
    
    
    
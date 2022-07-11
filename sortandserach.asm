assume cs:code,ds:data
data segment
g1 db 0dh,0ah,"Enter the count:$"
g2 db 0dh,0ah,"Enter the array:$"
g3 db 0dh,0ah,"Sorted array is given below...$"
g4 db 0dh,0ah,"Enter the number to be searched:$"
msg1 db 0dh,0ah,"Found...$"
msg2 db 0dh,0ah,"Not Found...$"
nl db 0dh,0ah,"$"
ar db 10 dup(0)
data ends

disps macro msg
lea dx,msg
mov ah,09h
int 21h
endm

readc macro 
mov ah,01h
int 21h
endm

dispc macro ch
mov dl,ch
mov ah,02h
int 21h
endm

code segment
start:

mov cx,data
mov ds,cx
disps g1
readc
sub al,30h
mov cl,al
mov ch,al
mov bh,al
lea si,ar
disps g2

loop1:
disps nl
readc
mov [si],al
inc si
dec cl
jnz loop1
dec ch
jz disp


lp1:
lea si,ar
mov cl,ch



lp2:
mov bl,[si+1]
cmp bl,[si]
jnc nswap
xchg bl,[si]
mov [si+1],bl

nswap:
inc si
dec cl
jnz lp2
dec ch
jnz lp1

disp:
lea di,ar
mov cl,bh
mov ch,bh
disps g3

loop2:
disps nl
dispc[di]
inc di
dec bh
jnz loop2


above:
mov bh,[si]
sub bh,30h
mov [si],bh
inc si
dec ch
jnz above

disps g4
readc
sub al,30h
lea si,ar
mov dl,cl


up:
mov bl,[si]
cmp al,bl
jz fo 
inc si
dec dl
jnz up
disps msg2
jmp endl

fo:
disps msg1

endl:
mov ah,4ch
int 21h
code ends
end start

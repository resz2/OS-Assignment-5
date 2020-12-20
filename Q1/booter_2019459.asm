; Aryan GD Singh
; 2019459

bits 16
org 0x7c00

boot:
	mov ax, 0x2401
	int 0x15 ; enabling A20 bit
	mov ax, 0x3
	int 0x10 ; set vga text mode 3
	cli
	lgdt [gdt_pointer] ; loading gdt
	mov eax, cr0
	or eax, 0x1 ; setting 1st bit of cr0
	mov cr0, eax
	jmp CODE_SEG: booter
gdt_start:
	dq 0x0
gdt_code:
	dw 0xFFFF
	dw 0x0
	db 0x0
	db 10011010b
	db 11001111b
	db 0x0
gdt_data:
	dw 0xFFFF
	dw 0x0
	db 0x0
	db 10010010b
	db 11001111b
	db 0x0
gdt_end:
gdt_pointer:
	dw gdt_end - gdt_start ; size of gdt
	dd gdt_start ; pointer to structure

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

bits 32
booter:
	mov ax, DATA_SEG
	mov esi, hello
	mov ebx, 0xb8000
.loop1:
	lodsb
	or al, al
	jz .setup
	or eax, 0x0f00
	mov word [ebx], ax
	add ebx, 2
	jmp .loop1
.setup:
	mov edx, cr0
	mov ecx, 32
.loop2:
	mov eax, 0xf30
	shl edx, 1
	adc eax, 0
	mov [ebx], ax
	add ebx, 2
	dec ecx
	jnz .loop2

halt:
	cli
	hlt
hello: db "Hello world! ",0

times 510 - ($-$$) db 0
dw 0xaa55

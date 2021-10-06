; -------------------------------- ;
; Nikolay Anikin, PS-11, 9.11.2021 ;
; -------------------------------- ;

%include "./include/asm_io.inc"

SEGMENT .data
	sEnterNumber DB ") Enter a number (777 - stop): ", 0
	sPlusSign DB " + ", 0
	sEqualSign DB " = ", 0

SEGMENT .bss
	iCount RESD 1
	iResult RESD 1

SEGMENT .text
	GLOBAL _asm_main

_asm_main:
	ENTER 0, 0
	PUSHA

	MOV EBX, [iCount]
	MOV EBX, 0
	MOV [iCount], EBX

	MOV EBX, [iResult]
	MOV EBX, 0
	MOV [iResult], EBX

	JMP _cycle__input_nums

_cycle__input_nums:
	MOV EAX, [iCount]
	INC EAX
	CALL print_int

	MOV EAX, sEnterNumber
	CALL print_string

	CALL read_int
	CMP EAX, 777
	JE _cycle__sum_nums

	push EAX

	MOV EBX, [iCount]
	INC EBX
	MOV [iCount], EBX

	JMP _cycle__input_nums

_cycle__sum_nums:
	MOV EBX, [iCount]
	DEC EBX
	MOV [iCount], EBX

	MOV EAX, [iResult]
	
	pop ECX
	ADD EAX, ECX
	MOV [iResult], EAX

	MOV EAX, ECX
	CALL print_int

	MOV EBX, [iCount]
	CMP EBX, 0
	JE _result

	MOV EAX, sPlusSign
	CALL print_string

	JMP _cycle__sum_nums

_result:
	MOV EAX, sEqualSign
	CALL print_string

	MOV EAX, [iResult]
	CALL print_int

	JMP _exit

_exit:
	POPA
	MOV EAX, 0
	LEAVE 
	RET
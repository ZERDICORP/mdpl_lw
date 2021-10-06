; -------------------------------- ;
; Nikolay Anikin, PS-11, 9.11.2021 ;
; -------------------------------- ;

%include "./include/asm_io.inc"

SEGMENT .data
	sLeftOperand DB "Left operand: ", 0
	sRightOperand DB "Right operand: ", 0
	sPlusSign DB " + ", 0
	sEqualSign DB " = ", 0

SEGMENT .bss
	iLeftOperand RESD 1
	iRightOperand RESD 1
	iSumResult RESD 1

SEGMENT .text
	GLOBAL _asm_main

_asm_main:
	ENTER 0, 0
	PUSHA

	MOV EAX, sLeftOperand
	CALL print_string

	CALL read_int
	MOV  [iLeftOperand], EAX

	MOV EAX, sRightOperand
	CALL print_string

	CALL read_int
	MOV  [iRightOperand], EAX

	MOV EBX, [iLeftOperand]
	MOV EAX, [iRightOperand]
	ADD EBX, EAX
	MOV [iSumResult], EBX

	MOV EAX, [iLeftOperand]
	CALL print_int

	MOV EAX, sPlusSign
	CALL print_string

	MOV EAX, [iRightOperand]
	CALL print_int

	MOV EAX, sEqualSign
	CALL print_string

	MOV EAX, [iSumResult]
	CALL print_int

	POPA
	MOV EAX, 0
	LEAVE
	RET
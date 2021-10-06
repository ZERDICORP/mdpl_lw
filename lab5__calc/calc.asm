; -------------------------------- ;
; Nikolay Anikin, PS-11, 9.11.2021 ;
; -------------------------------- ;

%include "./include/asm_io.inc"

SEGMENT .data
	sUndefinedOperationType DB "Undefined operation type", 0
	sOperationType DB "Operation type (1 - sum, 2 - mul): ", 0
	sLeftOperand DB "Left operand: ", 0
	sRightOperand DB "Right operand: ", 0
	sPlusSign DB " + ", 0
	sMultiplicationSign DB " * ", 0
	sEqualSign DB " = ", 0

SEGMENT .bss
	iOperationType RESD 1
	iLeftOperand RESD 1
	iRightOperand RESD 1
	iResult RESD 1

SEGMENT .text
	GLOBAL _asm_main

_asm_main:
	ENTER 0, 0
	PUSHA

	MOV EAX, sOperationType
	CALL print_string

	CALL read_int
	MOV [iResult], EAX

	MOV EAX, sLeftOperand
	CALL print_string

	CALL read_int
	MOV [iLeftOperand], EAX

	MOV EAX, sRightOperand
	CALL print_string

	CALL read_int
	MOV [iRightOperand], EAX

	MOV EAX, [iResult]

	CMP EAX, 1
	JE _sum

	CMP EAX, 2
	JE _multiplication

	MOV EAX, sUndefinedOperationType
	CALL print_string

	JMP _exit

_sum:
	MOV EBX, [iLeftOperand]
	MOV EAX, [iRightOperand]
	ADD EBX, EAX
	MOV [iResult], EBX

	MOV EAX, [iLeftOperand]
	CALL print_int

	MOV EAX, sPlusSign
	CALL print_string

	MOV EAX, [iRightOperand]
	CALL print_int

	MOV EAX, sEqualSign
	CALL print_string

	MOV EAX, [iResult]
	CALL print_int

	JMP _exit

_multiplication:
	MOV EBX, [iLeftOperand]
	MOV EAX, [iRightOperand]
	MUL EBX
	MOV [iResult], EAX

	MOV EAX, [iLeftOperand]
	CALL print_int

	MOV EAX, sMultiplicationSign
	CALL print_string

	MOV EAX, [iRightOperand]
	CALL print_int

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
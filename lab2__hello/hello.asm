; -------------------------------- ;
; Nikolay Anikin, PS-11, 9.11.2021 ;
; -------------------------------- ;

%include "./include/asm_io.inc"

SEGMENT .data
	sHelloWorld DB "Hello, world!", 0
	sStudentInfo DB "Nikolay Anikin, PS-11", 0

SEGMENT .text
	GLOBAL _asm_main

_asm_main:
	ENTER 0, 0
	PUSHA

	MOV EAX, sHelloWorld
	CALL print_string
	CALL print_nl

	MOV EAX, sStudentInfo
	CALL print_string
	CALL print_nl

	POPA
	MOV EAX, 0
	LEAVE 
	RET
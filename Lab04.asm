/**************************************************************************
 *     File: Lab04.asm
 * Lab Name: What's Your Calling?
 *   Author: Ben Roeder
 *  Created: 9/17/2024
 *
 * This program manipulates the stack to process a factorial number.
 *************************************************************************/ 

.def n = R16 
.def result = R17


.org 0x0000 ; next instruction will be written to address 0x0000
            ; (the location of the reset vector)
rjmp main	; set reset vector to point to the main code entry point

main:       ; jump here on reset

		; initialize the stack (RAMEND = 0x10FF by default for the ATmega128A)
		ldi R16, HIGH(RAMEND)
		out SPH, R16
		ldi R16, low(RAMEND)
		out SPL, R16

		LDI  n, 4	; load a value into n
		PUSH n	; push it on the stack
		CALL factN	; calculate the factorial of n
		POP  result	; pop result off stack
here:
		RJMP here	; loop forever

factN:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Comments regarding the factN subroutine go here
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; recursive factorial code begins here


;	 read from stop of stack. do not touch any code below.
	IN YL, SPL
	IN YH, SPH
	LDD R23, Y+3
	
	
	CPI R23, 1
	BREQ escape

	;maybe factorial code. only touch code below




	DEC R23
	PUSH R23
	CALL factN
	POP R2
	IN YL, SPL
	IN YH, SPH
	LDD R3, Y+3
    MUL R2, R3
	STD Y+3, R0


	; dont touch

	IN YL, SPL
	IN YH, SPH
;	STD Y+3, R23



escape: 
	; return from the factN subroutine
	ret 

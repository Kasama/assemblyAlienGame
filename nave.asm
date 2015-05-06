jmp main
NavePos: var #1
Nave: var #1
Tiro: var #1
TiroPos: var #1
HasTiro: var #1
AlienPos: var #40
AlienCount: var #1
static AlienCount + #0, #40
AlienChar: var #1
static AlienChar + #0, #'+'
AlienOrientation: var #1
static AlienOrientation + #0, #1

static AlienPos + #0, #223
static AlienPos + #1, #225
static AlienPos + #2, #227
static AlienPos + #3, #229 
static AlienPos + #4, #303
static AlienPos + #5, #305
static AlienPos + #6, #307
static AlienPos + #7, #309
static AlienPos + #8, #383
static AlienPos + #9, #385
static AlienPos + #10, #387
static AlienPos + #11, #389
static AlienPos + #12, #463
static AlienPos + #13, #465
static AlienPos + #14, #467
static AlienPos + #15, #469
static AlienPos + #16, #543
static AlienPos + #17, #545
static AlienPos + #18, #547
static AlienPos + #19, #549
static AlienPos + #20, #623
static AlienPos + #21, #625
static AlienPos + #22, #627
static AlienPos + #23, #629
static AlienPos + #24, #703
static AlienPos + #25, #705
static AlienPos + #26, #707
static AlienPos + #27, #709
static AlienPos + #28, #783
static AlienPos + #29, #785
static AlienPos + #30, #787
static AlienPos + #31, #789
static AlienPos + #32, #863
static AlienPos + #33, #865
static AlienPos + #34, #867
static AlienPos + #35, #869
static AlienPos + #36, #943
static AlienPos + #37, #945
static AlienPos + #38, #947
static AlienPos + #39, #949
                          
static HasTiro + #0, #0
static Tiro + #0,#'-'
static TiroPos + #0, #0
static NavePos + #0, #0
static Nave + #0, #'>'

; Start Screen-------------------------------------------------{
startScreen    : string "                                        "
startScreenl1  : string "                                        "
startScreenl2  : string "                                        "
startScreenl3  : string "                                        "
startScreenl4  : string "                                        "
startScreenl5  : string "                       * * * *          "
startScreenl6  : string "                                        "
startScreenl7  : string "                       * * * *          "
startScreenl8  : string "                                        "
startScreenl9  : string "                       * * * *          "
startScreenl10 : string "                                        "
startScreenl11 : string "                       * * * *          "
startScreenl12 : string "                                        "
startScreenl13 : string "                       * * * *          "
startScreenl14 : string "                                        " ; pos 563 on the screen
startScreenl15 : string "                       * * * *          "
startScreenl16 : string "                                        "
startScreenl17 : string "                       * * * *          "
startScreenl18 : string "                                        "
startScreenl19 : string "                       * * * *          "
startScreenl20 : string "                                        "
startScreenl21 : string "                       * * * *          "
startScreenl22 : string "                                        "
startScreenl23 : string "                       * * * *          "
startScreenl24 : string "                                        "
startScreenl25 : string "                                        "
startScreenl26 : string "                                        "
startScreenl27 : string "                                        " ; pos 1084 on the screen
startScreenl28 : string "                                        "
startScreenl29 : string "                                        "
;--------------------------------------------------------------}
; Start Screen-------------------------------------------------{
gameScreen    : string "                                        "
gameScreenl1  : string "                                        "
gameScreenl2  : string "                                        "
gameScreenl3  : string "                                        "
gameScreenl4  : string "                                        "
gameScreenl5  : string "                                        "
gameScreenl6  : string "                                        "
gameScreenl7  : string "                                        "
gameScreenl8  : string "                                        "
gameScreenl9  : string "                                        "
gameScreenl10 : string "                                        "
gameScreenl11 : string "                                        "
gameScreenl12 : string "                                        "
gameScreenl13 : string "                                        "
gameScreenl14 : string "                                        " ; pos 563 on the screen
gameScreenl15 : string "                                        "
gameScreenl16 : string "                                        "
gameScreenl17 : string "                                        "
gameScreenl18 : string "                                        "
gameScreenl19 : string "                                        "
gameScreenl20 : string "                                        "
gameScreenl21 : string "                                        "
gameScreenl22 : string "                                        "
gameScreenl23 : string "                                        "
gameScreenl24 : string "                                        "
gameScreenl25 : string "                                        "
gameScreenl26 : string "                                        "
gameScreenl27 : string "                                        " ; pos 1084 on the screen
gameScreenl28 : string "                                        "
gameScreenl29 : string "                                        "
;--------------------------------------------------------------}

;MAIN----------------------------------
main:
	loadn r0, #startScreen
	loadn r2, #1199
	load r1, NavePos
	;sub r2, r2, r1
	call printScreen

	loadn r0, #0
	loadn r1, #50
	Loop: 
		mod r3, r0, r1
		jnz LoopMoveNaveTiro
			call moveAlien
		LoopMoveNaveTiro:
			call moveNave
			call moveTiro
			call Delay
			inc r0
			cmp r0, r1
		jne Loop
		loadn r0, #0
	jmp Loop

halt

gameOverPlayerLost: ; game is over, you LOST!; void () {

	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0

	halt

rts
;}
;--------------------------------------------------------------
gameOverWinner: ; game is over, you WIN!; void () {


	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0

	halt
rts
;}
;--------------------------------------------------------------
;--------------------------------------

moveAlien: ; movimenta todos os aliens na tela; void () {

	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	
	loadn r0, #40 ; load #10 to register r0
	loadn r1, #1200
	moveAlien_loop:

		dec r0
		loadn r2, #AlienPos
		add r2, r2, r0
		loadi r2, r2 ; r2 = *(AlienPos + r0)
		cmp r1, r2
		jeq moveAlien_loopVerificaFim

		loadn r4, #40
		mod r3, r2, r4
		jz gameOverPlayerLost ; TODO GAME OVER
		
		; apagar o alien
		loadn r4, #40
		div r5, r2, r4
		loadn r3, #gameScreen
		add r3, r3, r2
		add r3, r3, r5
		loadi r3, r3
		outchar r3, r2

		; move o alien
		loadn r4, #0
		load r3, AlienOrientation
		cmp r3,r4 ; compare r3 with r4 and jne to moveAlien_Else
		jne moveAlien_Else  ; simple if statement
			dec r2 ; orientation = 0; anda o alien pra esquerda
			jmp moveAlien_EndIf
		moveAlien_Else:
			dec r3
			loadn r5, #40
			jnz moveAlienElse_Else  ; simple if statement
				sub r2, r2, r5 ; orintation = 1; subir o alien
				jmp moveAlien_EndIf
			moveAlienElse_Else:
				dec r3
				jnz moveAlienElseElse_Else
					dec r2 ;orientation = 2; alien para esquerda
					jmp moveAlien_EndIf
				moveAlienElseElse_Else:
					add r2, r2, r5 ; orientation = 3; descer o alien
					jmp moveAlien_EndIf
		moveAlien_EndIf:
		; imprime alien
		load r3, AlienChar
		outchar r3, r2
		loadn r5, #AlienPos
		add r5, r5, r0
		storei r5, r2

		cmp r4, r0
	jne moveAlien_loop

	moveAlien_loopFim:

	; atualiza a orientação dos aliens
	load r0, AlienOrientation
	cmp r0,r4 ; compare r0 with r4 and jne to moveAlienOrientation_Else
	jne moveAlienOrientation_Else  ; simple if statement
		loadn r0, #3 ; orientation = 0; muda pra 3
		jmp moveAlienOrientation_EndIf
	moveAlienOrientation_Else:
		dec r0 ; orientation = orientation-1
	moveAlienOrientation_EndIf:
	store AlienOrientation, r0
	
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0

rts

moveAlien_loopVerificaFim:
	push r1
	loadn r1, #0
	cmp r1, r0
	pop r1
	jeq moveAlien_loopFim
	jmp moveAlien_loop

;}
;--------------------------------------------------------------

;DELAY---------------------------------
Delay:
						;Utiliza Push e Pop para nao afetar os Ristradores do programa principal
	push r0
	push r1
	
	loadn r1, #100  ; a
   delay_volta2:				; contador de tempo quebrado em duas partes (dois loops de decremento)
	loadn r0, #3000	; b
   delay_volta: 
	dec r0					; (4*a + 6)b = 1000000  == 1 seg  em um clock de 1MHz
	jnz delay_volta	
	dec r1
	jnz delay_volta2
	
	pop r1
	pop r0
	
	rts							;return

;-------------------------------------

printNave:

	push r0 
	push r1
	push r2

	load  r0, Nave
	load  r1, NavePos
	loadn r2, #1024

	add r0, r0, r2
	outchar r0, r1

	pop r2
	pop r1
	pop r0

rts
;------------------------------------
moveTiro: ; Move o tiro; void () {

	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	
	load r1, HasTiro ; se tem tiro no ar
	loadn r0, #0
	cmp r1, r0
	jeq moveTiroSai ; se não tiver tiro no ar, sai
	loadn r4, #40
	load r2, TiroPos 
	div r0, r2, r4
	loadn r6, #gameScreen
	add r6, r6, r2
	add r6, r6, r0
	loadi r7, r6 ; carrega o caracter da tela da posição do tiro
	outchar r7, r2 ; imprime
	loadn r5, #39
	loadn r0, #1
	mod r3, r2, r4 ; checa se o tiro saiu da tela
	cmp r3, r5
	jeq moveTiroSemTiro ; o tiro sai da tela
	inc r2 ; move o tiro pra frente
	;verifica se o tiro está em cima de um alien
	loadn r6, #40 ; load #40 to register r6
	moveTiro_Loop:
		dec r6
		loadn r7, #AlienPos
		add r7, r7, r6
		loadi r7, r7
		cmp r2, r7
		jne moveTiro_Loop_VerificaFim
		loadn r1, #gameScreen
		add r1, r1, r2
		loadi r1, r1
		outchar r1, r2
		loadn r1, #0
		store HasTiro, r1
		loadn r1, #AlienPos
		add r1, r1, r6
		loadn r7, #1200
		storei r1, r7
		load r1, AlienCount
		dec r1
		jz gameOverWinner
		store AlienCount, r1
		jmp moveTiroSai
	jne moveTiro_Loop
	moveTiro_LoopFim:

	store TiroPos, r2 ; salva nova posição do tiro
	load r7, Tiro
	outchar r7, r2 ; imprime o tiro
	jmp moveTiroSai

moveTiro_Loop_VerificaFim:
	push r1
	loadn r1, #0
	cmp r6, r1
	pop r1
	jeq moveTiro_LoopFim
	jmp moveTiro_Loop

moveTiroSemTiro:
	dec r0
	store HasTiro, r0
	outchar r7, r2
	jmp moveTiroSai

moveTiroSai:
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0

rts
;}
;--------------------------------------------------------------

atualizaPos:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5

	inchar r2
	load r1, NavePos
	
	loadn r0, #'w'     ;tecla w
	cmp r0, r2         ;compara tecla com w
	jeq atualizaPosW

	; loadn r0, #'a'     ;tecla a
	; cmp r0, r2         ;compara tecla com a
	; jeq atualizaPosA

	loadn r0, #'s'     ;tecla s
	cmp r0, r2         ;compara tecla com s
	jeq atualizaPosS
	
	; loadn r0, #'d'     ;tecla d
	; cmp r0, r2         ;compara tecla com d
	; jeq atualizaPosD

	loadn r0, #' '     ;tecla ' '
	cmp r0, r2         ;compara tecla com ' '
	jeq atira

	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
rts

atira:
	
	load r3, NavePos
	loadn r0, #39
	loadn r5, #40
	mod r6, r3, r5
	cmp r6, r0
	jeq atualizaPosFim
	load r4, HasTiro
	dec r4
	jz atualizaPosFim
	loadn r4, #1
	store HasTiro, r4
	inc r3
	store TiroPos, r3
	jmp atualizaPosFim


atualizaPosW: 

	loadn r3, #40
	cmp r1, r3
	jle atualizaPosFim

	sub r1, r1, r3
	jmp atualizaPosFim

; atualizaPosA: 
; 
; 	loadn r3, #40
; 	loadn r4, #0
; 	mod r5, r1, r3 
; 	cmp r5, r4
; 	jeq atualizaPosFim
; 
; 	dec r1
; 	jmp atualizaPosFim

atualizaPosS: 

	loadn r3, #40
	loadn r4, #1160
	cmp r1, r4
	jeg atualizaPosFim

	add r1, r1, r3
	jmp atualizaPosFim

; atualizaPosD: 
; 
; 	loadn r3, #40
; 	loadn r4, #39
; 	mod r5, r1, r3 
; 	cmp r5, r4
; 	jeq atualizaPosFim
; 
; 	inc r1
; 	jmp atualizaPosFim

atualizaPosFim:
	store NavePos, r1

	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0

rts

moveNave:

	push r0 
	push r1
	push r2

	load  r1, NavePos
	loadn r2, #' '
	outchar r2, r1 ;limpando nave anterior

	call atualizaPos
	load  r1, NavePos
	call printNave

	pop r2
	pop r1
	pop r0

rts

;==============================================================
printScreen: ; Print any screen; void (r0 = Message Address) ;{

	push r0
	push r1
	push r2
	push r3
	push r4

	mov r1, r0    ; place the message address into r1
	loadn r0, #0  ; line counter
	loadn r4, #41 ; next address
	loadn r3, #30 ; for counter (30 lines)
	loadn r2, #0  ; white color
	printScreen_loop:
		call printStr
		add r0, r0, r4 ; r0 + 41 - 1 = next line
		dec r0
		add r1, r1, r4 ; r1 + 41 = next Address
		dec r3         ; decrement line number
	jnz printScreen_loop ; if zero, gtfo
	
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0

	rts
;}
;--------------------------------------------------------------

printStr: ; Print a string until \0; void (r0 = Screen Pos, r1 = message Address, r2 = color) ;{
				
	push r0	; Posicao da tela que o primeiro caractere da mensagem sera' impresso
	push r1	; endereco onde comeca a mensagem
	push r2	; cor da mensagem
	push r3	; Criterio de parada
	push r4	; Recebe o codigo do caractere da Mensagem
	
	loadn r3, #'\0'	; Criterio de parada

	printStrLoop:	
		loadi r4, r1		; aponta para a memoria no endereco r1 e busca seu conteudo em r4
		cmp r4, r3			; compara o codigo do caractere buscado com o criterio de parada
		jeq printStrExit	; goto Final da rotina
		add r4, r2, r4		; soma a cor (r2) no codigo do caractere em r4
		outchar r4, r0		; imprime o caractere cujo codigo está em r4 na posicao r0 da tela
		inc r0				; incrementa a posicao que o proximo caractere sera' escrito na tela
		inc r1				; incrementa o ponteiro para a mensagem na memoria
	jmp printStrLoop		; goto Loop
	
	printStrExit:	
	;---- Desempilhamento: resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r4	
	pop r3
	pop r2
	pop r1
	pop r0
	rts		; retorno da subrotina
;}
;--------------------------------------------------------------

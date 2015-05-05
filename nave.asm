jmp main
NavePos: var #1
Nave: var #1
Tiro: var #1
TiroPos: var #1
HasTiro: var #1
Random: var #20
AlienPos: var #8

static AlienPos + #0, #1
static AlienPos + #0, #41
static AlienPos + #0, #40
static AlienPos + #0, #39
static AlienPos + #0, #1
static AlienPos + #0, #41
static AlienPos + #0, #40
static AlienPos + #0, #39

static Random + #0, #3
static Random + #1, #4
static Random + #2, #2
static Random + #3, #7
static Random + #4, #1
static Random + #5, #2
static Random + #6, #3
static Random + #7, #5
static Random + #8, #6
static Random + #9, #1
static Random + #10, #3
static Random + #11, #7
static Random + #12, #1
static Random + #13, #0
static Random + #14, #5
static Random + #15, #0
static Random + #16, #4
static Random + #17, #2
static Random + #18, #6
static Random + #19, #1

static HasTiro + #0, #0
static Tiro + #0,#'-'
static TiroPos + #0, #0
static NavePos + #0, #0
static Nave + #0, #'>'

; Start Screen-------------------------------------------------{
startScreen    : string "****************************************"
startScreenl1  : string "****************************************"
startScreenl2  : string "****************************************"
startScreenl3  : string "****************************************"
startScreenl4  : string "****************************************"
startScreenl5  : string "****************************************"
startScreenl6  : string "****************************************"
startScreenl7  : string "****************************************"
startScreenl8  : string "****************************************"
startScreenl9  : string "****************************************"
startScreenl10 : string "****************************************"
startScreenl11 : string "****************************************"
startScreenl12 : string "****************************************"
startScreenl13 : string "****************************************"
startScreenl14 : string "****************************************" ; pos 563 on the screen
startScreenl15 : string "****************************************"
startScreenl16 : string "****************************************"
startScreenl17 : string "****************************************"
startScreenl18 : string "****************************************"
startScreenl19 : string "****************************************"
startScreenl20 : string "****************************************"
startScreenl21 : string "****************************************"
startScreenl22 : string "****************************************"
startScreenl23 : string "****************************************"
startScreenl24 : string "****************************************"
startScreenl25 : string "****************************************"
startScreenl26 : string "****************************************"
startScreenl27 : string "****************************************" ; pos 1084 on the screen
startScreenl28 : string "****************************************"
startScreenl29 : string "****************************************"
;--------------------------------------------------------------}

;MAIN----------------------------------
main:
	loadn r0, #startScreen
	loadn r2, #1199
	load r1, NavePos
	;sub r2, r2, r1
	call printScreen
	Loop: 
		call moveNave
		call moveTiro
		call Delay
		dec r2
		jnz Loop

halt
;--------------------------------------


;DELAY---------------------------------
Delay:
						;Utiliza Push e Pop para nao afetar os Ristradores do programa principal
	Push R0
	Push R1
	
	Loadn R1, #100  ; a
   Delay_volta2:				; contador de tempo quebrado em duas partes (dois loops de decremento)
	Loadn R0, #3000	; b
   Delay_volta: 
	Dec R0					; (4*a + 6)b = 1000000  == 1 seg  em um clock de 1MHz
	JNZ Delay_volta	
	Dec R1
	JNZ Delay_volta2
	
	Pop R1
	Pop R0
	
	RTS							;return

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
	push r7
	
	load r1, HasTiro;
	loadn r0, #0
	cmp r1, r0
	jeq moveTiroSai
	loadn r7, #' '
	inc r0
	load r2, TiroPos;
	outchar r7, r2
	loadn r4, #40
	loadn r5, #39
	mod r3, r2, r4
	cmp r3, r5
	jeq moveTiroSemTiro
	inc r2
	store TiroPos, r2
	load r7, Tiro
	outchar r7, r2
	jmp moveTiroSai

moveTiroSemTiro:
	dec r0
	store HasTiro, r0
	outchar r7, r2
	jmp moveTiroSai

moveTiroSai:
	pop r7
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

	loadn r0, #'a'     ;tecla a
	cmp r0, r2         ;compara tecla com a
	jeq atualizaPosA

	loadn r0, #'s'     ;tecla s
	cmp r0, r2         ;compara tecla com s
	jeq atualizaPosS
	
	loadn r0, #'d'     ;tecla d
	cmp r0, r2         ;compara tecla com d
	jeq atualizaPosD

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

atualizaPosA: 

	loadn r3, #40
	loadn r4, #0
	mod r5, r1, r3 
	cmp r5, r4
	jeq atualizaPosFim

	dec r1
	jmp atualizaPosFim

atualizaPosS: 

	loadn r3, #40
	loadn r4, #1160
	cmp r1, r4
	jeg atualizaPosFim

	add r1, r1, r3
	jmp atualizaPosFim

atualizaPosD: 

	loadn r3, #40
	loadn r4, #39
	mod r5, r1, r3 
	cmp r5, r4
	jeq atualizaPosFim

	inc r1
	jmp atualizaPosFim

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

##################################################################
#  Adventures of Lamar - Projeto final de ISC                    #
#  2020/2			  			         #
##################################################################
# Por favor, comente o codigo com clareza


.data

VIDAS_LAMAR:	.word 5		# quando a ultima nota foi tocada
POWER_LAMAR:	.word 0		# duracao da ultima nota

#=============================================SOUNDTRACK==============================================================================
#Jenova(tamanho:76)
JENOVA: 36,357,36,357,36,357,40,1071,36,357,36,357,36,357,41,1071,36,357,36,357,36,357,42,357,41,357,40,357,41,357,40,357,38,357,40,714,38,357,36,357,36,357,36,357,40,1071,36,357,36,357,36,357,41,1071,36,357,36,357,36,357,42,357,41,357,40,357,41,357,40,357,38,357,40,714,38,357,40,357,40,357,40,357,42,1071,40,357,40,357,40,357,45,1071,40,357,40,357,40,357,46,357,45,357,42,357,45,357,42,357,41,357,42,714,41,357,40,357,40,357,40,357,42,1071,40,357,40,357,40,357,45,1071,40,357,40,357,40,357,46,357,45,357,42,357,45,357,42,357,41,357,42,714,41,357

#Costa del sol(tamanho: 17)
FF17_COSTA_DEL_SOL:60,1282,67,513,65,256,67,2052,60,1282,71,513,68,256,67,2052,60,1282,67,513,68,256,69,2052,60,1282,72,513,71,256,69,2052,60,2052

#amongus(tamanho: 31) 
AMONGUS: 36,638,72,319,76,319,77,319,78,319,77,319,76,319,72,638,60,319,71,159,74,159,72,638,60,319,31,319,36,638,72,319,76,319,77,319,78,319,77,319,76,319,78,638,60,638,78,212,77,212,76,212,78,212,77,0,77,212,76,0,76,212

#Zelda(tamanho:97)
ZELDA: 60,652,55,978,60,326,60,163,62,163,64,163,65,163,67,1630,67,326,67,163,69,163,71,326,72,1630,72,326,72,163,71,163,69,326,71,489,69,163,67,1304,67,652,65,326,65,163,67,163,69,1304,67,326,65,326,64,326,64,163,65,163,67,1304,65,326,64,326,62,326,62,163,64,163,66,1304,70,652,67,326,55,163,55,163,55,326,55,163,55,163,55,326,55,163,55,163,55,326,55,326,60,652,55,978,60,326,60,163,62,163,64,163,65,163,67,1630,67,326,67,163,69,163,71,326,72,1956,76,652,74,652,73,1304,67,652,69,1956,72,652,73,652,67,1304,67,652,69,1956,72,652,73,652,67,1304,64,652,65,1956,69,652,67,652,64,1304,60,652,62,326,62,163,64,163,66,1304,70,652,67,326,55,163,55,163,55,326,55,163,55,163,55,326,55,163,55,163,55,326,55,326

#Kingdom Hearts(tamanho:68)
KH: 81,682,81,227,76,682,76,227,74,682,74,227,83,682,83,227,81,682,81,227,76,682,76,227,74,682,74,227,83,682,83,227,84,682,84,227,83,682,83,227,88,682,88,227,86,113,88,113,86,455,86,227,84,682,84,227,83,682,83,227,81,682,81,227,79,682,79,227,81,682,81,227,76,682,76,227,74,682,74,227,83,682,83,227,81,682,81,227,76,682,76,227,74,682,74,227,83,682,83,227,84,682,84,227,83,682,83,227,88,682,88,227,86,113,88,113,86,455,86,227,84,682,84,227,83,682,83,227,81,682,81,227,88,682,88,227
#=====================================================================================================================================

# macro para o menu funcional
#.include "menu.s"



.text
#macros
.include "macro.s"
.include "midi.s"
.include "MACROSv21.s"

MENU:
Frame(1) #sempre vai estar no frame 0

la t0,VIDAS_LAMAR	# endereço da VIDAS_LAMAR
li t1, 5		#determina como 5 a vida do lamar
sw t1,0(t0)		# salva a vida do lamar

j MAIN

#=================================VIDAS=============================
VIDA:

la t0,VIDAS_LAMAR	# endereço da VIDAS_LAMAR
lw t1,0(t0)		# t1 = vida atual lamar


li t0, 5
beq t1, t0, VIDA_5		#se lamar tiver 5 de vida, printa 5
li t0, 4
beq t1, t0, VIDA_4		#se lamar tiver 4 de vida, printa 4
li t0, 3
beq t1, t0, VIDA_3		#se lamar tiver 3 de vida, printa 3
li t0, 2
beq t1, t0, VIDA_2		#se lamar tiver 2 de vida, printa 2
li t0, 1
beq t1, t0, VIDA_1		#se lamar tiver 1 de vida, printa 1
beq t1, zero, VIDA_0		#se lamar tiver 0 de vida, printa 0


VIDA_5:
vida_lamar(5, IMPRIME_PERSONAGEM1)

VIDA_4:
vida_lamar(4, IMPRIME_PERSONAGEM1)

VIDA_3:
vida_lamar(3, IMPRIME_PERSONAGEM1)

VIDA_2:
vida_lamar(2, IMPRIME_PERSONAGEM1)

VIDA_1:
vida_lamar(1, IMPRIME_PERSONAGEM1)

VIDA_0:
vida_lamar(0, IMPRIME_PERSONAGEM1)


VIDA_DIMINUI:
jal s5, MUSICA_RESET	#reseta os conatdores da musica, ela toca desde o inicio
la t0,VIDAS_LAMAR	# endereço da VIDAS_LAMAR
lw t1,0(t0)		# t1 = vida atual lamar
li t0, 1
sub t1, t1, t0		#sempre que lamar morrer diminui -1 de vida
la t0,VIDAS_LAMAR	# endereço do VIDAS_LAMAR
sw t1,0(t0)		# salva a vida do lamar diminuida
blt t1, zero, MENU	#se lamar chegar a zero vida, volta para o menu

#-------------verificador de fase---------
#s2 determina a fase que lamar esta
li t0, 1
beq s2, t0, IMPRESSAO_MAPA1	#vai para a primeira fase
li t0, 2
#beq s2, t0, IMPRESSAO_MAPA2	#vai para a segunda fase

#=================================CORAÇAO/PODER=============================
CORACAO:
la t0,POWER_LAMAR	# endereço da POWER_LAMAR
lw t1,0(t0)

beq, t1, zero, POWER0
li t0, 1
beq, t1, t0, POWER1	
li t0, 2
beq t1, t0, POWER2

POWER0:poder_lamar(0, RETORNA_JR)
POWER1:poder_lamar(1, RETORNA_JR)
POWER2:poder_lamar(2, RETORNA_JR)


CORACAO_AUMENTA:
la t0,POWER_LAMAR	# endereço da POWER_LAMAR
lw t1,0(t0)		# t1 = power atual lamar

addi t1, t1, 1		#sempre que lamar pegar coraçao,aumenta em 1 seu power
la t0,POWER_LAMAR	# endereço do VIDAS_LAMAR
sw t1,0(t0)		# salva a vida do lamar diminuida
j  	CORACAO


RETORNA_JR:
	jr s5
#===============================MUSICAS=====================================
MUSICA1:
	play_musica(68, 0, KH)
	jr s5

MUSICA2:
	play_musica(97, 54, ZELDA)
	jr s5

	
MUSICA_RESET:
	reset()	#reseta a musica
	jr s5	
	
	
		
#=====================================================================================
###########################################
#                                         #
#             	 FASES                    #
#                                         #
###########################################

#=================================FASES=============================
#FASE1
MAIN:
IMPRIME_FASE1:	
	ImpressaoF(Transicao1, 0xFF100000, 0, TROCA_FRAMEI)	#tela de transiÃ§ao com informaÃ§oes da fase e senha
	TROCA_FRAMEI:
		Frame(1)
		Delay(5000)
		ImpressaoF(MAPA1, 0xFF000000, 0, IMPRESSAO_MAPA1) #impressao no frame 0 para nao mostrar o mapa ser imprimido
		
		IMPRESSAO_MAPA1:
		Frame(0)
		li s2, 1	#determina que lamar esta na primeira fase, para quando ele morrer dar respawn na fase certa	
		Impressao(MAPA1, 0xFF000000, 0xFF100000, 0, VIDA)
		

IMPRIME_PERSONAGEM1:
Impressaopequena(caixa, 0xFF008CA0, 0xFF108CA0, 0, 0x130, AEIOU2)
AEIOU2:
Impressaopequena(coracao, 0xFF0078E0, 0xFF1078E0, 0, 0x130, AEIOU)
AEIOU:
jal s5, CORACAO
Imprimepersonagem(0xFF008C20, 0xFF108C20, NEXT1)

NEXT1:
jal s5, MUSICA_RESET	#reseta os conatdores da musica, ela toca desde o inicio
j ANDARLAMAR

#FASE2

#======================================================================================================

	
###########################################
#                                         #
#             	ANDAR LAMAR               #
#                                         #
###########################################
	
#==============================O PASSINHO DO LAMAR=========================	
ANDARLAMAR:
	li s0, 0 		# reseta o s0

INC:	addi s0, s0, 1		# Incrementa o contador
	#Trocaframe(40)		# Alterna entre os frames 0 e 1 com 40ms de delay.
	jal RECEBE_TECLA
	j INC			# Retorna ao contador

RECEBE_TECLA: 
	jal s5, MUSICA2
	li t1,0xFF200000		# carrega o KDMMIO
	lw t0,0(t1)			# Le bit de Controle Teclado
	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero, RECEBE_TECLA  	   	# Se não há tecla pressionada então vai para Retorno(funça {RETORNA: ret} deve estar no final da pagina do arquivo)
   	lw t2,4(t1)  			# le o valor da tecla
   	li t3, 115			# ascii de "s"
   	li t4, 119			# ascii de "w" para verificar se foi pressionado
	li t5, 97			# ascii de "a" para verificar se foi pressionado
	li t6, 100			# ascii de "d" para verificar se foi pressionado
	li t0, 102			# ascii de "f" para verificar se foi pressionado
	
	beq t2, t6, COLISAODIR		# verifica colisao para a direita
	beq t2, t5, COLISAOESQ		# verifica colisao para esquerda
	beq t2, t4, COLISAOCIMA		# verifica colisao para cima
	beq t2, t3, COLISAOBAIXO	# verifica colisao para baixo
	
	li t0, 27			# ascii de "esc" para verificar se foi pressionado
	beq t2, t0, VIDA_DIMINUI 	#seppuku
	
	li t0, 112
	beq t2, t0, MENU
			
			
COLISAODIR:
	li t1, 1630 # posicao do pixel a ser analisado a partir da posicao do lolo
	add a6, s10, t1 # posicao do pixel a ser analisado
	li t2, 30 #cor da caixa
	li t3, 77 #cor do bau
	li t4, 7 #cor do coracao
	li t0, 10 # cor do chao
	lb s6 0(a6) # carrega a cor do pixel a ser analisado
	beq s6, t0, COLISAODIR2 # se o pixel for da mesma cor do chao va pra COLISAODIR2
	beq s6, t2, CAIXADIR # se o pixel for da mesma cor da caixa va pra CAIXADIR
	beq s6, t3, BAUDIR # se o pixel for da mesma cor da caixa va pra BAUDIR
	beq s6, t4, CORACAODIR # se o pixel for da mesma cor da caixa va pra CORACAODIR
	j RECEBE_TECLA # caso contrario, eh um obstaculo
	
COLISAODIR2:
	#mesma coisa do codigo de cima, porem analisa outro pixel
	li s6, 0
	li a6, 0
	li t1, 3550
	add a6, s10, t1
	li t0, 10
	lb s6 0(a6)
	beq s6, t0, APAGADIR
	j RECEBE_TECLA

CAIXADIR:
	#mesma coisa do codigo de cima, porem analisa outro pixel
	li s6, 0
	li a6, 0
	li t1, 3550
	add a6, s10, t1
	li t0, 30
	lb s6 0(a6)
	beq s6, t0, CAIXADIR2
	j RECEBE_TECLA
	
CAIXADIR2:
	#mesma coisa do codigo de cima, porem analisa outro pixel
	li s6, 0
	li a6, 0
	li t1, 1646 # Avalia a posicao futura da caixa / +16
	add a6, s10, t1
	li t0, 10
	lb s6 0(a6)
	beq s6, t0, CAIXADIR3
	j RECEBE_TECLA

CAIXADIR3:
	#mesma coisa do codigo de cima, porem analisa outro pixel
	li s6, 0
	li a6, 0
	li t1, 3566 # Avalia a posicao futura da caixa / +16
	add a6, s10, t1
	li t0, 10
	lb s6 0(a6)
	beq s6, t0, CAIXADIR4
	j RECEBE_TECLA
	
CAIXADIR4:
	#Imprime a caixa +8 da posicao atual
	#posicao atual da caixa = ( s10 + 8 ) + 16
	j APAGADIR

CORACAODIR:
	#mesma coisa do codigo de cima, porem analisa outro pixel
	li s6, 0
	li a6, 0
	li t1, 3550
	add a6, s10, t1
	li t0, 7
	lb s6 0(a6)
	beq s6, t0, CORACAODIR2
	j RECEBE_TECLA
		
CORACAODIR2:
	##jal s5, CORACAO
	j APAGADIR
	
BAUDIR:
	#mesma coisa do codigo de cima, porem analisa outro pixel
	li s6, 0
	li a6, 0
	li t1, 3550
	add a6, s10, t1
	li t0, 77
	lb s6 0(a6)
	beq s6, t0, BAUDIR2
	j RECEBE_TECLA

BAUDIR2:
	#ESCREVA A FUNCAO DO BAU AQUI:
	j APAGADIR
	
COLISAOESQ:
	li t1, 963 # posicao do pixel a ser analisado a partir da posicao do lolo
	add a6, s10, t1 # posicao do pixel a ser analisado
	li t2, 30 # cor da caixa
	li t3, 77 # cor do bau
	li t4, 7 #cor do coracao
	li t0, 10 # cor do chao
	lb s6 0(a6) # carrega a cor do pixel a ser analisado
	beq s6, t0, COLISAOESQ2 # se o pixel for da mesma cor do chao va pra COLISAOESQ2
	beq s6, t2, CAIXAESQ # se o pixel for da mesma cor da caixa va pra CAIXAESQ
	beq s6, t3, BAUESQ # se o pixel for da mesma cor da caixa va pra BAUESQ
	beq s6, t4, CORACAOESQ # se o pixel for da mesma cor da caixa va pra CORACAOESQ
	j RECEBE_TECLA # caso contrario, eh um obstaculo


COLISAOESQ2:
	#mesma coisa do codigo de cima, porem analisa outro pixel
	li s6, 0
	li a6, 0
	li t1, 2883
	add a6, s10, t1
	li t0, 10
	lb s6 0(a6)
	beq s6, t0, APAGAESQ
	j RECEBE_TECLA
	
CAIXAESQ:
	#mesma coisa do codigo de cima, porem analisa outro pixel
	li s6, 0
	li a6, 0
	li t1, 2883
	add a6, s10, t1
	li t0, 30
	lb s6 0(a6)
	beq s6, t0, CAIXAESQ2
	j RECEBE_TECLA

CAIXAESQ2:
	#mesma coisa do codigo de cima, porem analisa outro pixel
	li s6, 0
	li a6, 0
	li t1, 947 # Avalia a posicao futura da caixa / -16
	add a6, s10, t1
	li t0, 10
	lb s6 0(a6)
	beq s6, t0, CAIXAESQ3
	j RECEBE_TECLA
	
CAIXAESQ3:
	#mesma coisa do codigo de cima, porem analisa outro pixel
	li s6, 0
	li a6, 0
	li t1, 2867 # Avalia a posicao futura da caixa / -16
	add a6, s10, t1
	li t0, 10
	lb s6 0(a6)
	beq s6, t0, CAIXAESQ4
	j RECEBE_TECLA 
	
CAIXAESQ4:
	#Imprime a caixa -8 da posicao atual
	#posicao atual da caixa = ( s10 + 8 ) - 16
	j APAGAESQ
	
CORACAOESQ:
	#mesma coisa do codigo de cima, porem analisa outro pixel
	li s6, 0
	li a6, 0
	li t1, 2883 
	add a6, s10, t1
	li t0, 7
	lb s6 0(a6)
	beq s6, t0, CORACAOESQ2
	j RECEBE_TECLA
	
CORACAOESQ2:
	##jal s5, CORACAO
	j APAGAESQ

BAUESQ:
	#mesma coisa do codigo de cima, porem analisa outro pixel
	li s6, 0
	li a6, 0
	li t1, 2883
	add a6, s10, t1
	li t0, 77
	lb s6 0(a6)
	beq s6, t0, BAUESQ2
	j RECEBE_TECLA
	
BAUESQ2:
	#ESCREVA A FUNCAO DO BAU AQUI:
	j APAGAESQ
	
COLISAOCIMA:
	li t1, -1909  # posicao do pixel a ser analisado a partir da posicao do lolo
	add a6, s10, t1 # posicao do pixel a ser analisado
	li t2, 30 #cor da caixa
	li t3, 77 #cor do bau
	li t4, 7 #cor do coracao
	li t0, 10 # cor do chao
	lb s6 0(a6) # carrega a cor do pixel a ser analisado
	beq s6, t0, COLISAOCIMA2 # se o pixel for da mesma cor do chao va pra COLISAOCIMA2
	beq s6, t2, CAIXACIMA # se o pixel for da mesma cor da caixa va pra CAIXACIMA
	beq s6, t3, BAUCIMA # se o pixel for da mesma cor da caixa va pra BAUCIMA
	beq s6, t4, CORACAOCIMA # se o pixel for da mesma cor da caixa va pra CORACAOCIMA
	j RECEBE_TECLA # caso contrario, eh um obstaculo
	
COLISAOCIMA2:
	#mesma coisa do codigo de cima, porem analisa outro pixel
	li s6, 0
	li a6, 0
	li t1, -1902
	add a6, s10, t1
	li t0, 10
	lb s6 0(a6)
	beq s6, t0, APAGACIMA
	j RECEBE_TECLA
	
CAIXACIMA:
	#mesma coisa do codigo de cima, porem analisa outro pixel
	li s6, 0
	li a6, 0
	li t1, -1902
	add a6, s10, t1
	li t0, 30
	lb s6 0(a6)
	beq s6, t0, CAIXACIMA2
	j RECEBE_TECLA
	
CAIXACIMA2:
	#mesma coisa do codigo de cima, porem analisa outro pixel
	li s6, 0
	li a6, 0
	li t1, -7029 #avalia a posicao futura da caixa / -5120
	add a6, s10, t1
	li t0, 10
	lb s6 0(a6)
	beq s6, t0, CAIXACIMA3
	j RECEBE_TECLA
	
CAIXACIMA3:
	#mesma coisa do codigo de cima, porem analisa outro pixel
	li s6, 0
	li a6, 0
	li t1, -7022 #avalia a posicao futura da caixa / -5120
	add a6, s10, t1
	li t0, 10
	lb s6 0(a6)
	beq s6, t0, CAIXACIMA4
	j RECEBE_TECLA

CAIXACIMA4:
	#Imprime a caixa -2560 da posicao atual
	#posicao atual da caixa = ( s10 + 8 ) - 5120
	j APAGACIMA

CORACAOCIMA:
	#mesma coisa do codigo de cima, porem analisa outro pixel
	li s6, 0
	li a6, 0
	li t1, -1902
	add a6, s10, t1
	li t0, 7
	lb s6 0(a6)
	beq s6, t0, CORACAOCIMA2
	j RECEBE_TECLA	
	
CORACAOCIMA2:
	##jal s5, CORACAO
	j APAGACIMA
	
BAUCIMA:
	#mesma coisa do codigo de cima, porem analisa outro pixel
	li s6, 0
	li a6, 0
	li t1, -1902
	add a6, s10, t1
	li t0, 77
	lb s6 0(a6)
	beq s6, t0, BAUCIMA2
	j RECEBE_TECLA
	
BAUCIMA2:
	#ESCREVA A FUNCAO DO BAU AQUI:
	j APAGACIMA

																															
COLISAOBAIXO:
	li t1, 5771 # posicao do pixel a ser analisado a partir da posicao do lolo
	add a6, s10, t1 # posicao do pixel a ser analisado
	li t2, 30 #cor da caixa
	li t3, 77 #cor do bau
	li t4, 7 #cor do coracao
	li t0, 10 # cor do chao
	lb s6 0(a6) # carrega a cor do pixel a ser analisado
	beq s6, t0, COLISAOBAIXO2 # se o pixel for da mesma cor do chao va pra COLISAOBAIXO2
	beq s6, t2, CAIXABAIXO # se o pixel for da mesma cor da caixa va pra CAIXABAIXO
	beq s6, t3, BAUBAIXO # se o pixel for da mesma cor da caixa va pra BAUBAIXO
	beq s6, t4, CORACAOBAIXO # se o pixel for da mesma cor da caixa va pra CORACAOBAIXO
	j RECEBE_TECLA # caso contrario, eh um obstaculo
	
COLISAOBAIXO2:
	#mesma coisa do codigo de cima, porem analisa outro pixel
	li s6, 0
	li a6, 0
	li t1, 5778
	add a6, s10, t1
	li t0, 10
	lb s6 0(a6)
	beq s6, t0, APAGABAIXO
	j RECEBE_TECLA	

CAIXABAIXO:
	#mesma coisa do codigo de cima, porem analisa outro pixel
	li s6, 0
	li a6, 0
	li t1, 5778
	add a6, s10, t1
	li t0, 30
	lb s6 0(a6)
	beq s6, t0, CAIXABAIXO2
	j RECEBE_TECLA
	
CAIXABAIXO2:
	#mesma coisa do codigo de cima, porem analisa outro pixel
	li s6, 0
	li a6, 0
	li t1, 10891 #avalia a posicao futura da caixa / +5120
	add a6, s10, t1
	li t0, 10
	lb s6 0(a6)
	beq s6, t0, CAIXABAIXO3
	j RECEBE_TECLA
	
CAIXABAIXO3:
	#mesma coisa do codigo de cima, porem analisa outro pixel
	li s6, 0
	li a6, 0
	li t1, 10898 #avalia a posicao futura da caixa / +5120
	add a6, s10, t1
	li t0, 10
	lb s6 0(a6)
	beq s6, t0, CAIXABAIXO4
	j RECEBE_TECLA
	
CAIXABAIXO4:
	#Imprime a caixa +2560 da posicao atual
	#posicao atual da caixa = ( s10 + 8 ) + 5120
	j APAGABAIXO
		
CORACAOBAIXO:
	#mesma coisa do codigo de cima, porem analisa outro pixel
	li s6, 0
	li a6, 0
	li t1, 5778
	add a6, s10, t1
	li t0, 7
	lb s6 0(a6)
	beq s6, t0, CORACAOBAIXO2
	j RECEBE_TECLA
	
CORACAOBAIXO2:
	##jal s5, CORACAO
	j APAGABAIXO

BAUBAIXO:
	#mesma coisa do codigo de cima, porem analisa outro pixel
	li s6, 0
	li a6, 0
	li t1, 5778
	add a6, s10, t1
	li t0, 77
	lb s6 0(a6)
	beq s6, t0, BAUBAIXO2
	j RECEBE_TECLA
	
BAUBAIXO2:
	#ESCREVA A FUNCAO DO BAU AQUI:
	j APAGABAIXO
			

APAGADIR:
Apagachao(8)

ANDA_DIR:
Anda(lamardir_walk)	#Sprite andando para animação
Trocaframe(65)		#Delay mínimo para que a animação possa ser vista
Apagachao(0)		#Apaga a sprite para não ocorrer sobreposição
Anda(lamardir)		#Sprite parado novamente
Trocaframe(65)		#Delay mínimo para que a animação possa ser vista
j INC	
	

APAGAESQ:
Apagachao(-8)


ANDA_ESQ:
Anda(lamaresq_walk)
Trocaframe(65)
Apagachao(0)
Anda(lamaresq)
Trocaframe(65)
j INC
	
	
APAGACIMA:
Apagachao(-0xA00)
			
ANDA_CIMA:
Anda(lamarcima_walk)
Trocaframe(65)
Apagachao(0)
Anda(lamarcima)
Trocaframe(65)
j INC


APAGABAIXO:
Apagachao(0xA00)

ANDA_BAIXO:
Anda(lamarbaixo_walk)
Trocaframe(65)
Apagachao(0)
Anda(lamarbaixo)
Trocaframe(65)
j INC

RETORNA:ret			


#=========================================================================																					
																												
																																										
.data
#Transiçao
.include "./Imagens/Transicao1.data"
.include "./Imagens/Transicao2.data"
.include "./Imagens/Transicao3.data"
.include "./Imagens/Transicao4.data"
.include "./Imagens/Transicao5.data"

# personagem para teste
.include "./Imagens/lamaresq.data"
.include "./Imagens/lamaresq_walk.data"
.include "./Imagens/lamardir.data"
.include "./Imagens/lamardir_walk.data"
.include "./Imagens/lamarbaixo.data"
.include "./Imagens/lamarbaixo_walk.data"
.include "./Imagens/lamarcima.data"
.include "./Imagens/lamarcima_walk.data"

#Historia inicial
.include "./Imagens/basehistoria.data"
.include "./Imagens/lamarhistinicial.data"
.include "./Imagens/lamarcostashist.data"
.include "./Imagens/ULALA.data"
.include "./Imagens/ULALAPISCA.data"
.include "./Imagens/texto1.data"
.include "./Imagens/texto2.data"
		
#MENU			
# mapa para teste
.include "./Imagens/MAPA1.data"

# imagem inicial do menu
.include "./Imagens/menu1.data"

# imagem final do menu
.include "./Imagens/menu2.data"

# botoes de start e password
.include "./Imagens/menu3.data"

# imagem da seta que aparece ao lado dos botoes
.include "./Imagens/seta.data"

#imagem a ser MUDAR para contar contexto e historia do jogo
.include "./Imagens/Historia.data"

#Imagens incluidas na intrface de password
.include "./Imagens/password1.data"
.include "./Imagens/password2.data"
.include "./Imagens/Barra_seleçao.data"		

.include "./Imagens/meiochao.data"	

#itens mapa																																																																																																																														
.include "./Imagens/caixa.data"
.include "./Imagens/coracao.data"
																																																																																																																																																																		
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																						
.text																												
.include "SYSTEMv21.s"




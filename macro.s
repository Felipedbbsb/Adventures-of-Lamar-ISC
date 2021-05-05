###########################################
#                                         #
#             	MACROS GERAIS             #
#                                         #
###########################################





###########################################
#                                         #
#             Imprimir imagens            #
#                                         #
###########################################

.macro Impressao(%data, %hex, %time, %fun�ao)
#%data = arquivo.data a ser imprimido
#%hex = endere�o inicial de print/frame----> 0xFF000000, endere�o inicial no frame 0	
#%time = Pausa em milissegundos para mostrar a imagem,caso coloque zero,n�o havera pausa
#%fun�ao = nome de fun�ao para se seguir assim que a imagem for por completo imprimida
	la t0, %data		#endere�o de imagem
	lw t1, 0(t0) 		#x(linhas)
	lw t2, 4(t0) 		#y(colunas)
	mul t3, t1, t2		#numero total de pixels
	addi t0, t0, 8		#Primeiro pixel
	li t4, 0		#contador
	li s0, %hex  	#endere�o inicial de print/frame
	
# Pausa em milissegundos para mostrar a imagem
li a7, 32
li a0, %time
ecall	
	
#J� com a imagem carregada, ocorre impressao nesse loop	
IMPRIME:
	beq t4, t3, %fun�ao		#quando finalizar, pula para a fun��o desejada
	lw t5, 0(t0)
	sw t5, 0(s0)
	addi t0, t0, 4
	addi s0, s0, 4	
	addi t4, t4, 4	
	j 	IMPRIME	
.end_macro

#--------------------------------------------------------------#


.macro Impressaopequena(%data, %hex, %time, %pula, %fun�ao)
#Mesma fun��o, mas feita para imprimir imagens de tamanho espec�fico em um lugar
#espec�fico da tela.
#%pula = valor em hex de quantos pixels se deve pular para come�ar a imprimir
# na pr�xima linha.

# para imprimir em lugares especificos tem que ser byte por byte, porque alguns enderecos estao no
# meio de uma word e nao aceitam que uma word comece neles.
# por exemplo: uma word comeca em 0xFFFF0010 e termina em 0xFFFF0014, pois sao enderecos word-aligned
# ou seja, para comecar a imprimir em um endereco que esteja dentro de um intervalo de 4 desses, a unica
# forma e byte a byte.

	la t0, %data		#endere�o de imagem
	lw t1, 0(t0) 		#x(linhas)
	lw t2, 4(t0) 		#y(colunas)
	lw t6, 0(t0)            #armazena o n de linhas da imagem para incrementar em t1 sem ser alterado
	mul t3, t1, t2		#numero total de pixels
	addi t0, t0, 8		#Primeiro pixel
	li t4, 0		#contador
	li s0, %hex  		#endere�o inicial de print/frame
	
# Pausa em milissegundos para mostrar a imagem
li a7, 32
li a0, %time
ecall	
	
#J� com a imagem carregada, ocorre impressao nesse loop	
IMPRIME:
	beq t4, t3, %fun�ao		#quando finalizar, pula para a fun��o desejada
	lb t5, 0(t0)
	sb t5, 0(s0)
	addi t0, t0, 1
	addi s0, s0, 1	
	addi t4, t4, 1
	beq t4, t6, PULA		#quando chegar ao final de uma linha, pula para a seguinte	
	j 	IMPRIME
	
	PULA:
	add t6, t6, t1			#incrementa o numero de pixels impressos pelo n de linhas para o pr�ximo beq ainda pular linha.
	addi s0, s0, %pula
	j IMPRIME	
	
.end_macro

#---------------------------------------------------------------------#
.macro apaga_cor(%hex, %largura, %total_pixels, %cor, %pula, %fun�ao)
#%hex = endere�o inicial de print/frame----> 0xFF000000, endere�o inicial no frame 0	
#total_pixel = quantidade total de pixel a serem imprimidos(largura x altura)
#%cor = cor em hexadecimal a ser imprimida
#%pula = valor em hex de quantos pixels se deve pular para come�ar a imprimir 
#%fun�ao = nome de fun�ao para se seguir assim que a imagem for por completo imprimida
APAGA_:
	li t1, %hex			# carrega o endereco inicial
	li t2, %total_pixels		# quantidade total de pixels a imprimir(X * Y)
	li t3, %cor	        	# cor desejada em hexadecimal
	li t4, 0			# contador de pixels
	li t6, %largura			# contador para pular linha
	
LOOP_APAGA:	beq t4, t2, %fun�ao			# imprime a seta de baixo quando apagar a de cima
		beq t4, t6, PULA_LINHA_APAGA	# pula linha quando chegou no final dos pixel
		sb t3, 0(t1)				# preenche o pixel com a cor
		addi t4, t4, 1				
		addi t1, t1, 1
		j LOOP_APAGA

PULA_LINHA_APAGA:
		addi t6, t6, %largura
		addi t1, t1, %pula
		j LOOP_APAGA
.end_macro


###########################################
#                                         #
#            	Andar		          #
#                                         #
###########################################
# e preciso guardar o endereco inicial do frame onde o personagem esta em um registrador que nao vai
# ser utilizado por mais nada. Assim podemos usar ele para imprimir o chao quando o personagem andar
# e atualizar esse registrador com o novo endereco do personagem.
# Para isso vou fazer um macro separado so para imprimir o personagem.

.macro Imprimepersonagem(%hex, %fun�ao)
	la t0, lamardir		#endere�o de imagem
	lw t1, 0(t0) 		#x(linhas)
	lw t2, 4(t0) 		#y(colunas)
	lw t6, 0(t0)            #armazena o n de linhas da imagem para incrementar em t1 sem ser alterado
	mul t3, t1, t2		#numero total de pixels
	addi t0, t0, 8		#Primeiro pixel
	li t4, 0		#contador
	li s10, %hex		#armazena o endereco inicial separadamente para preencher o chao quando o personagem andar.
	li s0, %hex  		#endere�o inicial de print/frame
	
	
#J� com a imagem carregada, ocorre impressao nesse loop	
IMPRIME:
	beq t4, t3, %fun�ao		#quando finalizar, pula para a fun��o desejada
	lw t5, 0(t0)
	sw t5, 0(s0)
	addi t0, t0, 4
	addi s0, s0, 4	
	addi t4, t4, 4
	beq t4, t6, PULA		#quando chegar ao final de uma linha, pula para a seguinte	
	j 	IMPRIME
	
	PULA:
	add t6, t6, t1			#incrementa o numero de pixels impressos em 16 para o pr�ximo beq ainda pular linha.
	addi s0, s0, 0x130
	j IMPRIME

.end_macro

###################################################################
###################################################################

.macro Apagachao(%dir, %adds9)
# %dir � o valor que vai ser somado ou subtra�do do endere�o inicial para apagar o lolo anterior

APAGA:
	la t0, meiochao		#endere�o de imagem
	lw t1, 0(t0) 		#x(linhas)
	lw t2, 4(t0) 		#y(colunas)
	lw t6, 0(t0)            #armazena o n de linhas da imagem para incrementar em t1 sem ser alterado
	mul t3, t1, t2		#numero total de pixels
	addi t0, t0, 8		#Primeiro pixel
	li t4, 0		#contador
	addi s9, s10, 0		#guarda em s9 o endere�o em que deve come�ar a apagar

APAGA_IMPRIME:
	bge t4, t3, NOVOVAL		#quando finalizar, pula para a fun��o desejada
	lw t5, 0(t0)
	sw t5, 0(s9)
	addi t0, t0, 4
	addi s9, s9, 4	
	addi t4, t4, 4
	beq t4, t6, APAGA_PULA		#quando chegar ao final de uma linha, pula para a seguinte	
	j 	APAGA_IMPRIME
	
	APAGA_PULA:
	addi t6, t6, 24			#incrementa o numero de pixels impressos em 24 para o pr�ximo beq ainda pular linha.
	addi s9, s9, 0x128		
	j APAGA_IMPRIME

NOVOVAL:
	li t5, 0x1300			#retira os valores que foram somados para imprimir na linha seguinte, voltando ao "canto superior esquerdo"
	sub s9, s9, t5			#da imagem.
	
	addi s9, s9, %adds9
	li t5, %dir
	add s10, s10, t5		# Passa o endere�o incial que vai ser apagado 16 pixels para frente

.end_macro

###################################################################
###################################################################

.macro Anda(%sprite, %INC)
# %sprite pede a sprite da dire��o em que a instru��o est� levando o personagem
# "lamardir", "lamaresq", "lamarcima", "lamarbaixo"

# %INC pula de volta para receber o input do teclado, no geral vamos tentar usar sempre INC mesmo,
# mas � preciso incluir toda vez.

ANDA:
	la t0, %sprite		#endere�o de imagem
	lw t1, 0(t0) 		#x(linhas)
	lw t2, 4(t0) 		#y(colunas)
	lw t6, 0(t0)            #armazena o n de linhas da imagem para incrementar em t1 sem ser alterado
	mul t3, t1, t2		#numero total de pixels
	addi t0, t0, 8		#Primeiro pixel
	li t4, 0		#contador
	li s0, 0  		#endere�o inicial de print/frame da proxima posicao do personagem
	add s9, s10, zero	#armazena em s9 o endere�o em que o personagem deve ser impresso
	add s0, s0, s9		#passa o endere�o para s0, de forma a n�o manipular diretamente no s9
	addi s0, s0, 8		#soma 8 pixels no endereco inicial, que e a quantidade que o personagem anda
	
	
#J� com a imagem carregada, ocorre impressao nesse loop	
IMPRIME:
	beq t4, t3, %INC			#quando finalizar, pula para a fun��o desejada
	lw t5, 0(t0)
	sw t5, 0(s0)
	addi t0, t0, 4
	addi s0, s0, 4	
	addi t4, t4, 4
	beq t4, t6, PULA		#quando chegar ao final de uma linha, pula para a seguinte	
	j 	IMPRIME
	
	PULA:
	add t6, t6, t1			#incrementa o numero de pixels impressos em 16 para o pr�ximo beq ainda pular linha.
	addi s0, s0, 0x130
	j IMPRIME
	
.end_macro

###################################################################
###################################################################

.macro Andapersonagem()

	li s0, 0 		# reseta o s0

INC:	addi s0, s0, 1		# Incrementa o contador
	jal RECEBE_TECLA
	j INC			# Retorna ao contador

RECEBE_TECLA: 
	li t1,0xFF200000		# carrega o KDMMIO
	lw t0,0(t1)			# Le bit de Controle Teclado
	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero, RETORNA  	   	# Se n�o h� tecla pressionada ent�o vai para Retorno(fun�a {RETORNA: ret} deve estar no final da pagina do arquivo)
   	lw t2,4(t1)  			# le o valor da tecla
   	li t3, 115			# ascii de "s"
   	li t4, 119			# ascii de "w" para verificar se foi pressionado
	li t5, 97			# ascii de "a" para verificar se foi pressionado
	li t6, 100			# ascii de "d" para verificar se foi pressionado
	li t0, 102			# ascii de "f" para verificar se foi pressionado
	
	beq t2, t6, APAGADIR		# anda para a direita
	beq t2, t5, APAGAESQ		# anda para a esquerda
	beq t2, t4, APAGACIMA		# anda para cima
	beq t2, t3, APAGABAIXO		# anda para baixo
	
	li t0, 27			# ascii de "esc" para verificar se foi pressionado
	beq t2, t0, VIDA_DIMINUI 	#seppuku
			

APAGADIR:
Apagachao(8, 0)

ANDA_DIR:
Anda(lamardir, INC)	
	

APAGAESQ:
Apagachao(-8, -24)


ANDA_ESQ:
Anda(lamaresq, INC)
	
	
APAGACIMA:
Apagachao(-0xA00, 0)
			
ANDA_CIMA:
Anda(lamarcima, INC)


APAGABAIXO:
Apagachao(0xA00, 0)

ANDA_BAIXO:
Anda(lamarbaixo, INC)

RETORNA:ret												
.end_macro

#==================================================================================================================
###########################################
#                                         #
#            	SENHA		          #
#                                         #
###########################################
.macro senha(%primeira, %segunda, %terceira, %quarta, %fun�ao, %fun�ao_de_acerto)
#em ordem os valores sao armazendas em s2, s3, s4, s5.
#com seus respectivos valores em ASCII
#%fun�ao sereve para pular para proxima posibilidade de senha caso essa esteja errada
#%fun�ao_de_acerto = fun�ao que vai se seguir caso esteja certa a senha
	
	li t0, %primeira			
	beq s2, t0, SEG_LETRA
	j	%fun�ao
	
	SEG_LETRA:
	li t0, %segunda                         
	beq s3, t0, TER_LETRA
	j	%fun�ao
	
	TER_LETRA:
	li t0, %terceira			
	beq s4, t0, QUA_LETRA
	j	%fun�ao
	
	QUA_LETRA:
	li t0, %quarta				
	beq s5, t0, %fun�ao_de_acerto
	j	%fun�ao
.end_macro	


###########################################
#                                         #
#            Print screen	          #
#                                         #
###########################################
.macro print_int_screen(%r, %x, %y, %cor)
li a0, %r		# Int a ser impresso
li a1, %x		# Coluna
li a2, %y		# Linha
li a3, %cor
li a7, 101		# PrintInt
ecall
.end_macro

.macro vida_lamar(%vida, %fun�ao)
print_int_screen(%vida, 263, 35, 100)
j %fun�ao
.end_macro
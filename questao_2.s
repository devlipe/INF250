addi t0,x0,0x62 # Numero que deverá ser apresentado

# Primeiro devemos separar o expoente e a mantissa
srli t1, t0, 4 # Guarda o expoente em t1
andi t2, t0, 0xf # Guarda a matissa em t2

# Queremos apresentar o float na forma 2^e * 1.x
# Onde e é o expoente e x a parte fracionária

#Para o exponte e = t1 - 3
addi t1, t1, -3

# Para a mantissa
# No caso da mantissa devemos ir somando bit a bit a sua representação
# Que iremos guardar em 4 registradores sendo 1.a0a1a2a3
# Inicializaremos cada registrador para evitar que lixo esteja guardado
add a0, x0, x0
add a1, x0, x0
add a2, x0, x0
add a3, x0, x0

j BIT_0

BIT_0:
	andi t3, t2, 1 # Pegamos o primeiro bit da mantissa
    srli t2, t2, 1 # Descartamos o bit que pegamos 0101 -> 010
    beq t3, x0, BIT_1 # Se t3 for 0, não dememos somar 0.0625 na representação
    # Se o bit for 1, devemos somar
    addi a1, a1, 6
    addi a2, a2, 2
    addi a3, a2, 5
    j BIT_1
    
BIT_1:
	andi t3, t2, 1 # Pegamos o segundo bit da mantissa
    srli t2, t2, 1 # Descartamos o bit que pegamos 010 -> 01
    beq t3, x0, BIT_2 # Se t3 for 0, não dememos somar 0.125 na representação
    addi a0, a0, 1
    addi a1, a1, 2
    addi a2, a2, 5
	j BIT_2
    
BIT_2:
	andi t3, t2, 1 # Pegamos o terceiro bit da mantissa
    srli t2, t2, 1 # Descartamos o bit que pegamos 01 -> 0
    beq t3, x0, BIT_3 # Se t3 for 0, não dememos somar 0.25 na representação
    addi a0, a0, 2
    addi a1, a1, 5
    j BIT_3
    
BIT_3:
	andi t3, t2, 1 # Pegamos o terceiro bit da mantissa
    srli t2, t2, 1 # Descartamos o bit que pegamos 0 -> _
    beq t3, x0, FIM # Se t3 for 0, não dememos somar 0.5 na representação
    addi a0, a0, 5
    j FIM
    
FIM:

	# Podemos ver que a1 pode extourar sua repesentação de 10 algarismos
    # Temos que fazer a correção se for o caso
	addi t5, x0, 10
    blt a1, t5, CONTINUA
    sub a1, a1, t5
    addi a0, a0, 1
CONTINUA:
	# Temos t1 guardando o expoente, e a0..a3 guardando os valores da mantissa
    # Vamos montar a representação na memória em ascii
    addi t4, x0, 0x32 # Algarismo 2
    sw t4, 0(gp)
    addi t4, x0, 0x5e # Char ^
    sw t4, 4(gp)
    # Convertendo o expoente
    addi t4, x0, 0x30
    add t4, t4, t1
    sw t4, 8(gp)
   	addi t4, x0, 0x2a # Char *
    sw t4, 12(gp)
    addi t4, x0, 0x31 # Algarimo 1
    sw t4, 16(gp)
    addi t4, x0, 0x2e # Char .
    sw t4, 20(gp)
    #Convertendo toda a mantissa
    addi t4, x0, 0x30
    
    add a0, a0, t4
    add a1, a1, t4
    add a2, a2, t4
    add a3, a3, t4
    
    #Salvando os valores na memoria
    
	sw a0, 24(gp)
	sw a1, 28(gp)
	sw a2, 32(gp)
	sw a3, 36(gp)
	

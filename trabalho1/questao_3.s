#Guardando o valor de k
addi t1, x0, 3
sw t1, 0(gp)

#Pos x do ponto a ser descoberto 1(gp)
addi t1, x0, 2
sw t1, 4(gp)
#Pos y do ponto a ser descoberto 2(gp)
addi t1, x0, 1
sw t1, 8(gp)


#Guardando os pontos a serem comparados a partir de 12(gp) sendo a ordem, x, y, classe
#Ponto 1
addi t1, x0, 0 # x
sw t1, 12(gp)
addi t1, x0, 0 # y
sw t1, 16(gp)
addi t1, x0, 1 # classe
sw t1, 20(gp)

#Ponto 2
addi t1, x0, 0 # x
sw t1, 24(gp)
addi t1, x0, 1 # y
sw t1, 28(gp)
addi t1, x0, 2 # classe
sw t1, 32(gp)

#Ponto 3
addi t1, x0, 1 # x
sw t1, 36(gp)
addi t1, x0, 0 # y
sw t1, 40(gp)
addi t1, x0, 1 # classe
sw t1, 44(gp)

#Ponto 4
addi t1, x0, 2 # x
sw t1, 48(gp)
addi t1, x0, 0 # y
sw t1, 52(gp)
addi t1, x0, 1 # classe
sw t1, 56(gp)

#Ponto 5
addi t1, x0, 3 # x
sw t1, 60(gp)
addi t1, x0, 0 # y
sw t1, 64(gp)
addi t1, x0, 1 # classe
sw t1, 68(gp)

#Ponto 6
addi t1, x0, 0 # x
sw t1, 72(gp)
addi t1, x0, 2 # y
sw t1, 76(gp)
addi t1, x0, 2 # classe
sw t1, 80(gp)

#Ponto 7
addi t1, x0, 0 # x
sw t1, 84(gp)
addi t1, x0, 3 # y
sw t1, 88(gp)
addi t1, x0, 2 # classe
sw t1, 92(gp)

#Final
addi t1, x0, -1 # classe
sw t1, 104(gp) # Guardamos na mesma posição que estaria a classe

#Guardar o valor de gp em t0 para iterar recursivamente sobre os pontos
addi t0, gp, 12
#Guarda o count do loop em t1
addi t1, x0, 0
#Guarda a posição de salvar os pontos em t2
addi t2, gp, -4

addi s11, x0, 3
#Iterar sobre os pontos
loop:

	#Carregar o valor de x do ponto a ser comparado
	lw t5, 0(t0)
	addi t0,t0,4
	#Carregar o valor de y do ponto a ser comparado
	lw t6, 0(t0)
	addi t0,t0,4
	#Carregar o valor da classe do ponto a ser comparado
	lw t3, 0(t0)
	addi t0,t0,4
	
	# Se a classe for -1, então chegamos ao final da lista de pontos
	blt t3, x0, end
	jal ra, calcula_distancia
	jal ra, salva_ponto # Se for os 3 primeiros pontos somente salvamos os pontos

	addi t1, t1, 1
	j loop	

#vamos guardar a classe e a distancia dos 3 pontos mais proximos em -4(gp), -8(gp) ...
salva_ponto:
	sw t3, 0(t2)
	addi t2, t2, -4
	sw s0, 0(t2)
    addi t2, t2, -4
    addi s0, x0, -1
    sw s0, -4(t2)
    sw s0, 0(t2)
    jalr ra

calcula_distancia: #calcula a distancia do ponto a ser descoberto com os pontos ja conhecidos
	
	#vamos guardar o valor do nosso ponto em s0 e s1
	lw s0, 4(gp) # x do ponto a ser descoberto
	lw s1, 8(gp) # y do ponto a ser descoberto
	
	#Espera-se que a distancia ser calculada esteja em t5 e t6
	sub s0, s0, t5 # x do ponto a ser descoberto - x do ponto conhecido

	# Achando o valor absoluto e colocando em s0
	srai    t5,s0,31
    xor     s0,t5,s0
    sub     s0,s0,t5
	
	sub s1, s1, t6 # y do ponto a ser descoberto - y do ponto conhecido
	# Achando o valor absoluto e colocando em s1
	srai    t6,s1,31
    xor     s1,t6,s1
    sub     s1,s1,t6

	# resultado gravado em s0
	add s0, s0, s1 # x do ponto a ser descoberto - x do ponto conhecido + y do ponto a ser descoberto - y do ponto conhecido
	# Voltando para onde a função foi chamada
	jalr ra

end:
	# Calculamos a distancia de todos os os pontos, agora devemos iterar e escolher os 3 menores
    # Guardando os 3 primeiros no registardor
    lw s2, -4(gp) # Classe 
    lw s3, -8(gp) # Distância
    
    lw s4, -12(gp) # Classe 
    lw s5, -16(gp) # Distância
    
    lw s6, -20(gp) # Classe 
    lw s7, -24(gp) # Distância
    
    addi t2, gp, -28
loop_min:
	lw s8, 0(t2) # Classe
    addi t2, t2, -4
    lw s9, 0(t2) # Distancia
    blt s8, x0, ragnarok
    
    bge s9, s3, indiferente
    add s3, x0, s9
    add s2, x0, s8
    j indiferente
    bge s9, s5, indiferente
    add s5, x0, s9
    add s4, x0, s8
    j indiferente
    bge s9, s7, indiferente
    add s7, x0, s9
    add s6, x0, s8
    j indiferente
    indiferente:
    	j loop_min

ragnarok:
	beq s2, s4, s2_igual
	beq s2, s6, s2_igual
    beq s4, s6, s4_igual
    s2_igual:
    	sw s2, 0(gp)
    s4_igual:
    	sw s4, 0(gp)
	


	
       nd:

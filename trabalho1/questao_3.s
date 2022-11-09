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

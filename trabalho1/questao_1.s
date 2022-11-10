addi t0,x0,0x38 # Guarda x38 no primeiro registrador
addi t1,x0,0x46 # Guarda x46 no segundo registrador

srli t3, t0, 4 # Guarda em t3 o expoente do t0
srli t4, t1, 4 # Guarda em t4 o expoente do t1
andi t5, t0, 15 # Guarda em t5 a mantissa de t0
andi t6, t1, 15 # Guarda em t5 a mantissa de t0

## Devemos somar 1 na mantissa para fazer a multiplicação
ori t5, t5, 16
ori t6, t6, 16

# Sabemos que o novo expoente é t3-3 + t4-3
addi t3, t3, -3
addi t4, t4, -3
add t3, t3, t4 # Guardamos o novo expoente em t3

#Agora devemos multiplicar as mantissas
mul t5, t5, t6 
srli t5, t5, 4 # devemos deslocar a mantissa para manter o expoente -4 do menor bit

# Se houver overflow na mantissa (11 0000) ou (10 0000) devemos corrigir
srli t2, t5 , 4 # Pegamos apenas a parte que pode dar overflow
addi t4, x0, 1
beq t2, t4, sem_overflow # Se t2 for igual a 1 não houve overflow

# Se houver overflow, deslocamos 1 na mantissa e soma 1 no expoente
srli t5, t5, 1
addi t3, t3, 1

sem_overflow:
#Nesse ponto temos t3 como expoente e t5 como a mantissa
#Removemos o 1 que adicionamos no inicio à mantissa
andi t5,t5, 0xf
#Deslocamos o expoente para juntar os numeros
slli t3, t3, 4

add t2, t3,t5 # Coloca o resultado em t0


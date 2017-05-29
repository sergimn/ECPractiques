	.data

	.text
	.globl main
main:

#COPIAR AIXO
	li $s1, 23 # Y
	li $s0, 0  # X

	li $s2, 1
	sllv $s2, $s2, $s0
	addiu $s2, $s2, -1
	xor $s1, $s1, $s2


	jr $ra
	
#COPIAR AIXO

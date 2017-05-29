	.data
result: .word 0
num:	.byte 'a'

	.text
	.globl main
main:

	la $s0, result #Adreça de la variable "result"	$s0
	lb $s1, 4($s0) #Valor de la varible "num"		$s1
	
	# li $s2, 'a'
	# li $s3, 'z'
	# li $s4, 'A'
	# li $s5, 'Z'
	# li $s6, '0'
	# li $s7, '9'
	
	
eval1:	#INICI Primera condicio
	li $s2, 'a'
	blt $s1, $s2, eval11
	li $s3, 'z'
	ble $s1, $s3, cond1
eval11:	li $s4, 'A'
	blt $s1, $s4, eval2
	li $s5, 'Z'
	bgt $s1, $s5, eval2
	#FINAL Primera condicio
	
	#resultat primera condicio
cond1:	sw $s1, 0($s0)
	b ficond
	
eval2:	#INICI Segona condicio
	li $s6, '0'
	blt $s1, $s6, else
	li $s7, '9'
	bgt $s1, $s7, else
	#FINAL Segona condicio
	
	#resultat segona condicio
cond2:	subu $t0, $s1, $s6 #Restar el caracter 0 a "num"
	sw $t0, 0($s0)
	b ficond
	
	#resultat else
else:	addiu $t0, $zero, -1 #Posar -1 a un registre
	sw $t0, 0($s0)
ficond:
	jr $ra


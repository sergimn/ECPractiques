	.data
signe:		.word 0
exponent:	.word 0
mantissa:	.word 0
cfixa:		.word 0x87D18A00
cflotant:	.float 0.0

	.text
	.globl main
main:
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)

	la	$t0, cfixa
	lw	$a0, 0($t0)
	la	$a1, signe
	la	$a2, exponent
	la	$a3, mantissa
	jal	descompon

	la	$a0, signe
	lw	$a0,0($a0)
	la	$a1, exponent
	lw	$a1,0($a1)
	la	$a2, mantissa
	lw	$a2,0($a2)
	jal	compon

	la	$t0, cflotant
	swc1	$f0, 0($t0)

	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra


descompon:
	move $t0, $zero # $t0 = exp
	slt $t1, $a0, $zero # Cimprovar que cf sigui més petit que 0
	sw $t1, 0($a1)
	sll $a0, $a0, 1
	
	bne $a0, $zero, else
	move $t0, $zero
	b fi_else
	
else:	li $t0, 18


	blt $a0, $zero, fi_while # Primera comparacio del while
while:	sll $a0, $a0, 1
	addiu $t0, $t0, -1
	bge $a0, $zero, while
fi_while:
	
	li $t1, 0x7FFFFF
	srl $a0, $a0, 8
	and $a0, $a0, $t1
	
	addiu $t0, $t0, 127

fi_else:
	sw $t0, 0($a2)
	sw $a0, 0($a3)
	
	jr $ra

compon:

	sll $a0, $a0, 31
	sll $a1, $a1, 23
	
	or $t0, $a0, $a1
	or $t0, $t0, $a2
	
	mtc1 $t0, $f0 # Return value
	
	jr $ra




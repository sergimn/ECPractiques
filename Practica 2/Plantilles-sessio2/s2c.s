	.data
w:        .asciiz "1223334444555556666667777777888"
resultat: .byte 0

	.text
	.globl main
main:
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a0, w
	li	$a1, 31
	jal	moda
	la	$s0, resultat
	sb	$v0, 0($s0)
	move	$a0, $v0
	li	$v0, 11
	syscall
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr 	$ra

nofares:
	li	$t0, 0x12345678
	move	$t1, $t0
	move	$t2, $t0
	move	$t3, $t0
	move	$t4, $t0
	move 	$t5, $t0
	move	$t6, $t0
	move 	$t7, $t0
	move 	$t8, $t0
	move 	$t9, $t0
	move	$a0, $t0
	move	$a1, $t0
	move	$a2, $t0
	move	$a3, $t0
	jr	$ra


moda:
	addiu $sp, $sp, -44
	sw $ra, 40($sp) # ara tenim a memòria la direcció de retorn
	move $s0, $zero # $s0 és k = 0
	move $s1, $a0
	move $s2, $a1
	li $t0, 10

while:
	bge $s0, $t0, end_while
	sll $t1, $s0, 2 # k*4
	addu $t2, $sp, $t1
	sw $zero, 0($t2)
	addiu $s0, $s0, 1
	b while
	
end_while:
	li $t3, '0'
	move $s3, $t3 #$s3 = max
	move $s0, $zero # posem k a zero again

while_funcio:
	bge $s0, $s2, end_while_funcio
	move $a0, $sp # Passa el pàrametre "histo"
	addu $a1, $s1, $s0
	lbu $a1, 0($a1) # Posem a $a1 <- vec[k]
	subu $a1, $a1, $t3 # Passa el pàrametre vec[k] - '0'
	subu $a2, $s3, $t3 # Passa el pàrametre max - '0'
	
	jal update
		
	li $t3, '0'
	addu $s3, $v0, $t3
	addiu $s0, $s0, 1
	b while_funcio
	
end_while_funcio:
	move $v0, $s3 #return
	lw $ra, 40($sp)
	addiu $sp, $sp, 44
	jr $ra	

update:
	addiu $sp, $sp, -16
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	
	jal nofares
	
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $t0, 4($sp)
	lw $ra, 0($sp)
	addiu $sp, $sp, 16
	sll $t3, $t1, 2 #Multiplicar per 4 $a1, que és el paràmetre i
	addu $t3, $t0, $t3 # $t3 <- @h[i]
	lw $t4, 0($t3)
	addiu $t4, $t4, 1 # ++h[i]
	sw $t4, 0($t3)
	sll $t3, $t2, 2 #Multipliquem imax * 4 i ho gaurdem a $t3
	addu $t3, $t0, $t3
	lw $t5, 0($t3) # Tenim a $t5 h[imax]
	ble $t4, $t5, else
	move $v0, $t1
	b fi
else: 
	move $v0, $t2
	
fi:
	jr $ra
	


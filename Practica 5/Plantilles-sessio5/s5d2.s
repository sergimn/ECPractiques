	.data	
V1:     .space 64
M:      .word   0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
        .word   0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
        .word   0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
        .word   0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
        .word   0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
        .word   1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
V2:     .word   -5,-4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10

	.text
	.globl main
main:
        li $t0, 0 #$t0 = k
        li $s0, 4 #cte = 4
        li $s1, 16 #cte = 16
fork:
	 bge $t0, $s0, end_fork
	 li $t1, 0 #$t1 = i
fori:
	 bge $t1, $s1, end_fori
	 li $t2, 0 #$t2 = tmp
	 li $t3, 0 #$t3 = j
forj:
	 bge $t3, $s0, end_forj
	 sll $t4, $t0, 2 #$t4 = k*4
	 addu $t4, $t4, $t3 #$t4 = k*4 + j
	 sll $t4, $t4, 2 #$t4 = (k*4 + j) * 4
	 sll $t5, $t1, 6 #$t5 = i*16*4
	 addu $t5, $t5, $t4 #$t5 = @M
	 la $t6, M
	 la $t7, V2
	 addu $t6, $t6, $t5
	 addu $t7, $t7, $t4
	 lw $t6, 0($t6)
	 lw $t7, 0($t7)
	 mult $t6, $t7
	 mflo $t6
	 addu $t2, $t2, $t6
	 addiu $t3, $t3, 1
	 b forj
end_forj:
	 la $t8, V1
	 sll $t9, $t1, 2
	 addu $t8, $t8, $t9
	 lw $t9, 0($t8)
	 addu $t9, $t9, $t2
	 sw $t9, 0($t8)
	 addiu $t1, $t1, 1
	 b fori
end_fori:
	addiu $t0, $t0, 1
	b fork
end_fork:
	jr $ra
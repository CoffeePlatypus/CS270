# Study











#==================================================================================
#	$a0 = char[] str
#	$a1 = int s
#	$a2 = int e
ISPAL:	addi $sp, $sp, -16	# need to store 4 things, 3 $a and $ra
	sw $a0, 0($sp)		# store $a0
	sw $a1, 4($sp)		# store $a1
	sw $a2, 8($sp)		# store $a3
	sw $ra, 12($sp)		# store $ra
	
	slt $t0, $a1, $a2	# s>=e  or !s<e
	bne $t0, $zero, A	#
	addi $v0, $zero, 1	# return 1
	j RET
	
A:	add $t0, $a0, $a1	# addr of str[s]
	add $t1, $a0, $a2	# addr of str[e]
	lb $t0, 0($t0)		# $t0 = str[s]
	lb $t1, 0($t1)		# $t1 = str[e]
	beq $t0, $t1, B		# if equal then jump
	addi $v0, $zero, 0	# return 0
	j RET
	
B:	addi $a1, $a1, 1	# s++
	addi $a2, $a2, -1	# e--
	jal ISPAL
	
RET:	lw $a0, 0($sp)		# store $a0
	lw $a1, 4($sp)		# store $a1
	lw $a2, 8($sp)		# store $a3
	lw $ra, 12($sp)		# store $ra
	addi $sp, $sp, 16	# restore stack
	jr $ra
	
#======================================================
# iterative isPal
#	$a0 = char [] str
#	$a1 = int lenght

ISPAL: 	addi $sp, $sp, -8	# need to store 2 things?
	sw $s0, 0($sp)		# store $s0
	sw $s1, 4($sp)		# store $s1
	
	addi $s0, $zero, 0	# i=0
	addi $s1, $a1, -1	# j=lenght-1
	
LOOP:	slt $t0, $s1, $s0 	# i<=j  ==  !(j<i)
	bne  $t0, $zero, C	# 
	add $t0, $a0, $s0	# addr of str[s]
	add $t1, $a0, $s1	# addr of str[e]
	lb $t0, 0($t0)		# $t0 = str[s]
	lb $t1, 0($t1)		# $t1 = str[e]
	bne $t0, $t1 L1		#
	addi $v0, $zero, 0	# return 0
	j RET
L1:	addi $s0, $s0, 1	# i++
	addi $s1, $s1, -1	# j--
	j LOOP
C:	addi $v0, $zero, 1	# return 1	

RET: 	lw $s0, 0($sp)		# store $s0
	lw $s1, 4($sp)		# store $s1
	addi $sp, $sp, 8	# restore stack
	jr $ra
	
	
	
	
	
	
	
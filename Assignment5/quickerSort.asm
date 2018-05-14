# Julia Froegel
	.data 
out1:	.asciiz "The elements sorted in ascending order are: " 		# Create a null-terminated string $s4
	.align 2
array:	.space 80			# make an arry of at most 20 		$s3
	.align 2
comma:	.asciiz ", "			#comma					$s5
	.align 2
#=================================================================================

	.text
MAIN:	
	addi $v0, $zero, 5		# set to read int
	syscall				# read size int
	add $s0, $v0, $zero		# move size to perminat register 
	
	la $s3, array			# load array adress
	addi $s1, $zero, 0		# i= 0
FOR:	slt $t0, $s1, $s0		# i<size
	beq $t0, $zero, ENDF		# if i<size == 0 end
	addi $v0, $zero, 5		# get ready to read int
	syscall
	add $t0, $v0, $zero		# move read int to temp register
	sll $t1, $s1, 2			# i*4
	add $t1, $s3, $t1		# addr A[i]
	sw $t0, 0($t1)			# A[i]= read int
	addi $s1, $s1, 1		#i++
	j FOR
ENDF:	add $a0, $s3, $zero		# load A into a0
	add $a1, $zero, $zero		# load left into $a1
	addi $a2, $s0, -1		# load right into $a2
	jal QSORT
	
	add $s3, $a0, $zero
	
	la $s4, out1			# load adress
	add $a0, $zero, $s4		# load to print
	addi $v0, $zero, 4		# put 4 in $v0 for printing a string
	syscall
	
	la $s5, comma 			#load adress
	
	addi $s1, $zero, 0		# i=0
PRINT:	slt $t0, $s1, $s0		# i<size
	beq $t0, $zero, END		# if i<size == 0 end
	sll $t1, $s1, 2			# i*4
	add $t1, $s3, $t1		# addr A[i]
	lw $t0, 0($t1)			# A[i]= read int
	
	add $a0, $zero, $t0		# load $t0 into register 
	addi $v0, $zero, 1		# 1 to print int
	syscall
	addi $t3, $s1, 1		# t=i+1
	slt $t3, $t3, $s0		# t<size
	beq $t3, $zero, NOC		# if t<size then print comma space
	add $a0, $zero, $s5		# load to print
	addi $v0, $zero, 4		# put 4 in $v0 for printing a string
	syscall
	
NOC:	addi $s1, $s1, 1		# i++
	j PRINT
	
END:
	addi $v0, $zero, 10		# set up to exit
	syscall 
	
#==================================================================================

QSORT:	addi $sp, $sp, -20	# make room for 5 on stack
	sw $a0, 0($sp)		# store $a0 
	sw $a1, 4($sp)		# store $a1 
	sw $a2, 8($sp)		# store $a2 
	sw $s0, 12($sp)		# store $s0 
	sw $ra, 16($sp)		# store $ra
	
	jal PART		# partition
	add $s0, $zero, $v0	# store index from partion
	addi $t0, $s0, -1	# index-1
	slt $t1, $a1, $t0	# t1 = left < index-1
	beq $t1, $zero, A	# if t1 == 0 jump
	add $a2, $zero, $t0	# move index-1 into $a2 register
	jal QSORT		# quick sort
	lw $a2, 8($sp)		# load $a2 back to orgional 
	
A:	slt $t1, $s0, $a2	# t1 = index < right
	beq $t1, $zero, B	# if t1 == 0 jump
	add $a1, $zero, $s0	# move index-1 into $a2 register
	jal QSORT		# quick sort
	lw $a1, 4($sp)		# load $a1  back to orgional
	
B:	lw $a0, 0($sp)		# load $a0 
	lw $a1, 4($sp)		# load $a1 
	lw $a2, 8($sp)		# load $a2 
	lw $s0, 12($sp)		# load $s0 
	lw $ra, 16($sp)		# load $ra
	addi $sp, $sp, 20	# restore stack
	jr $ra
	
#==================================================================================

PART:	addi $sp, $sp, -12	# make room for 4 on stack
	sw $s0, 0($sp)		# store $s0 
	sw $s1, 4($sp)		# store $s1 
	sw $s2, 8($sp)		# store $s2  
	
	add $s0, $a1, $zero	# i = left
	add $s1, $a2, $zero	# j = right
	add $t0, $s0, $s1	# $t0 = left + right
	srl $t0, $t0, 1		# $t0 = (left + right)/2
	sll $t0, $t0, 2		# $t0 = (left + right)/2 *4
	add $t0, $t0, $a0	# addr arr[(left + right) / 2]
	lw $s2, 0($t0)		# pivot = arr[(left + right) / 2]
	
WHILE:	slt $t0, $s1, $s0	# i<=j	$s0<=$s1 !j<i
	bne $t0, $zero, RET	# if $t0 != 0 jump to else
ILOOP:	sll $t0, $s0, 2		# i*4
	add $t0, $t0, $a0	# addr arr[i]
	lw $t0, 0($t0)		# arr[i]
	slt $t0, $t0, $s2	# arr[i] < pivot 
	beq $t0, $zero, JLOOP	# if $t0 == 0 jump to else
	addi $s0, $s0, 1	# i++
	j ILOOP
	
JLOOP:	sll $t0, $s1, 2		# j*4
	add $t0, $t0, $a0	# addr arr[j]
	lw $t0, 0($t0)		# arr[j]
	slt $t0, $s2, $t0	# arr[j] > pivot = pivot < arr[j]
	beq $t0, $zero, IF	# if $t0 == 0 jump to else
	addi $s1, $s1, -1	# j--
	j JLOOP
	
IF:	slt $t0, $s1, $s0	# i<=j	$s1<=$s0 !j<i
	bne $t0, $zero, Z	# if $t0 != 0 jump to else
	sll $t0, $s0, 2		# i*4
	add $t0, $t0, $a0	# $t0=addr arr[i]
	lw $t1, 0($t0)		# $t1=arr[i]	
	sll $t2, $s1, 2		# j*4
	add $t2, $t2, $a0	# $t2=addr arr[j]
	lw $t3, 0($t2)		# $t3=arr[j]
	sw $t3, 0($t0)		# arr[i]=arr[j] or $t0=$t3
	sw $t1, 0($t2)		# arr[j]=$t2
	addi $s0, $s0, 1	# i++
	addi $s1, $s1, -1	# j--
Z:	j WHILE
RET:	add $v0, $s0, $zero	# return i
	lw $s0, 0($sp)		# store $s0 
	lw $s1, 4($sp)		# store $s1 
	lw $s2, 8($sp)		# store $s2 
	addi $sp, $sp, 12	# restore stack
	jr $ra

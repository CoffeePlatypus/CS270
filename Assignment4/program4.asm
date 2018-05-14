# Julia Froegel
	.data 
out1:	.asciiz "The elements sorted in ascending order are: " 		# Create a null-terminated string $s4
	.align 2
array:	.space 80			# make an arry of at most 20 		$s3
	.align 2
i:	.space 4			# index					$s1
size:	.space 4			# size of array				$s0
comma:	.asciiz ", "			#comma					$s5
	.align 2
#=================================================================================

	.text
MAIN:	
	# Insert main body
	addi $v0, $zero, 5		# set to read int
	syscall				# read size int
	add $s0, $v0, $zero		# move size to perminat register 
	
	la $s3, array			# load array adress
	addi $s1, $zero, 0		# i= 0
FOR:	slt $t0, $s1, $s0		# i<size
	beq $t0, $zero, ENDF		# if i<size == 0 end
	# read int
	addi $v0, $zero, 5		# get ready to read int
	syscall
	add $t0, $v0, $zero		# move read int to temp register
	# store int
	sll $t1, $s1, 2			# i*4
	add $t1, $s3, $t1		# addr A[i]
	sw $t0, 0($t1)			# A[i]= read int
	addi $s1, $s1, 1		#i++
	j FOR
ENDF:	add $a0, $s3, $zero		# load A into a0
	add $a1, $s0, $zero		# load length into a1
	
	jal SORT
	
	add $s3, $a0, $zero
	
	la $s4, out1			# load adress
	add $a0, $zero, $s4		# load to print
	addi $v0, $zero, 4		# put 4 in $v0 for printing a string
	syscall
	
	la $s5, comma 			#load adress
	
	addi $s1, $zero, 0		# i=0
PLOOP:	slt $t0, $s1, $s0		# i<size
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
	j PLOOP
	
END:
	addi $v0, $zero, 10		# set up to exit
	syscall 
	
#========================================================================

SORT:	addi $sp, $sp, -16		# 4 registers needed
	sw $s0, 0($sp)			# store $s0
	sw $s1, 4($sp)			# store $s1
	sw $s2, 8($sp)			# store $s2
	sw $s3, 12($sp)			# store $s3
	
	# start to sort
	addi $s0, $zero, 0		# i=0
	addi $t0, $a1, -1		# t0=len-1
LOOPO:	slt $t1, $s0, $t0		# t1=i<len
	beq $t1, $zero, RET		# t1==0 end
	add $s1, $s0, $zero		# minIndex=i
	addi $s2, $s1, 1		# j=i+1
	
LOOPIN:	slt $t1, $s2, $a1		# j<len
	beq $t1, $zero, L1		# j<len==0 end
	
	# get array stuff for first if
	sll $t1, $s1, 2			# t1= minIn*4
	add $t1, $t1, $a0		# t1= addr A[minIndex]
	lw $t2, 0($t1)			# t2= A[minIndex]
	
	sll $t3, $s2, 2			# t3= j*4
	add $t3, $t3, $a0		# t3= addr A[j]
	lw $t4, 0($t3)			# t4= A[j]
	
	slt $t5,$t4,$t2			# t2> t4 or t4< t2
	beq $t5, $zero, L		# t4<t2 
	add $s1, $s2, $zero		# minIndex=j
L:	addi $s2, $s2, 1		# j++
	j LOOPIN
L1:	beq $s1, $s0, LOO		# i!=minIndex
	
	sll $t3, $s0, 2			# t3= i*4
	add $t3, $t3, $a0		# t3= addr A[i]
	lw $t4, 0($t3)			# t4= A[i]
	sll $t1, $s1, 2			# t1= minIn*4
	add $t1, $t1, $a0		# t1= addr A[minIndex]
	lw $t2, 0($t1)			# t2= A[minIndex]
	#shuffle
	add $t5, $zero,$t2		# temp= A[minIndex]
	sw $t4, 0($t1)			# arr[minIndex]=arr[i]
	sw $t5, 0($t3)			# arr[i]=temp
LOO:	addi $s0, $s0, 1		# i++
	j LOOPO
RET:	
	#reset registers	
	lw $s0, 0($sp)			# $s0
	lw $s1, 4($sp)			# $s1
	lw $s2, 8($sp)			# $s2
	sw $s3, 12($sp)			# $s3
	addi $sp, $sp, 16		# 4 registers
	jr $ra
#========================================================================

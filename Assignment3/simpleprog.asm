
# Julia Froegel
	.data 
out1:	.asciiz "The array in reverse is: " 		# Create a null-terminated string 
	.align 2
out2:	.asciiz "The largest element is: " 		# Create a null-terminated string
	.align 2
out3:	.asciiz "Thank you and have a nice day!" 	# Create a null-terminated string
	.align 2
array:	.space 400	# $s3				# make an arry of at most 100
	.align 2
space:	.asciiz " "					# space to insert between numbers
comma:	.asciiz ", "	

i:	.space 4					# index
#max:	.space 4					# largest in array
size:	.space 4					# size of array
return:	.asciiz "\n"	
#=================================================================================
	.text
MAIN:
	
	addi $v0, $zero, 5		# set to read int
	syscall				# read size int
	add $s0, $v0, $zero		# move size to perminat register 
	
	addi $t3, $zero, 100
	slt $t3, $s0, $t3
	beq $t3, $zero, ENDA 
	beq $s0, $zero, ENDA
	
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
ENDF:	
	la $s4, out1			# load adress
	add $a0, $zero, $s4		# load to print
	addi $v0, $zero, 4		# put 4 in $v0 for printing a string
	syscall
	
	la $s4, space			# loads adress of space
	lw $s4, 0($s4)			# loads value of space into register
	
	la $s5, comma
	lb $s5, 0($s5)
	
	add $s1, $s0, $zero		# sets i to size +of array FIND THE SIZE
	add $s1, $s1, -1		# i=size-1
	
	sll $t1, $s1, 2			# i*4
	add $t1, $s3, $t1		# addr A[size-1]
	lw $t0, 0($t1)			# A[size-1]
	#max
	add $t5, $t0, $zero		# max=A[size-1];
	
LOOP:	slt $t0, $s1, $zero		# i>=0 or !i<0
	bne $t0, $zero, END		# if i<0 != 0 end
	
	sll $t1, $s1, 2			# i*4
	add $t1, $s3, $t1		# addr A[size-1]
	lw $t0, 0($t1)			# A[size-1]
	
	add $a0, $zero, $t0		# load to print last item
	addi $v0, $zero, 1		# put 4 in $v0 for print int
	syscall
	
	slt $t1, $t5, $t0		# max<addr[i] 
	beq $t1, $zero, ENDIF		# if (max<addr[i] != 0) end #thought bne
	add $t5, $t0, $zero		# max=addr[i]
ENDIF:
	
	addi $s1, $s1,-1		#i--
	slt $t0, $s1, $zero		# i>=0 or !i<0
	bne $t0, $zero, ELSE
	
	add $a0, $zero, $s5		# load space to print
	addi $v0, $zero, 11		# 11 to print char
	syscall
	add $a0, $zero, $s4		# load space to print
	addi $v0, $zero, 11		# 11 to print char
	syscall
	j LOOP
ELSE:
	la $s6, return			# loads adress of enter
	lb $s6, 0($s6)
	add $a0, $zero, $s6		# load space to print
	addi $v0, $zero, 11 		# 11 to print char
	syscall
	j END
END:	
	la $s4, out2			# load adress
	add $a0, $zero, $s4		# load to print
	addi $v0, $zero, 4		# put 4 in $v0 for printing a string
	syscall
	
	add $a0, $zero, $t5		# load to print last item
	addi $v0, $zero, 1		# put 4 in $v0 for print int
	syscall
	
	add $a0, $zero, $s6		# load space to print
	addi $v0, $zero, 11 		# 11 to print char
	syscall
	
ENDA:	
	la $s4, out3			# load adress
	add $a0, $zero, $s4		# load to print
	addi $v0, $zero, 4		# put 4 in $v0 for printing a string
	syscall

	addi $v0, $zero, 10		# set up to exit
	syscall 

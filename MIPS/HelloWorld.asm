# MIPS HELLO WORLD
# Julia Froegel
	.data 
hi:	.asciiz "Hello World!\n" 	# Create a null-terminated string "Hello World"
	.align 2			# align data segments after each string	
num:	.word 5				# reserve space for a number and initilize it to 5
i:	.space 4			# counter variable
space:	.asciiz " "			# space to insert between numbers

# end of data segments

#================================================================================================

# begin text segment
	.text 				# Instructions Start
MAIN:	la $s0, hi			# Load adresss of string hi
	add $a0, $zero, $s0		# pust adress of hi in $a0 to print
	addi $v0, $zero,4		# put 4 in $v0 for printing a string
	syscall				# print
	la $s1, num			# load adresses of num for use
	lw $s1, 0($s1)			# load  value of num into regiser
	la $s2, space			# load adressof space for use
	lw $s2, 0($s2)			# load value of space into register
	addi $s3, $zero, 0		# set 1=0
LOOP:	slt $t0, $s3, $s1		# i<num
	beq $t0, $zero, END		# go to end when done
	add $a0, $zero, $s3		# put i in $a0 to print
	addi $v0, $zero, 1		# set to print an int
	syscall				# print int
	add $a0, $zero, $s2		# put space in $a0
	add $v0, $zero, 11		# set up to print a char
	syscall				# print char
	addi $s3, $s3, 1		# i++
	j LOOP				# LOOP de LPOOP
END:	addi $v0, $zero, 10		# set up to exit
	syscall 

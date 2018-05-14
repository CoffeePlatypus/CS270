# MIPS HELLO WORLD
# Julia Froegel
	.data 
hi:	.asciiz "Progam 2\n" 	# Create a null-terminated string "Hello World"
	.align 2			# align data segments after each string	
sum:	.word 0				# reserve space for a number and initilize it to 0

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
	la $s1, sum			# load adresses of num for use
	lw $s1, 0($s1)			# load  value of num into regiser
	la $s2, space			# load adressof space for use
	lw $s2, 0($s2)			# load value of space into register
	addi $s3, $zero, 0		# set 1=0
	addi $t1, $zero, 10
LOOP:	slt $t0, $t1, $s1		# i<
	beq $t0, $zero, END		# go to end when done
	add $s1, $s1, $s3		# sum= sum+i
	add $a0, $zero, $s1		# put i in $a0 to print
	addi $v0, $zero, 1		# set to print an int
	syscall				# print int
	add $a0, $zero, $s2		# put space in $a0
	add $v0, $zero, 11		# set up to print a char
	syscall				# print char
	addi $s3, $s3, 1		# i++
	j LOOP				# LOOP de LPOOP
END:	addi $v0, $zero, 10		# set up to exit
	syscall 
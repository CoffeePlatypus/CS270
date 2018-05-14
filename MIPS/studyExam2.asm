# Julia Froegel
	.data 
out1:	.asciiz "insert text " 		# Create a null-terminated string 
	.align 2
i:	.space 4			# index
#=================================================================================

	.text
MAIN:	
	# Insert main body
	
	
	
	addi $v0, $zero, 10		# set up to exit
	syscall 
#====================================================================================

ISPAL:	addi $sp, $sp, -16	# make room on the stack to store $a0-$a2 and $ra
	sw $a0, 0($sp) 		# store $a0 str
	sw $a1, 4($sp)		# store $a1 s
	sw $a2, 8($sp)		# store $a2 e
	sw $ra, 12($sp)		# store return address
	
	slt $t0, $a1, $a2	# !(s<e)
	bne $t0, $zero, A	# if e<s then jump to else
	addi $v0, $zero, 1	# return 1
	j REIPAL		# jump to return
	
A:	addi $t0, $a0, $a1	# t0=str[s] addr
	addi $t1, $a0, $a2	# t1=str[e] addr
	lb $t0, 0($t0)		# t0=str[s]
	lb $t1, 0($t1)		# t1=str[s]
	beq $t0, $t1, B		# if equal jump to else
	addi $v0, $zero, 0	# return 0
	j REIPAL		# jump to return
	
B:	addi $a1, $a1, 1	# a1= a1+1
	addi $a2, $a2, -1	# a2=a2-1
	jal ISPAL
	# v0 will be set to return value
	
REIPAL:	
	lw $a0, 0($sp) 		# load $a0 str
	lw $a1, 4($sp)		# load $a1 s
	lw $a2, 8($sp)		# load $a2 e
	lw $ra, 12($sp)		# load return address
	addi $sp, $sp, 16	# restor stack pointer 
	jr $ra
	
#================================================================

BINSE:	addi $sp, $sp, -24	# make room in stack
	sw $s0, 0($sp)		# store $s0
	sw $a0, 4($sp)		# store $a0	data
	sw $a1, 8($sp)		# store $a1	toFind
	sw $a2, 12($sp)		# store $a2	start
	sw $a3, 16($sp)		# store $a3	end
	sw $ra, 20($sp)		# store $ra
	
	sub $t0, $a3, $a2	# t1=a3-a2
	srl $t0, $t0, 1		# t1=t1/2
	add $s0, $a2, $t0	# start-t1    mid
	
	slt $t0, $a3, $a2	# end<start
	bne $t0, $zero, C	# if end<start==0 then jump to else # I had this different should beq not bne
	addi $v0, $zero, -1	#return -1
	j BINRE
	
C:	sll $t0, $s0, 2		# mid*4
	add $t0, $t0, $a0	# addr data[mid]
	lw $t0, 0($t0)		# t0= data[mid]
	bne $t0, $a1 D		# if data[mid]!=toFind jump to else  # why does she say $a3 and not $a1
	add $v0, $t0, $zero	# return mid
	j BINRE
	
D:	slt $t1, $a1, $t0	# t1= toFind<data[mid]
	beq $t1, $zero, E	# if toFind<data[mid] == 0 then jump to else
	addi $a3, $s0, -1 	# end = mid-1
	jal BINSE
	j BINRE			# jump to return
	
E:	addi $a2, $s0, 1	# start= mid+1
	jal BINSE		
	
BINSE:	lw $s0, 0($sp)		# load $s0
	lw $a0, 4($sp)		# load $a0	data
	lw $a1, 8($sp)		# load $a1	toFind
	lw $a2, 12($sp)		# load $a2	start
	lw $a3, 16($sp)		# load $a3	end
	lw $ra, 20($sp)		# load $ra
	addi $sp, $sp, 24	# restore stack
	jr $ra
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
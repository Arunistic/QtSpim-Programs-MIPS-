.data
prompt: .asciiz "The (n)th and (n+1)th numbers in fibinnaci series is: "
newline: .asciiz "\n"
num1: .word 0
num2: .word 1
n: .word 5

.text
.globl main
main:
	li $v0, 4
	la $a0, prompt
	syscall
	
	jal fibonacci_series
	
	li $v0, 10
	syscall
	
fibonacci_series:
	lw $t0, num1
	lw $t1, num2
	li $t5, 0       #start index
	
	lw $t6, n       # size (0 to n)
	
fibonacci_loop:
	beq $t5, $t6, print
	add $t3, $t0, $t1
	move $t0, $t1
	move $t1, $t3
	addi $t5, $t5, 1
	j fibonacci_loop
	
print:
	li $v0, 4
	la $a0, newline
	syscall	
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall	
	
	li $v0, 1
	move $a0, $t1
	syscall

    li $v0, 10
    syscall

	
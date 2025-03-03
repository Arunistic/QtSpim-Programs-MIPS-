.data
    newline: .asciiz "\n"
.text
.globl main
main:
    li $a0, 10              # Load Fibonacci number to calculate (n=10)
    jal fib_rec             # Call Fibonacci recursive function
    move $t2, $v0           # Store the result of fib(10) in $t2

    # Now calculate fib(n-1)
    li $a0, 9               # Load Fibonacci number to calculate (n-1=9)
    jal fib_rec             # Call Fibonacci recursive function
    move $t3, $v0           # Store the result of fib(9) in $t3

    # Print the result for fib(n)
    li $v0, 1               # Print integer syscall
    move $a0, $t2           # Move the Fibonacci result into $a0
    syscall

    # Print space
    li $v0, 11              # Print character syscall
    li $a0, 32              # ASCII code for space
    syscall

    # Print the second Fibonacci number (for fib(n-1))
    move $a0, $t3           # Load fib(9) result into $a0
    li $v0, 1               # Print integer syscall
    syscall

    # Print a newline
    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 10              # Exit syscall
    syscall

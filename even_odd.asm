.data
    nums: .word 1, 17, 2, 23, 9, 4, 14
    size: .word 7
    line: .asciiz "\n" 
    comma: .ascii ","
.text
.globl main
main:
    la $t7, size
    lw $t2, 0($t7)
    la $t1, nums

even_loop:
    lw $t3, 0($t1)
    andi $t5, $t3, 1
    beqz $t5, print_even
    j skip_even

print_even:
    li $v0, 1
    move $a0, $t3  
    syscall 

    li $v0, 4
    la $a0, comma  
    syscall

skip_even:
    addi $t1, $t1, 4   
    sub $t2, $t2, 1   
    bnez $t2, even_loop

    lw $t2, 0($t7)
    la $t1, nums
odd_loop:
    lw $t3, 0($t1)
    andi $t5, $t3, 1
    bnez $t5, print_odd
    j skip_odd

print_odd:
    li $v0, 1
    move $a0, $t3  
    syscall 

    li $v0, 4
    la $a0, comma  
    syscall

skip_odd:
    addi $t1, $t1, 4   
    sub $t2, $t2, 1   
    bnez $t2, odd_loop

end:
    li $v0, 10
    syscall
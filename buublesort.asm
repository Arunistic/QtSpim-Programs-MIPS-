.data
    arr: .word 5, 10, 3, 2, 13, 7, 6, 4
    space: .ascii " "
.text
.globl main
main:
    la $s0, arr
    li $s1, 8 #size no of times outerloop

outer_loop:
    la $s0, arr
    li $t1, 0 #for innerloop
    inner_loop:
        lw $s3, 0($s0)         ## Load current element
        lw $s4, 4($s0)         ## Load next element

        # Compare and swap if needed
        slt $t2, $s4, $s3          # $t2 = 1 if $s4 < $s3
        beq $t2, $zero, skip_swap  # Skip swap if $s4 >= $s3

        sw $s4, 0($s0)         ##
        sw $s3, 4($s0)         ##
        
    skip_swap:
        addi $s0, $s0, 4        # Move pointer to the next element
        addi $t1, $t1, 1        # Increment inner loop counter
        bne $t1, $s1, inner_loop 

    addi $s1, $s1, -1           # counter for outerloop
    bne $0, $s1, outer_loop    

    la $s0, arr
    li $t0, 8
print_loop:
    lw $a0, 0($s0)
    li $v0, 1
    syscall

    li $v0, 4 
    la $a0, space
    syscall

    addi $s0, $s0, 4
    addi $t0, $t0, -1
    bne $t0, $0, print_loop

end:
    li $v0, 10
    syscall

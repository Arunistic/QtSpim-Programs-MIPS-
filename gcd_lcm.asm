.data
    num1: .word 20
    num2: .word 15
.text
.globl main
main:
    la $t0, num1
    lw $t1, 0($t0)
    la $t0, num2
    lw $t2, 0($t0)
    
    # for lcm
    move $t3, $t1
    move $t4, $t2

gcd_loop:
    beq $t2, $0, gcd_found
    div $t1, $t2
    mfhi $t5
    move $t1, $t2
    move $t2, $t5
    j gcd_loop

gcd_found:
    addi $v0, $0, 1
    add $a0, $t1, $0
    syscall



lcm:
    mul $t6, $t3, $t4
    div $t6, $t1
    mflo $t7

lcm_found:
    addi $v0, $0, 1
    add $a0, $0, $t7
    syscall

end:
    addi $v0, $0, 10
    syscall


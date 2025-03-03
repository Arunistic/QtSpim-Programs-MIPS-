.data
    
.text
.globl main
main:
    li $v0, 5
    syscall
    move $t0, $v0
    li $t7, 0
    
loop:
    andi $t2, $t0, 1
    add $t7, $t7, $t2
    srl $t0, $t0, 1
    bnez $t0, loop

    li $v0, 1
    add $a0, $t7, $0
    syscall

    li $v0, 10
    syscall



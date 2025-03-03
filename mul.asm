.data 
Num1: .word 50
Num2: .word 60

.text
.globl main

main:
    la $t5, Num1
    lw $t1, 0($t5)
    la $t5, Num2 
    lw $t2, 0($t5)

    mult $t2,$t1
    mflo $t4
    mfhi $t5

    move $a0,$t5
    addi $v0,$0,1
    syscall


    move $a0,$t4
    addi $v0,$0,1
    syscall

    addi $v0, $0, 10
    syscall

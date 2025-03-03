.data
    num: .word 21345
.text
.globl main
main:
    li $v0, 5
    syscall
    move $t2, $v0

    li $t1, 0
loop:
    beqz $t2, finish
    div $t2, $t2, 10
    mfhi $t3
    add $t1, $t1, $t3
    j loop
finish:
    li $v0, 1
    add $a0, $t1, $0
    syscall

    li $v0, 10
    syscall
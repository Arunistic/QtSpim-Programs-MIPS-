.data
    arr: .asciiz "adnda"
    len: .word 5
    pok: .asciiz "is pal"
    pnok: .asciiz "is not pal"
.text
.globl main
main:
    la $t0, len
    lw $a0, 0($t0)
    la $a1, arr           # $a1 is like start pointer
    jal ispal

    beq $v0, $0, printnotok
    jal printok

printok:
    li $v0, 4
    la $a0, pok
    syscall
    j end

printnotok:
    li $v0, 4
    la $a0, pnok
    syscall
    j end

ispal:
    slti $t1, $a0, 2
    bne $0, $t1, ok       # branch if $a0<2

    lb $t1, 0($a1)        # start character
    addi $t2, $a0, -1
    add $t2, $t2, $a1
    lb $t3, 0($t2)        # $a1 + $a0 - 1 mirror char

    bne $t1, $t3, nok     # branch if chars r not eq

    addi $a0, $a0, -2
    addi $a1, $a1, 1
    j ispal

ok: 
    li $v0, 1
    jr $ra 

nok:
    li $v0, 0
    jr $ra

end:
    li $v0, 10
    syscall

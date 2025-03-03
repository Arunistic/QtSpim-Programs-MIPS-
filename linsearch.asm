.data
    arr: .word 9, 2, 12, 45, 77, 23, 10
    no: .asciiz "Not found"
    yes: .asciiz "Found"
.text
.globl main
main:

    li $v0, 5
    syscall
    move $t0, $v0       #target

    la $s0, arr
    li $t2, 7
loop:
    beqz $t2, not_found
    lw $t3, 0($s0)
    beq $t0, $t3, found
    addi $t2, $t2, -1
    addi $s0, $s0, 4
    j loop

not_found:
    li $v0, 4
    la $a0, no
    syscall

end:
    li $v0, 10
    syscall

found:
    li $v0, 4
    la $a0, yes
    syscall
    j end


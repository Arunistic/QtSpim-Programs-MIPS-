.data
    array: .word 2, 4, 7, 10, 15, 20, 25, 30, 35  # A sorted array
    size: .word 9                                # Size of the array
    target: .word 7                            # Target value to search for
    found_msg: .asciiz "Value found.\n"
    not_found_msg: .asciiz "Value not found.\n"
    newline: .asciiz "\n"

.text
.globl main
main:
    # Load array base address and size
    la $t0, array           # $t0 = base address of the array
    lw $t1, size            # $t1 = size of the array
    lw $t2, target          # $t2 = target value to search for

    # Initialize binary search bounds
    li $t3, 0               # $t3 = left index (0)
    add $t4, $t1, -1        # $t4 = right index (size - 1)

binary_search:
    ble $t3, $t4, continue_search  # Check if left index <= right index
    j not_found                    # If not, jump to not_found

continue_search:
    # Calculate mid index: mid = (left + right) / 2
    add $t5, $t3, $t4              # $t5 = left + right
    sra $t5, $t5, 1                # $t5 = mid index (division by 2)

    # Load array[mid] into $t6
    sll $t7, $t5, 2                # $t7 = mid * 4 (word offset)
    add $t7, $t0, $t7              # $t7 = address of array[mid]
    lw $t6, 0($t7)                 # $t6 = array[mid]

    # Compare array[mid] with target
    beq $t6, $t2, found            # If array[mid] == target, jump to found
    blt $t6, $t2, move_right       # If array[mid] < target, search right
    bgt $t6, $t2, move_left        # If array[mid] > target, search left

move_right:
    addi $t3, $t5, 1               # Update left index to mid + 1
    j binary_search                # Jump back to binary_search

move_left:
    addi $t4, $t5, -1              # Update right index to mid - 1
    j binary_search                # Jump back to binary_search

found:
    li $v0, 4                      # Print string syscall
    la $a0, found_msg              # Load address of "Value found."
    syscall
    j end                          # Jump to end

not_found:
    li $v0, 4                      # Print string syscall
    la $a0, not_found_msg          # Load address of "Value not found."
    syscall

end:
    li $v0, 10                     # Exit syscall
    syscall

.data
input: .space 32                 # Space to store the input string
error_msg: .asciiz "Invalid character in hexadecimal number.\n"
prompt: .asciiz "Enter a hexadecimal number (without 0x): "
result_msg: .asciiz "\nDecimal equivalent: "

.text
.globl main
main:
    # Print the prompt message
    li $v0, 4
    la $a0, prompt
    syscall

    # Read the input string
    li $v0, 8
    la $a0, input
    li $a1, 32                   # Maximum input length
    syscall

    # Initialize pointers and result
    la $t0, input                # $t0 points to the input string
    li $t1, 0                    # $t1 stores the decimal result

convert_loop:
    lb $t3, 0($t0)               # Load the current character
    beqz $t3, done               # If null terminator, end loop

    # Check if character is '0'-'9'
    li $t4, 48                   # ASCII value of '0'
    li $t5, 57                   # ASCII value of '9'
    blt $t3, $t4, error          # If char < '0', error
    bgt $t3, $t5, check_alpha    # If char > '9', check if it's a letter

    sub $t3, $t3, 48             # Convert '0'-'9' to 0-9
    j process_digit

check_alpha:
    li $t6, 65                   # ASCII value of 'A'
    li $t7, 70                   # ASCII value of 'F'
    blt $t3, $t6, error          # If char < 'A', error
    bgt $t3, $t7, error          # If char > 'F', error

    sub $t3, $t3, 55             # Convert 'A'-'F' to 10-15

process_digit:
    mul $t1, $t1, 16             # Multiply result by 16
    add $t1, $t1, $t3            # Add current digit value

    addi $t0, $t0, 1             # Move to the next character
    j convert_loop               # Repeat the loop

done:
    # Print the result message
    li $v0, 4
    la $a0, result_msg
    syscall

    # Print the decimal result
    move $a0, $t1
    li $v0, 1
    syscall

exit:
    # Exit the program
    li $v0, 10
    syscall


error:
    # Print the error message
    li $v0, 4
    la $a0, error_msg
    syscall
    j exit                      # Exit after showing the error

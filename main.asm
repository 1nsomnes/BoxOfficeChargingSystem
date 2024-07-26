
.text 
main:
    # Prompt for the number of adults
    li $v0, 4
    la $a0, prompt1
    syscall
    # Read the integer and save it in $s0
    li $v0, 5
    syscall
    move $s0, $v0

    # Prompt for the number of minors
    li $v0, 4
    la $a0, prompt2
    syscall
    # Read the integer and save it in $s1
    li $v0, 5
    syscall
    move $s1, $v0

    # subtract number of minors (to get number of adults)
    sub $s0, $s0, $s1
    li $t0, 1
    slt $t0, $s0, $t0
    bne $t0, $zero, minorError

end: 
    # Exit the program
    li $v0, 10
    syscall

minorError:
    # Prompt for the number of minors
    li $v0, 4
    la $a0, minorErrorMessage
    syscall

    li $v0, 10
    j end


.data
# prompts 
prompt1: .asciiz "\n\nWelcome to the concert ticket system! \n\nPlease enter the number of tickets needed: "
prompt2: .asciiz "\nHow many of those tickets are for a minor (under the age of 18):"
prompt3: .asciiz "\nHow many of those tickets are for seniors (over the age of 65):"

# errors
minorErrorMessage: .asciiz "\nSorry but all minors must be accompanied by one adult."

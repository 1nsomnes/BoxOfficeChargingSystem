##
## Cedric Claessens
## CSC 230
##
## The purpose of this program is to manage ticketing system. Where 
## there are seperate prices for seniors, minors, and regular adults.
## The program will take in the total amount in each group and calculate 
## the total cost of the tickets. 

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

    # check that there is at least one adult
    li $t0, 1
    slt $t1, $s0, $t0
    beq $t0, $t1, adultCountError

    # check that more than 100 tickets aren't being ordered so we never have to worry about overflowing integers
    li $t0, 101
    slt $t1, $s0, $t0
    beq $zero, $t1, notMoreThan100Error

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

    # Prompt for the number of seniors
    li $v0, 4
    la $a0, prompt3
    syscall
    # Read the integer and save it in $s2
    li $v0, 5
    syscall
    move $s2, $v0

    # subtract number of seniors (to get number of adults who are not seniors)
    sub $s0, $s0, $s2
    slt $t0, $s0, $zero
    bne $t0, $zero, morePeopleThanListedError

    #calculate totals
    li $t0, 20
    mul $s0, $s0, $t0 # total for regular tickets
    li $t0, 18
    mul $s1, $s1, $t0 # total for minor tickets
    li $t0, 17
    mul $s2, $s2, $t0 # total for senior tickets

    #sum all the tickets
    add $s0, $s0, $s1
    add $s0, $s0, $s2

    # print the total cost
    li $v0, 4
    la $a0, totalCost
    syscall

    li $v0, 1
    move $a0, $s0
    syscall


    

end: 
    # Exit the program
    li $v0, 10
    syscall

minorError:
    # Prompt for the number of minors
    li $v0, 4
    la $a0, minorErrorMessage
    syscall

    li $v0, 10 # the following line doesn't work on my macbook if I don't put this line here idk why...
    j end

adultCountError:
    li $v0, 4
    la $a0, adultCountErrorMessage
    syscall

    li $v0, 10
    j end

morePeopleThanListedError:
    li $v0, 4
    la $a0, morePeopleThanListedErrorMessage
    syscall

    li $v0, 10
    j end

notMoreThan100Error:
    li $v0, 4
    la $a0, notMoreThan100ErrorMesssage
    syscall

    li $v0, 10
    j end


.data
# prompts 
prompt1: .asciiz "\n\nWelcome to the concert ticket system! \n\nPlease enter the number of people in the party: "
prompt2: .asciiz "\nHow many of those tickets are for a minor (under the age of 18):"
prompt3: .asciiz "\nHow many of those tickets are for seniors (over the age of 65):"

# messages
totalCost: .asciiz "\nThe total cost for those tickets is: $"

# errors
minorErrorMessage: .asciiz "\nSorry but all minors must be accompanied by one adult."
adultCountErrorMessage: .asciiz "\nSorry the number of adults must be at least one."
morePeopleThanListedErrorMessage: .asciiz "\nSorry you have listed too many people."
notMoreThan100ErrorMesssage: .asciiz "\nSorry but one order cannot have more than 100 tickets."


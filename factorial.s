#PURPOSE - Given a number this program computes the factorial.
#          For example the factorial of 3 is 3 * 2 * 1 or 6 and the 
#          Factorial of 4 is 4 * 3 * 2 * 1 or 24 and so on.

#This porgram shows how to call function recursively

.section .data

#This program has no global data

.section .text

.globl _start
.globl factorial #This allows the function to be shared among programs

_start:
    pushl $4 # the factorial takes one argument the number we want a 
             #a factorial of so it gets pushed
    call factorial #run the factorial function
    addl $4, %esp #scrubs the parameter that was pushed on the stack
    movl %eax, %ebx #factorial returns in %eax but we want it in %ebx
                    # to send it as our exit code
    movl $1, %eax #call the kernal's exit function
    int $0x80 

#This is the actual function definition
.type factorial,@function
factorial:
    pushl %ebp #restore %ebp to it's prior state
    movl %esp, %ebp #we don't want to modify the stack pointer so we use
                    #%ebp
    movl 8(%ebp), %eax #moves the first argument to %eax
                       #4(%ebp) holds the return address and 
                       #8(%ebp) holds the first parameter
    cmpl $1, %eax # if the number is 1 then we return 1
    je end_factorial
    decl %eax       #otherwise decrease the value
    pushl %eax #push it for our call to factorial
    call factorial #calls factorial this is recursive 
    movl 8(%ebp), %ebx #%eax holds the return value so we reload our
                       #parameter into %ebx
    imull %ebx, %eax #multiply that by the result of our lass call of 
                     #factorial
    end_factorial:
        movl %ebp, %esp
        popl %ebp
        ret #return our function and restore our registers to where they
            #were
    

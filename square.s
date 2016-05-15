#Purpose: The purpose of this program is to find the square of a number

.section .data
#no universal data

.section .text

.globl _start
_start:
    push $5 #we start wanting only one number
    call square
    movl %eax, %ebx
    movl $1, %eax
    int $0x80

.type square, @function
square:
    mov 4(%esp), %eax #read the value to square from the stack pointer
    imul %eax, %eax #multiply the vlaue and store it in %eax
    ret #return the value

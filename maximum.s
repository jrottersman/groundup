#PURPOSE: Find the the maximum number of a set of data items
#
#VARIABLES: The registers have the following uses:
#
#%edi- holds the index of the item being examined
#%ecx - holds the length of a loop
#%ebx Largest item found
#%eax current item
#data_items - contains the item data. A 0 is used to terminate the data

.section .data

data_items:
.long 3,67,34,222,45,75,54,34,44,33,22,11,66

.section .text

.globl _start
_start:
 movl $0, %edi #move 0 into the index register
 movl $12, %ecx
 movl data_items(,%edi,4), %eax # load the first byte of data
 movl %eax, %ebx #since this is the first item %eax is the biggest

 start_loop:    #start loop
 cmpl data_items(,%ecx,4), %eax #check to see if we've hit the end
 je loop_exit
 incl %edi #load the next value
 movl data_items(,%edi,4), %eax
 cmpl %ebx, %eax #compare values
 jle start_loop # jump to loop beginning if the new one isn't bigger
 movl %eax, %ebx #move the value as the largest

 jmp start_loop #jump to the beginning of the loop

 loop_exit:
  # %ebx is the status code for the exit system call and it has the max
  #number
  movl $1, %eax #1 is the exit() syscall
  int $0x80

@ Main function 

  .text
  .align  4
  .global main
  .type main, %function

main:
  ldr r0, =scanfstring
  ldr r1, =res
  ldr r2, =res2
  bl  myscanf
  ldr r0, =mystring
  ldr r2, =res
  ldr r2, [r2]
  ldr r3, =res2
  ldr r3, [r3]
  bl  myprintf
  mov r0, #0
__mainend:
  mov r7, #1
  svc 0

  .data
  .align  4
mystring:
  .asciz "%llu is the number that myscanf returned\n"
scanfstring:
  .asciz "%Ld"
res:
  .word 0
res2:
  .word 0

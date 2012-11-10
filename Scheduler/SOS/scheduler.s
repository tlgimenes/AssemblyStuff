@ this file contains the implementation for the 
@ scheduler using round robin

  .text
  .global scheduler
        
scheduler:
  stmfd sp!, {r0-r12, lr}
  mov   r0, sp
  bl    _salva_contexto
  ldmfd sp!, {r0-r12, lr}


_save_context:
  ldr r1, =usr_registers
  ldr r2, =svc_registers
  ldr r3, =current_pid
  ldr r3, [r3]
  ldr r1, [r1, r3] @ r1 = apontador para o vetor de registers do user
  ldr r2, [r2, r3] @ r2 = apontador para o veotr de registers do supervisor
  eor r4, r4, r4   @ contador

__laco_save_usr_registers:      
  ldr r5, [r0], #4
  str r5, [r1], #4 @ grava r0-r12 no vetor de registers de user
  str r5, [r2], #4 @ grava r0-r12 no vetor de registers de supervisor
  add r4, r4, #1
  cmp r4, #13
  blt __laco_save_usr_registers

  msr cpsr_c, #0xd3 @ muda para o modo supervisor, desabilitando interrupcoes
  

  mov pc, lr
  
        
@-----------------------------------@
@                                   @
@            variaveis              @
@                                   @
@-----------------------------------@

  .data
        
current_pid: @ variavel local (global somente para o escalonador)
  .word 0  @ contem o PID-1 do processo que esta sendo executado
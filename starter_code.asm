.orig x3000
;this stack lab computes the polish notation of a set of calls
LD R6, STACK_ADDR

;push_val(4) pushes the value 4 onto the stack [4]
LD R1, push_valAdd
ADD R2, R2, #4
JSRR R1


;push_val(3) pushes the value 3 onto the stack [4,3]
LD R1, push_valAdd
AND R2, R2, #0
ADD R2, R2, #3
JSRR R1

;push_val(2) pushes the value 2 onto the stack [4,3,2]
LD R1, push_valAdd
AND R2, R2, #0
ADD R2, R2, #2
JSRR R1


;add_val() pop 3,2 and push the result of 3+2 onto the stack [4,5]
LD R1, add_valAdd
JSRR R1


;add_val() pop 4,5 and push the result of 4+5 onto the stack[9]
LD R1, add_valAdd
JSRR R1

;move the top value of the stack into r4
DO_WHILE_LOOP3
        AND R4, R4, #0
        LDR R4, R6, #0
        ADD R4, R4, #0
        
        BRnp END_WHILE3
        
        ADD R6, R6, #1
        BRnzp DO_WHILE_LOOP3
    END_WHILE3
    
    
HALT

STACK_ADDR .FILL x4200
push_valAdd .FILL x3400
add_valAdd .FILL x3800
ASCII .FILL x30

.end


.orig x3400 ;;push_val(int val)implement your push function that will push a value onto the stack
push_val
;restore R4, R3, R7
    
    ST R3, backup_R3_3400
    ST R4, backup_R4_3400
    ST R7, backup_R7_3400

    AND R4, R4, #0
    LD R3, stack_pointer
    ADD R3, R3, #9
    
    DO_WHILE_LOOP
    
       LDR R4, R3, #0
       ADD R4, R4, #0
       
       BRz CONTINUE
       
       ADD R3, R3, #-1
       
       BRnzp DO_WHILE_LOOP
    END_WHILE
      
      CONTINUE
        STR R2, R3, #0
        
    LD R3, backup_R3_3400
    LD R4, backup_R4_3400
    LD R7, backup_R7_3400
    
    RET
        
;local data 
stack_pointer .FILL x4200
backup_R2_3400    .BLKW  #1
backup_R3_3400    .BLKW  #1
backup_R4_3400    .BLKW  #1
backup_R7_3400    .BLKW  #1
.end
.orig x3800 ;; add_val() pops two values from the top of the stack and pushes the result of adding the poppped value into the stack
add_val;R1, R2, R3, R4, R5, R7

    ST R1, backup_R1_3800 
    ST R2, backup_R2_3800 
    ST R3, backup_R3_3800 
    ST R4, backup_R4_3800 
    ST R5, backup_R5_3800 
    ST R7, backup_R7_3800 
    
       
    LD R3,stack_p
    AND R5, R5, #0
    
    DO_WHILE_LOOP2
        AND R4, R4, #0
        LDR R4, R3, #0
        ADD R4, R4, #0
        
        BRnp CONTINUE2
        
        ADD R3, R3, #1
        BRnzp DO_WHILE_LOOP2
    END_WHILE2
     
     CONTINUE2
        AND R2, R2, #0
        ADD R2, R3, #1
        
        AND R7, R7, #0
        LDR R7, R2, #0
       
        AND R1, R1, #0
        ADD R1, R7, R4
        
        STR R5, R3, #0
        STR R1, R2, #0
        
    LD R1, backup_R1_3800 
    LD R2, backup_R2_3800 
    LD R3, backup_R3_3800 
    LD R4, backup_R4_3800 
    LD R5, backup_R5_3800 
    LD R7, backup_R7_3800 

    RET
;local data 
stack_p .FILL x4200
backup_R1_3800    .BLKW  #1
backup_R2_3800    .BLKW  #1
backup_R3_3800    .BLKW  #1
backup_R4_3800    .BLKW  #1
backup_R5_3800    .BLKW  #1
backup_R7_3800    .BLKW  #1

.end



.orig x4200 ;;data you might need

 STACK .BLKW #10
  
;local data 
.end



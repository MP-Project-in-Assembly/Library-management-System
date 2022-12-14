.MODEL SMALL
 
.STACK 100H
 
.DATA
     BEGIN DB 0DH,0AH,'   ------------------------------------------$'
     G1 DB 0DH,0AH,   '   -- WELCOME TO LIBRARY MANAGMENT SYSTEM -- $' 
     G2 DB 0DH,0AH,   '   ------------------------------------------$'
     G3 DB 0DH,0AH,   '   1->Register a member$'
     G4 DB 0DH,0AH,   '   2->view Members$'
     G5 DW 0DH,0AH,   '   3->Add Book$'
     G6 DW 0DH,0AH,   '   4->Remove Book$'
     G7 DW 0DH,0AH,   '   5->View Books$'
     G8 DW 0DH,0AH,   '   6->Exit program$'
     G9 DW 0DH,0AH,  'Choose Your Option: '
     NL DB 0DH,0AH,   '$'
     
     
.code
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX 
        
        LEA DX,BEGIN    ;PRINTING STRING
        MOV AH,9      
        INT 21H
        
        LEA DX,G1    ;PRINTING STRING
        MOV AH,9      
        INT 21H
                 
        LEA DX,G2    ;PRINTING STRING
        MOV AH,9      
        INT 21H
        
        LEA DX,G3    ;PRINTING STRING
        MOV AH,9      
        INT 21H
        
        LEA DX,G4    ;PRINTING STRING
        MOV AH,9      
        INT 21H 
        
        LEA DX,G5    ;PRINTING STRING
        MOV AH,9      
        INT 21H
        
        LEA DX,G6    ;PRINTING STRING
        MOV AH,9      
        INT 21H
        
        LEA DX,G7    ;PRINTING STRING
        MOV AH,9      
        INT 21H 
        
        LEA DX,G8    ;PRINTING STRING
        MOV AH,9      
        INT 21H
        
        LEA DX,G9    ;PRINTING STRING
        MOV AH,9      
        INT 21H
        
        MOV AH,1          ;TAKING INPUT
        INT 21H  
        
        CMP AL,31H
        JE REGISTER
        
        CMP AL,32H
        JE VIEWMEMBER
        
        CMP AL,33H
        JE ADDBOOK
        
        CMP AL,34H
        JE REMOVEBOOK
        
        CMP AL,35H
        JE VIEWBOOK
        
        CMP AL,36H
        JE EXIT
        
        JNE MAIN

        
    MAIN ENDP  
REGISTER: MOV DL,'1'
          JMP BOT

VIEWMEMBER: MOV DL,'2'
            JMP BOT

ADDBOOK: MOV DL,'3'
         JMP BOT

REMOVEBOOK: MOV DL,'4'
     JMP BOT

VIEWBOOK: MOV DL,'5'
     JMP BOT

EXIT:  MOV DL,'6'
     JMP BOT
             
BOT: MOV AH,2
     INT 21H 
     
.EXIT
END  
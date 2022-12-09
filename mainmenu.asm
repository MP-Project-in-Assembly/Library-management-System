.MODEL SMALL
.DATA
TABLE: DW ADDNUM
       DW DISPLAY
       DW EXIT
       DW MODIFY
       DW SEARCH
       DW DELETE

.CODE
.STARTUP
TOP: MOV AH,1
     INT 21H
     SUB AL,31
     JB TOP
     CMP AL,5
     JA TOP
     MOV AX,0
     ADD AX,AX
     LEA SI,TABLE
     ADD SI,AX
     MOV AX,[SI]
     JMP AX
ADDNUM: MOV DL,'1'
     JMP BOT
DISPLAY: MOV DL,'2'
     JMP BOT 
EXIT: MOV DL,'3'
       JMP BOT 
MODIFY: MOV DL,'4'
       JMP BOT 
SEARCH: MOV DL,'5'
       JMP BOT
DELETE: MOV DL,'6'
       JMP BOT
BOT: MOV AH,2
     INT 21H
.EXIT
END








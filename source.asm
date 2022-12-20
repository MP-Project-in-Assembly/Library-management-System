.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode: DWORD
INCLUDE Irvine32.inc

.data

xWall BYTE 52 DUP("#"),0

strScore BYTE "Your score is: ",0
score BYTE 0

strTryAgain BYTE "Try Again?  1=yes, 0=no",0
invalidInput BYTE "invalid input",0
strYouDied BYTE "you died ",0
strPoints BYTE " point(s)",0
blank BYTE "                                     ",0
tit BYTE "SNAKE GAME",0
separator BYTE "---------------------------------",0
hlths BYTE "Lives:",3,3,3,0
highScoreStr BYTE "High Score: ",0
highScore BYTE 0
snake BYTE "X", 104 DUP("x")

xPos BYTE 45,44,43,42,41, 100 DUP(?)
yPos BYTE 15,15,15,15,15, 100 DUP(?)

xPosWall BYTE 34,34,85,85			;position of upperLeft, lowerLeft, upperRight, lowerRignt wall 
yPosWall BYTE 5,24,5,24

xCoinPos BYTE ?
yCoinPos BYTE ?

inputChar BYTE "+"					; + denotes the start of the game
lastInputChar BYTE ?				

strSpeed BYTE "Speed (1-fast, 2-medium, 3-slow): ",0
speed	DWORD 0
.code
main PROC
	call DrawWall			;draw walls
	call DrawScoreboard		;draw scoreboard
	call PrintTitle
	call ChooseSpeed		;let player to choose Speed  
	mov esi,0
	mov ecx,5
drawSnake:
	call DrawPlayer			;draw snake(start with 5 units)
	inc esi
loop drawSnake

INVOKE ExitProcess,0
main ENDP

PrintTitle PROC	
mov eax,cyan
call SetTextColor
mov dl, 55
mov dh, 1
call Gotoxy
mov edx, OFFSET tit
call WriteString
mov dl,43
mov dh,2
call Gotoxy
mov edx,OFFSET separator
call WriteString
mov eax,white (black * 16)		;reset color to black and white
call SetTextColor
PrintTitle ENDP

DrawWall PROC					;procedure to draw wall
	mov dl,xPosWall[0]
	mov dh,yPosWall[0]
	call Gotoxy	
	mov edx,OFFSET xWall
	call WriteString			;draw upper wall

	mov dl,xPosWall[1]
	mov dh,yPosWall[1]
	call Gotoxy	
	mov edx,OFFSET xWall		
	call WriteString			;draw lower wall

	mov dl, xPosWall[2]
	mov dh, yPosWall[2]
	mov eax,"#"	
	inc yPosWall[3]
	L11: 
	call Gotoxy	
	call WriteChar	
	inc dh
	cmp dh, yPosWall[3]			;draw right wall	
	jl L11

	mov dl, xPosWall[0]
	mov dh, yPosWall[0]
	mov eax,"#"	
	L12: 
	call Gotoxy	
	call WriteChar	
	inc dh
	cmp dh, yPosWall[3]			;draw left wall
	jl L12
	ret
DrawWall ENDP
DrawScoreboard PROC				;procedure to draw scoreboard
	mov dl,27
	mov dh,3
	call Gotoxy
	mov edx,OFFSET strScore		;print string that indicates score
	call WriteString
	mov eax,"0"
	call WriteChar				;scoreboard starts with 0
	mov dl, 12; 
	mov dh,3
	call Gotoxy
	mov edx,OFFSET hlths
	call WriteString
	mov dl,52
	mov dh,3
	call Gotoxy
	mov edx,OFFSET highScoreStr 
	call WriteString
	mov eax, "0"
	call WriteChar
	ret
DrawScoreboard ENDP
ChooseSpeed PROC			;procedure for player to choose speed
	mov edx,0
	mov dl,73				
	mov dh,3
	call Gotoxy	
	mov edx,OFFSET strSpeed	; prompt to enter integers (1,2,3)
	call WriteString
	mov esi, 40				; milisecond difference per speed level
	mov eax,0
	call readInt			
	cmp ax,1				;input validation
	jl invalidspeed
	cmp ax, 3
	jg invalidspeed
	mul esi	
	mov speed, eax			;assign speed variable in mililiseconds
	ret

	invalidspeed:			;jump here if user entered an invalid number
	mov dl,105				
	mov dh,1
	call Gotoxy	
	mov edx, OFFSET invalidInput		;print error message		
	call WriteString
	mov ax, 1500
	call delay
	mov dl,105				
	mov dh,1
	call Gotoxy	
	mov edx, OFFSET blank				;erase error message after 1.5 secs of delay
	call writeString
	call ChooseSpeed					;call procedure for user to choose again
	ret
ChooseSpeed ENDP

DrawPlayer PROC			; draw player at (xPos,yPos)
	mov dl,xPos[esi]
	mov dh,yPos[esi]
	call Gotoxy
	mov dl, al			;temporarily save al in dl
	mov al, snake[esi]		
	call WriteChar
	mov al, dl			
	ret
DrawPlayer ENDP

UpdatePlayer PROC		; erase player at (xPos,yPos)
	mov dl, xPos[esi]
	mov dh,yPos[esi]
	call Gotoxy
	mov dl, al			;temporarily save al in dl
	mov al, " "
	call WriteChar
	mov al, dl
	ret
UpdatePlayer ENDP

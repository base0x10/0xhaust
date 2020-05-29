;redcode
;name DecoyAndBomberV2
;author Skybuck Flying
;assert 1
;strategy Decoy/StunnerAndBomber
;version 2
;history Created on 3 november 2007

; a bit faster bomber.

; idea was but not yet implemeted: :) instead simply skips 2 squares ;) Is able to destroy "piper" and "mice" warrior ;) 
; let's create a bomber which bombs horizontal and vertical lines mostly vertical lines because programs
; are usually at least 2 squares we can skip on line and maybe save execution instructions but this will only
; work if it's equal ammount of instructions otherwise it's useless ;) unless we jump a bit more ;)

jmp begin
decoy spl 0, 1
bomb dat #0
counter dat #11
adder dat #3
begin
 mov decoy, @counter
 add adder, counter
 seq counter, #-6 ; leaves one empty cell between program and rest of core ;)
jmp begin
mov bomb, decoy
mov #11, counter
mov #1, adder 
jmp begin

;redcode-94nop
;name Lunch Break
;author Anton Marsden
;strategy 0.66c scan + 0.33c linear scan then d-clear
;assert CORESIZE==8000

step EQU 2376
gate EQU (kill-2)
away EQU 3226

src  mov inc, <dest

FOR 10
     mov {src, <dest
ROF
dest spl @0, away
     div.f #0, dest


kill  mov inc, @ptr
scan seq.i  2*step-3, 2*step+2
mov.x  scan, @kill
a  add.f inc,scan
 jmz.f  scan, <ptr
 jmp   kill, <gate-2667-8
mov.i dbomb, >gate
btm   djn.f -1, >gate
dbomb dat <2667, ptr-gate+4
ptr dat step+2,step-3  ;; scanned (3, 8)
inc  spl #step, step

dat 0,0
dat 0,0
dat 0,0


FOR  9 ;;70/8
spl.i #1,@1
spl.i #1,*1
dat 0,0
spl.x #1,1
spl.a #1,1
dat 0,0
spl.f #1,1
dat 0,0
ROF


dat 0,0


END src


;redcode-94nop
;assert CORESIZE == 8000
;name rdrc: Seaside Squint
;author Dave Hillis
;strategy -  Created using RedRace.c.
;strategy -  An evolving population playing KOTH.
; evolved oneshot
djn.f  $  -212, {    -3
spl.ba $    34, }    -2
add.f  $    3, $    1	; step
mov.i  }  -214, <  -16	; bomb	(later imp)
jmz.f  $    -2, <    -1	; scan
spl.ba $  -298, }  -300
sne.i  }  136, $    8
sne.i  }  -190, $    13
nop.ba $  -266, <    6
spl.ba #    8, {  333
mov.i  @    2, }  -16	; attack target
mov.i  }  -214, >    -2	; unrelated core-clear
djn.f  $    -2, {    -9	; attack target
spl.ba #    2, {  391
spl.ba #  -58, {    3
add.f  $    1, $    1	; step
djn.f  $  -160, {  355	; jump into core (imps)
end  2


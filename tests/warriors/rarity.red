;redcode-94nop
;name Rarity
;author vbb
;strategy scanner
;version 1.1
;date 19 July 2012
;assert CORESIZE==8000

st:
scanner:
 seq st-1,st-1+20
 jmp boom,}scanner
scad: add.f inc,scanner
 djn scanner,#800
lp: mov.i bomb,<bomb
wipe: djn lp,7980
 mov.i inc,bomb
 jmp lp

inc dat $-20,$-20
bomb: spl 0,lp-1

boom: mov.i bomb,}scanner
bcnt: djn boom,#20+1
 sub.a #20+1+1,scanner
 mov.ab #20+1,bcnt
 jmp scad


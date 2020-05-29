;redcode-94
;name Barrage A 22
;author Steve Gunnell
;strategy Dawn assult!
;assert 1

STEP   equ 2662
TIME   equ 1171
STOP   equ (bGo - gate - 6 - 5 )
GAP1   equ 5

        dat #1, #1
bGo     spl     # 1,          1
loop    mov.i     bGo,      > gate
    for 6
        mov.i   * loop,     > gate
    rof
        mod.ab  # STOP,       gate
        add.ab  # STEP,     @ -1
        djn.b     loop,     # TIME
        dat     { loop,       0
    for GAP1
        dat.f   $ 0,        $ 0
    rof
gate    dat     # 0,        # 3660

end bGo


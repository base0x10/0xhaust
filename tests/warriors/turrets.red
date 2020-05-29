;redcode-94 verbose
;name       turrets
;author     A.Ceyrolle
;strategy   bombing preventively and being many
;assert 1

        ORG start

start   spl third
        spl second

first   mov #0, -3
        mov #0, -6
        jmp first

second: mov #0, -10
        mov #0, -13
        jmp second

third:  mov #0, -17
        mov #0, -20
        jmp third
end 


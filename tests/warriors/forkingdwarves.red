;redcode-94b
;name Forking Dwarves
;author Bob Bever
;strategy Starts a dwarf to drop spl bombs every 3 spaces.
;strategy After 500 runs of that drops spl carpets in multiple
;strategy directions in a couple spots in order to slow up opponents
;strategy after trying to fill memory with an spl carpet, causes core clear
;date 2007-Oct-23
;version 3
;assert CORESIZE==8000

	org     main
main	add     #3,     bomb	; Starts the dwarf dropping spl bombs
	mov     bomb,   @bomb
	djn     main,   #500	; after 500 iterations start into the
carpet  mov     d1,     @d1	; spl carpet.
	mov     d2,     <d2
	mov     d3,     >d3	; starts after the warrior, at 2000,
        mov     d4,     <d4	; at 4000, and 6000. Most move backwards
        mov     d5,     >d5	; and forwards to avoid hitting itself
        mov     d7,     <d7
        mov     d8,     >d8
        sne     #0,     #1800	; When the carpet ran through 1800
        jmp     cc2		; cycles switch to a core clear
        nop     <-2		; Only way I could get sne to count down
        jmp     carpet, >1
d1      spl     #0,     #16	; Data bits for spl carpet
d2      spl     #0,     #-15
d3      spl     #0,     #4000
d4      spl     #0,     #4000
d5      spl     #0,     #2000
d7      spl     #0,     #6000
d8      spl     #0,     #6000
cc2     add     #1,     bomb2	; Core clear to run back and forth from
        sub     #1,     bomb3	; both ends of the program
        mov     bomb2,  @bomb2
        mov     bomb3,  @bomb3
        djn     cc2,    #8000-26
        jmp     0
bomb2   dat     #0,     #2	; bombs
bomb3   dat     #0,     #-26
bomb    spl     #0,     #0
        end

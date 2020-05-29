;redcode
;name MiniDeathStarV13
;assert 1
;author Skybuck Flying
;strategy Massive-Serial-Threaded-Dual-Beam-Single-Instruction-Plasma-Cannon, PlasmaSelect, StunPlasma, DeadlyPlasma, RayControl, RaySpacing, SublightDrive, PowerUp and BootUp Program.
;strategy Ask yourself: Can my warrior stop the death star before it fires ?
;strategy Ask yourself: Can my warrior stop the death star during it's firement ?
;strategy Ask yourself: Can my warrior survive the deadly rays of the death star ? 
;strategy Ask yourself: Is my warrior fast enough to catch up with the death star ?
;strategy Ask yourself: Is there a place to hide ?
;version 13
;date 14 december 2007
;
; Info: Unoptimized version.
; Info: No front/forward laser yet.
; Info: No read/backward laser yet.
; Info still kicks millinium falcon's ass ! :) ;) :):):):):) =DDDDD
;

; Let's change it's configuration and code as follows:

; TopRayPosition
; BottomRayPosition

; Let's use a RayCounter to indicate which line above or below should be bombed
; Let's use a RayModder  to mod this to something like 63 or so... or maybe even 32... if they beams work together
; Let's use a RayCounterReset to simply reset it. no need the mod does this.
; Let's use a RayMultiplier which multiplies the counter with the spacing ! Smart eh ! :) first uses of mul... niceee..
; Let's use a TopRayPositionReset
; Let's use a BottomRayPositionReset
; Let's use a Sub RayResult from TopRayPosition
; Let's use a Add RayResult to BottomRayPosition
;
; It's working perfectly. Now the only thing I need is to come up with an idea how to finish stunned warriors offset.
; Maybe somehow switch the plasma from stun to death... after a certain ammount of time...
; Actually should be easy enough to do... but the deathstar should always reswitch to plasma in case the killoff of warriors
; doesn't go well the first time... hmmm me need to think about that :)
; maybe build in something so half of the rays shoot stun plasma... but best is stun plasma completely and later switch to deadly plasma
; and maybe then switch one more time to etc.
;
; I think I know a way... use one large PlasmaCounter which indicates when to switch to plasma.
; For example the first 4000 runs... it should use STUN plasma... the plasma counter is always increment +1.... then it's div 4000.... the result will be zero...
; so it will use stun plasma...
; then later when runs is 8000 it will become 4000+ div 4000 = 1 yeeaaah deadly plasma will be use... nice and then later it will wrap around again... very nice !
; finally if the div needs to be something else... then... another mod 2 or so could be used... to make sure... it doesn't go out of range... cool then the counter
; doesn't even need to be reset or anything like that... however if a mod on the counter was used it would reset itself... but why do it... would just require
; extra instruction... besides now we have a somewhat running counter kinda nice ! maybe it could be used for other stuff as well ?! ;) :):):) but for now
; let's focus FOCUSSSS on the plasma switcher ?! :) let's first figure out how much time the death needs for a complete fill :)
; Also becomes the bottom ray position variable is one below the other one... it's offset is off by one so compensate for that by subtracting -1 from it's starting
; position for now ;) :) later optimizations could be made... but not gonna do optimization now... because the code is not complete yet... changes might happen so...
; optimizations now would be waste of time :) and would make it too complex to write new code :)


CoreLineLength equ 128

DeathStarBegin

	DeathStarConstructionLength	equ (DeathStarConstructionEnd - DeathStarConstructionBegin)

	DeathStarConstructionBegin

		DeathStarInitializeDriveSystemBegin
			DeathStarDetermineDrivePowerType mov.f DeathStarDriveSourceDest, DeathStarDrivePowerSource
		DeathStarInitializeDriveSystemEnd
		
		DeathStarPowerUpBegin

			; systems must be powered up in reverse order

			spl DeathStarPowerUpSystemBottomRayBegin
			spl DeathStarPowerUpSystemTopRayBegin
			spl DeathStarPowerUpSubSystemsBegin

			; wait for systems to come online
			djn 0, #6

			; activate systems
			mov.ab #1, DeathStarActivateSystems

			; 0 = systems waiting for activation,	1 = activating systems
			DeathStarActivateSystems nop $0, $0

			dat $0, $0

		DeathStarPowerUpEnd

		DeathStarPowerUpSubSystemsBegin

			; sub systems need 30 threads
			; 38-1 is 37, in binary: 100101
			spl 1
			mov -1, 0
			mov -1, 0
			spl 1
			mov -1, 0
			spl 1

			jmz 0, DeathStarActivateSystems
			jmp >DeathStarThreadCounter 
			DeathStarThreadCounter dat $0, $1
			
			DeathStarBootUpSystemDriveBegin
			
				; number of threads must equal death star body.
				; 25 threads needed for drive system
				jmp DeathStarDrive ; 1
				jmp DeathStarDrive ; 2
				jmp DeathStarDrive ; 3
				jmp DeathStarDrive ; 4
				jmp DeathStarDrive ; 5
				jmp DeathStarDrive ; 6
				jmp DeathStarDrive ; 7
				jmp DeathStarDrive ; 8
				jmp DeathStarDrive ; 9
				jmp DeathStarDrive ; 10
				jmp DeathStarDrive ; 11
				jmp DeathStarDrive ; 12
				jmp DeathStarDrive ; 13
				jmp DeathStarDrive ; 14
				jmp DeathStarDrive ; 15
				jmp DeathStarDrive ; 16
				jmp DeathStarDrive ; 17
				jmp DeathStarDrive ; 18
				jmp DeathStarDrive ; 19
				jmp DeathStarDrive ; 20
				jmp DeathStarDrive ; 21
				jmp DeathStarDrive ; 22
				jmp DeathStarDrive ; 23
				jmp DeathStarDrive ; 24
				jmp DeathStarDrive ; 25
			DeathStarBootUpSystemDriveEnd

			DeathStarBootUpSystemDrivePowerInjectorBegin
				; 1 thread for drive power injector
				jmp DeathStarDriveInjectPower + 1	; compensate for movement
			DeathStarBootUpSystemDrivePowerInjectorEnd

			DeathStarBootUpWeaponsControlBegin

				; 12 threads for weapon control
				jmp DeathStarWeaponControlBegin + 1
				jmp DeathStarWeaponControlBegin + 2
				jmp DeathStarWeaponControlBegin + 3
				jmp DeathStarWeaponControlBegin + 4
				jmp DeathStarWeaponControlBegin + 5
				jmp DeathStarWeaponControlBegin + 6
				jmp DeathStarWeaponControlBegin + 7
				jmp DeathStarWeaponControlBegin + 8
				jmp DeathStarWeaponControlBegin + 9
				jmp DeathStarWeaponControlBegin + 10
				jmp DeathStarWeaponControlBegin + 11
				jmp DeathStarWeaponControlBegin + 12
			
			DeathStarBootUpWeaponsControlEnd

		DeathStarPowerUpSubSystemsEnd

		; kill off closeby enemies.
		DeathStarPowerUpSystemTopRayBegin

			spl 1	; 2
			spl 1	; 4
			spl 1	; 8
			spl 1 	; 16
			spl 1	; 32

			jmz 0, DeathStarActivateSystems
			jmp DeathStarFireTopRay 

		DeathStarPowerUpSystemTopRayEnd

		; stun far away enemies
		DeathStarPowerUpSystemBottomRayBegin

			spl 1	; 2
			spl 1	; 4
			spl 1	; 8
			spl 1 	; 16
			spl 1	; 32

			jmz 0, DeathStarActivateSystems
			jmp DeathStarFireBottomRay 

		DeathStarPowerUpSystemBottomRayEnd

	DeathStarConstructionEnd

DeathStarBodyBegin

	DeathStarBodyLength		equ (DeathStarBodyEnd - DeathStarBodyBegin)

	; could protection for rear too, from top and bottom
	TopRayStartPosition		equ	-128 - 16
	BottomRayStartPosition		equ	+128 - 17; (to compensate for variable being one lower)

	; old doesn't cover it's ass:
;	TopRayStartPosition		equ	-128;
;	BottomRayStartPosition		equ	+128 ; (to compensate for variable being one lower)

	RayNextLine			equ	1
	RayLines			equ	32
	RaySpacing			equ	128

	DeathStarDriveBegin

		DeathStarDriveSourceDest	dat #DeathStarEnd, #DeathStarEnd + 1
		DeathStarDrive			mov {DeathStarDriveSourceDest, <DeathStarDriveSourceDest

	DeathStarDriveEnd
	

	DeathStarWeaponsBegin

		DeathStarWeaponControlBegin

				; reset ray positions
				mov		#TopRayStartPosition,		TopRayPosition
				mov		#BottomRayStartPosition, 	BottomRayPosition
		
				; calculate ray counter 
				add.ab		#RayNextLine,	RayCounter					
				mod		#RayLines,	RayCounter

				; copy ray counter to ray offset
				mov.b		RayCounter, RayOffset

				; multiple ray counter/offset with spacing to get good ray offset without disturbing the ray counter :)				
				mul		#RaySpacing,	RayOffset
				
				; sub ray offset from top ray position
				sub		RayOffset,	TopRayPosition

				; add ray offset to bottom ray position
				add		RayOffset,	BottomRayPosition

				; plasma counter
				add		#1,		PlasmaCounter

				; plasma counter is allowed to increment to twice the line size
				mod		#256,		PlasmaCounter

				; copy it to plasma select to keep plasma counter intact, could reuse offset or so as plasma select but ok.
				mov.b		PlasmaCounter,	PlasmaSelect
			
				; divide it by line size,	0 will be stun plasma,	1 will be deadly plasma :)
				; this does mean	plasma's will need to be below the plasma select for it to work
				; actually this doesn't work yet... because plasma select would then need to be 0, or 1 hmm.
				; wait what if plasma select no, it;s not a problem, plasma select can also function as deadly plasma
				; safer too... plasma 1 will be stunning plasma... nice.
				div		#128,		PlasmaSelect


				; plasma switcher.
;				DeathStarSelectPlasma	mov.x #DeathStarStunningPlasma, #DeathStarDeadlyPlasma

		DeathStarWeaponControlEnd
		
		DeathStarFireWeaponsBegin
;			DeathStarFireTopRay		mov DeathStarStunningPlasma, 	>TopRayPosition
;			DeathStarFireBottomRay		mov DeathStarStunningPlasma, 	>BottomRayPosition

			DeathStarFireTopRay		mov @PlasmaSelect, 	>TopRayPosition
			DeathStarFireBottomRay		mov @PlasmaSelect, 	>BottomRayPosition

		DeathStarFireWeaponsEnd

		DeathStarWeaponsDataBegin
			TopRayPosition		dat $0, #TopRayStartPosition
			BottomRayPosition	dat $0, #BottomRayStartPosition
			RayCounter		dat $0, $0
			RayOffset		dat $0, $0
			PlasmaCounter		dat $0, $128		; must start at 128 to start with stun plasma :)
		DeathStarWeaponsDataEnd

	DeathStarWeaponsEnd

	DeathStarPlasmasBegin
		; plasma select also functions as deadly plasma.
		DeathStarDeadlyPlasma
		PlasmaSelect			dat	$0, $1		; set it to one to start with stun plasma on first bombing run first line.
		DeathStarStunningPlasma 	spl.a	$0, $1
	DeathStarPlasmasEnd

	DeathStarDrivePowerSourceBegin
		DeathStarDriveInjectPower		mov.f DeathStarDrivePowerSource, DeathStarDriveSourceDest

		DeathStarDrivePowerSource		dat #0, #0		
	DeathStarDrivePowerSourceEnd

DeathStarBodyEnd

DeathStarEnd
	dat $0, $0		; included to make pmars compilers happy.



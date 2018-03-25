@Drive Def: adjacent allies gain +4 defense in combat.
.equ DriveLukID, AuraSkillCheck+4
.thumb
push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r4, r0
mov r5, r1

@ mov r0, r5       @Move defender data into r1.
@ mov r1, #0x50    @Move to the defender's weapon type.
@ ldrb r1, [r0,r1]
@ cmp     r1,#0x03    @physical weapon?
@ bgt     Done

@now check for the skill
ldr r0, AuraSkillCheck
mov lr, r0
mov r0, r4 @attacker
ldr r1, DriveLukID
mov r2, #0 @can_trade
mov r3, #2 @range
.short 0xf800
cmp r0, #0
beq Done

mov r0, r4
add     r0,#0x60    @Move to the attacker's hit.
ldrh    r3,[r0]     @Load the attacker's hit into r3.
add     r3,#2    @add 2 to the attacker's hit, approximating +4 luck, since something something fractions
strh    r3,[r0]     @Store attacker hit.
add     r0,#0x62    @Move to the attacker's avoid.
ldrh    r3,[r0]     @Load the attacker's avoid into r3.
add     r3,#3    @add 3 to the attacker's avoid, approximating +3 luck
strh    r3,[r0]     @Store attacker avoid.
add     r0,#0x68    @Move to the attacker's crit avoid.
ldrh    r3,[r0]     @Load the attacker's crit avoid into r3.
add     r3,#3   @add 3 to the attacker's crit avoid, approximating +3 luck
strh    r3,[r0]     @Store attacker crit avoid.

Done:
pop {r4-r7}
pop {r0}
bx r0
.align
.ltorg
AuraSkillCheck:
@ POIN AuraSkillCheck
@ WORD DriveLukID

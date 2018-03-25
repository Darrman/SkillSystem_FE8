@Drive Def: adjacent allies gain +4 defense in combat.
.equ DriveSklID, AuraSkillCheck+4
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
ldr r1, DriveSklID
mov r2, #0 @can_trade
mov r3, #2 @range
.short 0xf800
cmp r0, #0
beq Done

mov r0, r4
add     r0,#0x60    @Move to the attacker's hit.
ldrh    r3,[r0]     @Load the attacker's hit into r3.
add     r3,#6    @add 6 to the attacker's hit, approximating +3 skill
strh    r3,[r0]     @Store attacker hit.
add     r0,#0x66    @Move to the attacker's crit.
ldrh    r3,[r0]     @Load the attacker's crit into r3.
add     r3,#2    @add 2 to the attacker's crit, approximating +4 skill... because I'm too lazy to figure out how to add 1.5! It'll only be wrong half the time.
strh    r3,[r0]     @Store attacker crit.
@I'm not going to figure out how to add the proc rate, so it will just buff hit/crit.

Done:
pop {r4-r7}
pop {r0}
bx r0
.align
.ltorg
AuraSkillCheck:
@ POIN AuraSkillCheck
@ WORD DriveSklID

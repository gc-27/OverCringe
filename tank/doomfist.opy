#!mainFile "../main.opy"


rule "Doomfist Rocket Punch":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isFiringSecondaryFire()

    eventPlayer.moveSpeed -= 90
    waitUntil(not eventPlayer.isFiringSecondaryFire(), 2)
    wait(1)
    eventPlayer.moveSpeed += 90

rule "Doomfist Rocket Punch Damage":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition eventAbility == Button.SECONDARY_FIRE

    damage(victim, attacker, eventDamage * 4)

rule "Doomfist Seismic Slam":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isUsingAbility1()

    eventPlayer.applyImpulse(eventPlayer.getFacingDirection(), 50, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    eventPlayer.gravity += 400
    eventPlayer.moveSpeed += 150 
    wait()
    waitUntil(not eventPlayer.isUsingAbility1(), 9999)
    eventPlayer.gravity -= 400
    eventPlayer.moveSpeed -= 150

rule "Doomfist Power Block Knockdown":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isUsingAbility2()

    raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 5, getPlayers(getOppositeTeam(eventPlayer.getTeam())), eventPlayer, false).getPlayerHit().setStatusEffect(eventPlayer, Status.KNOCKED_DOWN, 1)

rule "Doomfist Meteor Strike":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition eventAbility == Button.ULTIMATE

    victim.setStatusEffect(attacker, Status.KNOCKED_DOWN, 2)
    victim.applyImpulse(directionTowards(attacker, victim) + Vector.UP, 25, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)

rule "Doomfist Patch Notes":
    @Event eachPlayer
    @Hero doomfist
    
    eventPlayer.patchNotesData.append([["{} Rocket Punch moves incredibly slowly.".format(abilityIconString(Hero.DOOMFIST, Button.SECONDARY_FIRE)), 0, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} damage dealt by Rocket Punch increased by 500%.".format(abilityIconString(Hero.DOOMFIST, Button.SECONDARY_FIRE)), 1, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Rocket Punch tires Doomfist, slowing him down after use.".format(abilityIconString(Hero.DOOMFIST, Button.SECONDARY_FIRE)), 2, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Seismic Slam Now has 500% gravity and 250% speed.".format(abilityIconString(Hero.DOOMFIST, Button.ABILITY_1)), 3, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Power Block Knocks an enemy in front of Doomfist down for 1 second.".format(abilityIconString(Hero.DOOMFIST, Button.ABILITY_2)), 4, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Meteor Strike Knocks enemies down and knocks them away from the epicenter.".format(abilityIconString(Hero.DOOMFIST, Button.ULTIMATE)), 5, Color.SKY_BLUE]])
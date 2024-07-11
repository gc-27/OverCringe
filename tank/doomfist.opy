#!mainFile "../main.opy"

rule "Doomfist Init":
    @Event eachPlayer
    @Hero doomfist

    eventPlayer.health_different = true
    eventPlayer.health = 350
    eventPlayer.armor = 200


rule "Doomfist Rocket Punch":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isFiringSecondaryFire()

    eventPlayer.moveSpeed -= 90
    waitUntil(not eventPlayer.isFiringSecondaryFire(), 2)
    wait(0.1)
    eventPlayer.moveSpeed += 90

rule "Doomfist Rocket Punch Damage":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition eventAbility == Button.SECONDARY_FIRE

    #damage(victim, attacker, eventDamage * 4)

rule "Doomfist Seismic Slam":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isUsingAbility1()

    eventPlayer.applyImpulse(eventPlayer.getFacingDirection(), 50, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    eventPlayer.gravity += 400
    eventPlayer.moveSpeed += 150 
    waitUntil(not eventPlayer.isUsingAbility1(), 9999)
    eventPlayer.gravity -= 400
    eventPlayer.moveSpeed -= 150

rule "Doomfist Power Block Knockdown":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isUsingAbility2()

    raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 3, getPlayers(getOppositeTeam(eventPlayer.getTeam())), eventPlayer, false).getPlayerHit().setStatusEffect(eventPlayer, Status.KNOCKED_DOWN, 1)

rule "Doomfist Meteor Strike Usage":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isUsingUltimate()

    createEffect(getAllPlayers(), Effect.RING, eventPlayer.getTeam(), updateEveryTick(eventPlayer.getPosition()), 8, EffectReeval.POSITION_AND_RADIUS)
    eventPlayer.effects[0] = getLastCreatedEntity()
    createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, eventPlayer.getTeam(), updateEveryTick(eventPlayer.getPosition()), 2, EffectReeval.POSITION_AND_RADIUS)
    eventPlayer.effects[1] = getLastCreatedEntity()

    waitUntil(not eventPlayer.isUsingUltimate(), 4.2)
    destroyEffect(eventPlayer.effects[0])
    destroyEffect(eventPlayer.effects[1])
    eventPlayer.effects = []

rule "Doomfist Meteor Strike Damage":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition eventAbility == Button.ULTIMATE

    victim.setStatusEffect(attacker, Status.KNOCKED_DOWN, 2)
    victim.applyImpulse(directionTowards(attacker, victim) + Vector.UP, 25, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)

rule "Doomfist Patch Notes":
    @Event eachPlayer
    @Hero doomfist
    
    eventPlayer.hero_description = "After years of powerblocking, he finally broke the gauntlet."
    eventPlayer.patchNotesData.append([["{} Rocket Punch moves incredibly slowly.".format(abilityIconString(Hero.DOOMFIST, Button.SECONDARY_FIRE)), 0, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Deals 200% extra knockback.".format(abilityIconString(Hero.DOOMFIST, Button.SECONDARY_FIRE)), 1, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Rocket Punch tires Doomfist, slowing him down after use.".format(abilityIconString(Hero.DOOMFIST, Button.SECONDARY_FIRE)), 2, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Seismic Slam Now has 500% gravity and 250% speed.".format(abilityIconString(Hero.DOOMFIST, Button.ABILITY_1)), 3, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Power Block Knocks an enemy in front of Doomfist down for 1 second.".format(abilityIconString(Hero.DOOMFIST, Button.ABILITY_2)), 4, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Meteor Strike Knocks enemies down and knocks them away from the epicenter.".format(abilityIconString(Hero.DOOMFIST, Button.ULTIMATE)), 5, Color.SKY_BLUE]])
    eventPlayer.patchNotesData.append([["{} Now shows where Doomfist is for everyone.".format(abilityIconString(Hero.DOOMFIST, Button.ULTIMATE)), 5, Color.SKY_BLUE]])
    
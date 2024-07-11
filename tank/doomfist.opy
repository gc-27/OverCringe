#!mainFile "../main.opy"

rule "Doomfist Init":
    @Event eachPlayer
    @Hero doomfist

    eventPlayer.health_different = true
    eventPlayer.health = 400
    eventPlayer.armor = 100


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
    eventPlayer.patchNotes[0] = ["No longer has an ammo requirement."]
    eventPlayer.patchNotes[1] = ["Move speed reduced to 10% while punching.", "Deals 200% more knockback.", "Has a small delay before you can move after punching."]
    eventPlayer.patchNotes[2] = ["Travel speed increased to 250%."]
    eventPlayer.patchNotes[3] = ["Knocks an enemy in front of Doomfist down for one second."]
    eventPlayer.patchNotes[5] = ["Knocks enemies in the blast radius down for 2 seconds.", "Knocks enemies in the blast radius away.", "Doomfist can now be seen by all players while using."]
    
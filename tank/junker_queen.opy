#!mainFile "../main.opy"

rule "Junker Queen Init":
    @Event eachPlayer
    @Hero junkerQueen

    eventPlayer.health_different = true
    eventPlayer.health = 400
    eventPlayer.armor = 100


rule "Junker Queen Disable Scattergun + Carnage":
    @Event eachPlayer
    @Hero junkerQueen

    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.disallowButton(Button.ABILITY_2)
    eventPlayer.setProjectileSpeed(0)

rule "Junker Queen Jagged Blade ":
    @Event eachPlayer
    @Condition eventPlayer.isFiringSecondaryFire()
    @Hero junkerQueen
    
    eventPlayer.var3 = raycast(eventPlayer.getPosition(), eventPlayer.getPosition() + Vector.DOWN, null, null, false).getHitPosition()
    waitUntil(eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) <= 2.0 or eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) and eventPlayer.canUseAbilities, 4)
    eventPlayer.var4 = eventPlayer.getPosition()
    chase(eventPlayer.var4, eventPlayer.var3, rate=50, ChaseReeval.DESTINATION_AND_RATE)
    eventPlayer.setStatusEffect(null, Status.ROOTED, 99999)
    eventPlayer.startForcingPosition(eventPlayer.var4, true)
    waitUntil(eventPlayer.var4 == eventPlayer.var3, 99999)
    wait(0.1)
    eventPlayer.stopForcingPosition()
    eventPlayer.clearStatusEffect(Status.ROOTED)


rule "Junker Queen Jagged Blade Damage":
    @Event playerDealtDamage
    @Condition eventAbility == Button.SECONDARY_FIRE
    @Condition eventDamage >= 40
    @Hero junkerQueen

    eventPlayer.var3 = victim
    
rule "Junker Queen Commanding Shout":
    @Event eachPlayer
    @Hero junkerQueen
    @Condition eventPlayer.isUsingAbility1()

    eventPlayer.var1 = getPlayersInRadius(eventPlayer, 10, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES_AND_ENEMY_BARRIERS)
    for eventPlayer.counter in range(0, len(eventPlayer.var1)):
        damage(eventPlayer.var1[eventPlayer.counter], eventPlayer, eventPlayer.var1[eventPlayer.counter].getHealth()/4)


rule "Junker Queen Carnage Check":
    @Event eachPlayer
    @Hero junkerQueen
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer.var2 = true
    waitUntil(not eventPlayer.isUsingAbility2(), 99999)
    if eventPlayer.var2:
        damage(eventPlayer, null, 200)


rule "Junker Queen Carnage Damage":
    @Event playerDealtDamage
    @Hero junkerQueen
    @Condition eventAbility == Button.ABILITY_2
    
    eventPlayer.var2 = false

rule "Junker Queen Carnage":
    @Event eachPlayer
    @Hero junkerQueen
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true
    @Condition eventPlayer.canUseAbilities
    
    eventPlayer.allowButton(Button.ABILITY_2)
    eventPlayer.forceButtonPress(Button.ABILITY_2)
    eventPlayer.disallowButton(Button.ABILITY_2)
    waitUntil(not eventPlayer.isUsingAbility2(), 99999)
    wait(0.25)
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0)
    if RULE_CONDITION:
        goto RULE_START

rule "Junker Queen Rampage Mines":
    @Event eachPlayer
    @Hero junkerQueen
    @Condition eventPlayer.isUsingUltimate()

    wait(0.5)

    for eventPlayer.counter in range(0,25):
        createProjectile(Projectile.ROADHOG_SCRAP_BALL, eventPlayer, null, null, Relativity.TO_PLAYER, ModifyHealth.DAMAGE, getOppositeTeam(eventPlayer.getTeam()), 25, 1, 3, DynamicEffect.BAD_EXPLOSION, DynamicEffect.BUFF_EXPLOSION_SOUND, 0, 10, 2, 5, 10, 9.68)
        wait(0.03)


rule "Junker Queen Patch Notes":
    @Event eachPlayer
    @Hero junkerQueen
    
    eventPlayer.hero_description = "I thought it was too difficult to hit Scattergun, so I got rid of it."

    eventPlayer.weapon_names[0] = "Scattergun"
    eventPlayer.weapon_names[1] = "Jagged Blade"
    eventPlayer.weapon_names[2] = "Commanding Shout"
    eventPlayer.weapon_names[3] = "Carnage"
    eventPlayer.weapon_names[5] = "Rampage"
    eventPlayer.weapon_names[6] = "Adrenaline Rush"

    eventPlayer.patchNotes[0] = ["Removed, and replaced with Carnage. Do not look in the bottom right corner."]
    eventPlayer.patchNotes[1] = ["Drops out of Junker Queen's hand on use instead of being thrown.", "When pulled, Junker Queen will move towards the knife.", "Junker Queen will phase through walls to get to the knife."]
    eventPlayer.patchNotes[2] = ["Now damages nearby enemies for 25% of their current health."]
    eventPlayer.patchNotes[3] = ["Missing Carnage will now deal 200 damage to Junker Queen."]
    eventPlayer.patchNotes[5] = ["Now drops mines as Junker Queen charges forward."]

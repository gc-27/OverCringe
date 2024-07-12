#!mainFile "../main.opy"

rule "Orisa Init":
    @Event eachPlayer
    @Hero orisa

    eventPlayer.health_different = true
    eventPlayer.health = 200
    eventPlayer.armor = 300

rule "Orisa Energy Javelin":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isFiringSecondaryFire()
    
    eventPlayer.applyImpulse(eventPlayer.getFacingDirection(), 50, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    wait(1)


rule "Orisa Fortify":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingAbility1() == true
    
    eventPlayer.ccimmune = true
    eventPlayer.addHealthPool(Health.NORMAL, 425, false, true)
    eventPlayer.var1 = getLastCreatedHealthPool()
    eventPlayer.setStatusEffect(null, Status.ROOTED, 5)
    waitUntil(not eventPlayer.isUsingAbility1(), 99999)
    eventPlayer.ccimmune = false
    eventPlayer.clearStatusEffect(Status.ROOTED)
    removeHealthPool(eventPlayer.var1)


rule "Orisa Javelin Spin":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer.setEnvironmentalKillCreditor(getPlayersInRadius(eventPlayer, 10, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES))
    if not eventPlayer.isUsingAbility1():
        eventPlayer.applyImpulse(eventPlayer.getFacingDirection(), 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    for eventPlayer.counter in range(len([player for player in getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())) if distance(player, eventPlayer) < 15])):
        (([player for player in getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())) if distance(player, eventPlayer) < 15])[eventPlayer.counter]).applyImpulse(directionTowards(([player for player in getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())) if distance(player, eventPlayer) < 15])[eventPlayer.counter], eventPlayer), 1, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    wait(0)
    if RULE_CONDITION:
        goto RULE_START



rule "Orisa Terra Surge":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingUltimate() == true
    
    playEffect(getPlayers(eventPlayer.getTeam()), DynamicEffect.RING_EXPLOSION, Color.YELLOW, eventPlayer, 15)
    playEffect(getPlayers(getOppositeTeam(eventPlayer.getTeam())), DynamicEffect.RING_EXPLOSION, Color.ORANGE, eventPlayer, 15)
    getPlayersInRadius(eventPlayer, 15, eventPlayer.getTeam(), LosCheck.SURFACES).addHealthPool(Health.NORMAL, 50, false, false)
    wait(1)
    if RULE_CONDITION:
        goto RULE_START


rule "Orisa Patch Notes":
    @Event eachPlayer
    @Hero orisa

    eventPlayer.hero_description = "Orisa isn't mobile enough."
    eventPlayer.weapon_names[0] = "Augmented Fusion Driver"
    eventPlayer.weapon_names[1] = "Energy Javelin"
    eventPlayer.weapon_names[2] = "Fortify"
    eventPlayer.weapon_names[3] = "Javelin Spin"
    eventPlayer.weapon_names[5] = "Terra Surge"

    eventPlayer.patchNotes[1] = ["Orisa now throws herself alongside the Javelin."]
    eventPlayer.patchNotes[2] = ["Now grants Orisa 500 Overhealth.", "Roots Orisa to the ground while active."]
    eventPlayer.patchNotes[3] = ["Pulls enemies towards Orisa while active.", "Grants Orisa forward facing flight while active."]
    eventPlayer.patchNotes[5] = ["Grants teammates nearby Orisa Overhealth while charging."]

#!mainFile "../main.opy"


rule "Winston dies to Roadhog - Reduce Health":
    @Event playerDied
    @Hero winston
    @Condition attacker.currentHero == Hero.ROADHOG

    eventPlayer.healthMax -= 10
    waitUntil(eventPlayer.isAlive(), 99999)
    bigMessage(eventPlayer, "Tier 2 Wanna be... You'll never be good!!!!")
    eventPlayer.setUltCharge(100)
    wait(1)
    eventPlayer.forceButtonPress(Button.ULTIMATE)


rule "Winston dies to Symmetra - Disable":
    @Event playerDied
    @Hero winston
    @Condition attacker.currentHero == Hero.SYMMETRA

    eventPlayer.setAllowedHeroes(getAllHeroes().exclude(Hero.WINSTON))
    attacker.addHealthPool(Health.ARMOR, 100, true, false)
    attacker.setUltCharge(100)

rule "Winston Jump Pack":
    @Event eachPlayer
    @Hero winston
    @Condition eventPlayer.isUsingAbility1()

    waitUntil(eventPlayer.isInAir(), 1)
    waitUntil(eventPlayer.isOnGround(), 99999)
    damage(getPlayersInRadius(eventPlayer, 3, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES_AND_ENEMY_BARRIERS), eventPlayer, 200)

rule "Winston Barrier Projector":
    @Event eachPlayer
    @Hero winston
    @Condition eventPlayer.isUsingAbility2()

    eventPlayer.var1 = 10
    eventPlayer.var2 = raycast(eventPlayer.getPosition(), eventPlayer.getPosition() + Vector.DOWN * 200, null, null, false).getHitPosition()
    while eventPlayer.var1 > 0:
        damage([player for player in getPlayersInRadius(eventPlayer.var2, 5, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES) if player.currentHero == Hero.LUCIO], eventPlayer, 10)

        wait(0.5)
        eventPlayer.var1 -= 1
        
rule "Winston Primal Rage Jump Pack":
    @Event eachPlayer
    @Hero winston
    @Condition eventPlayer.isUsingUltimate()
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) != 0

    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 0)

rule "Winston Primal Rage Ball":
    @Event eachPlayer
    @Hero winston
    @Condition eventPlayer.isUsingUltimate()
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)

    createProjectile(Projectile.ORB, eventPlayer, null, null, Relativity.TO_PLAYER, ModifyHealth.DAMAGE, getOppositeTeam(eventPlayer.getTeam()), 50, 1, 0, DynamicEffect.BAD_EXPLOSION, DynamicEffect.BUFF_EXPLOSION_SOUND, 0, 10, 100, 100, 1000, 9.68)
    wait(0.656)
    if RULE_CONDITION:
        goto RULE_START

rule "Winston Patch Notes":
    @Event eachPlayer
    @Hero winston

    eventPlayer.patchNotesData.append([["{} Now deals massive damage to any players you directly land on.".format(abilityIconString(eventPlayer.currentHero, Button.ABILITY_1)), 1, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Cooldown during Primal Rage reduced to 0 seconds.".format(abilityIconString(eventPlayer.currentHero, Button.ABILITY_1)), 2, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Deals damage over time to Lucio while he is in the bubble. For you, Juuzou.".format(abilityIconString(eventPlayer.currentHero, Button.ABILITY_2)), 3, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Pressing Secondary Fire tosses a small bouncy ball.".format(abilityIconString(eventPlayer.currentHero, Button.ULTIMATE)), 4, Color.SKY_BLUE]])
    
    
    
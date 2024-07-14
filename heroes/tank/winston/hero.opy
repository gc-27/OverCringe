#!mainFile "../../../main.opy"



rule "Winston Init":
    @Event eachPlayer
    @Hero winston
    
    set_health_pool(eventPlayer, 350, 150, 0)

rule "Winston Secondary Fire":
    @Event playerDealtDamage
    @Hero winston
    @Condition eventAbility == Button.SECONDARY_FIRE

    attacker.var1 = victim
    attacker.var2 = 1
    while attacker.var2 < 5:
        attacker.var3 = random.choice([player for player in getPlayersInRadius(attacker.var1, 4.5, attacker.var1.getTeam(), LosCheck.SURFACES_AND_ALL_BARRIERS) if player != attacker.var1])
        if attacker.var3:
            createBeam(getAllPlayers(), Beam.BAD, attacker.var1, attacker.var3, eventPlayer.getTeam(), EffectReeval.POSITION_RADIUS_AND_COLOR)
            attacker.var2 += 1
            damage(attacker.var3, attacker, eventDamage/attacker.var2)
            wait(0.05)
            destroyEffect(getLastCreatedEntity())
            attacker.var1 = attacker.var3
        else:
            break


rule "Winston Jump Pack":
    @Event eachPlayer
    @Hero winston
    @Condition eventPlayer.isUsingAbility1()

    waitUntil(eventPlayer.isInAir(), 1)
    waitUntil(eventPlayer.isOnGround(), 99999)
    damage(getPlayersInRadius(eventPlayer, 3, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES_AND_ENEMY_BARRIERS), eventPlayer, 100)
        
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

#!mainFile "../main.opy"

playervar jump_target
playervar jump_target_previous
playervar jump_count

rule "Winston Init":
    @Event eachPlayer
    @Hero winston
    
    eventPlayer.health_different = true
    eventPlayer.health = 350
    eventPlayer.armor = 150

rule "Winston Secondary Fire":
    @Event playerDealtDamage
    @Hero winston
    @Condition eventAbility == Button.SECONDARY_FIRE

    attacker.jump_target_previous = victim
    attacker.jump_count = 1
    while attacker.jump_count < 5:
        attacker.jump_target = random.choice([player for player in getPlayersInRadius(attacker.jump_target_previous, 4.5, attacker.jump_target_previous.getTeam(), LosCheck.SURFACES_AND_ALL_BARRIERS) if player != attacker.jump_target_previous])
        if attacker.jump_target:
            createBeam(getAllPlayers(), Beam.BAD, attacker.jump_target_previous, attacker.jump_target, eventPlayer.getTeam(), EffectReeval.POSITION_RADIUS_AND_COLOR)
            attacker.jump_count += 1
            damage(attacker.jump_target, attacker, eventDamage/attacker.jump_count)
            wait(0.05)
            destroyEffect(getLastCreatedEntity())
            attacker.jump_target_previous = attacker.jump_target
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

rule "Winston Patch Notes":
    @Event eachPlayer
    @Hero winston

    eventPlayer.hero_description = "Guxue's dream."
    eventPlayer.patchNotesData.append([["{} Secondary Fire now jumps between players.".format(abilityIconString(eventPlayer.currentHero, Button.PRIMARY_FIRE)), 1, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Now deals massive damage to any players you directly land on.".format(abilityIconString(eventPlayer.currentHero, Button.ABILITY_1)), 1, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Cooldown during Primal Rage reduced to 0 seconds.".format(abilityIconString(eventPlayer.currentHero, Button.ABILITY_1)), 2, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Pressing Secondary Fire tosses a small bouncy ball.".format(abilityIconString(eventPlayer.currentHero, Button.ULTIMATE)), 4, Color.SKY_BLUE]])
    
    
    
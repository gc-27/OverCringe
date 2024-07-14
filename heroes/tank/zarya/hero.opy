#!mainFile "../../../main.opy"


rule "Zarya Init":
    @Event eachPlayer
    @Hero zarya

    eventPlayer.disallowButton(Button.ULTIMATE)
    set_health_pool(eventPlayer, 250, 0, 250)

rule "Zarya Particle Barrier":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.isUsingAbility1()
    
    eventPlayer.moveSpeed += 25
    waitUntil(not eventPlayer.isUsingAbility1(), 4)
    eventPlayer.setAbility1Enabled(false)
    eventPlayer.addHealthPool(Health.NORMAL, 50, false, false)
    eventPlayer.moveSpeed -= 25
    wait(2)
    eventPlayer.setAbility1Enabled(true)


rule "Zarya Gravity Grenade":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.canUseAbilities

    eventPlayer.setUltCharge(0)

    bigMessage(getPlayers(getOppositeTeam(eventPlayer.getTeam())), "Have fun up there!")
    bigMessage(getPlayers(eventPlayer.getTeam()), "Fire at... Will? Who's Will?")
    createProjectile(Projectile.ZARYA_GRAVITON, eventPlayer, eventPlayer.getEyePosition(), eventPlayer.getFacingDirection(), Relativity.TO_WORLD, ModifyHealth.DAMAGE, getOppositeTeam(eventPlayer.getTeam()), 100, 0, 12, DynamicEffect.BAD_EXPLOSION, DynamicEffect.EXPLOSION_SOUND, 0, 40, 100, 10, 0, 9.68)
    eventPlayer.setUltEnabled(false)
    wait(2)
    eventPlayer.setUltEnabled(true)

rule "Zarya Gravity Grenade Hit":
    @Event playerTookDamage
    @Condition attacker.currentHero == Hero.ZARYA
    @Condition eventAbility == null

    if victim.ccimmune:
        return
    victim.gravity -= 100
    victim.setStatusEffect(attacker, Status.ROOTED, 4)
    wait(4)
    victim.gravity += 100

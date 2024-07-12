#!mainFile "../main.opy"

rule "Zarya Init":
    @Event eachPlayer
    @Hero zarya

    eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer.health_different = true
    eventPlayer.health = 250
    eventPlayer.shields = 250

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

rule "Zarya Patch Notes":
    @Event eachPlayer
    @Hero zarya

    eventPlayer.hero_description = "Fire at... Will? Who's Will?"
    
    eventPlayer.weapon_names[0] = "Particle Cannon"
    eventPlayer.weapon_names[1] = "Particle Cannon"
    eventPlayer.weapon_names[2] = "Particle Barrier"
    eventPlayer.weapon_names[3] = "Projected Barrier"
    eventPlayer.weapon_names[5] = "New Ultimate: 'Gravity Bomb'"

    eventPlayer.patchNotes[1] = ["Knockback doubled."]
    eventPlayer.patchNotes[2] = ["Grants a 50 HP Overhealth pool after decaying.", "Grants a 25% speed boost while active.", "Disabled for 2 seconds after use."]
    eventPlayer.patchNotes[5] = ["Zarya shoots out a gravity charge that explodes on impact.", "Enemies that are hit with the blast are unable to move, ", "and become weightless for four seconds.", "Effect of Gravity Bomb does not affect players that are Unstoppable.", "(Mauga's Overrun, Orisa's Fortify.)"]

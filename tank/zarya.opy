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
    eventPlayer.patchNotesData.append([["{} Secondary fire knockback doubled.".format(abilityIconString(eventPlayer.currentHero, Button.PRIMARY_FIRE)), 1, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Grants a 50 hp Overhealth pool after decaying.".format(abilityIconString(eventPlayer.currentHero, Button.ABILITY_1)), 2, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Grants a 25% speed boost while active.".format(abilityIconString(eventPlayer.currentHero, Button.ABILITY_1)), 2.1, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Disabled for 2 seconds after use.".format(abilityIconString(eventPlayer.currentHero, Button.ABILITY_1)), 2.2, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Replaced with new Ultimate : {} 'Gravity Grenade'".format(abilityIconString(eventPlayer.currentHero, Button.ULTIMATE), iconString(Icon.SPIRAL)), 4, Color.SKY_BLUE]])
    eventPlayer.patchNotesData.append([["{} Zarya shoots out a gravity charge that explodes on contact.".format(iconString(Icon.SPIRAL)), 5, Color.SKY_BLUE]])
    eventPlayer.patchNotesData.append([["{} Enemies that are hit with the blast are unable to move and become weightless for four seconds.".format(iconString(Icon.SPIRAL)), 6, Color.SKY_BLUE]])
    eventPlayer.patchNotesData.append([["{} Effect does not affect players that are Unstoppable.".format(iconString(Icon.SPIRAL)), 7, Color.RED]])
    
    
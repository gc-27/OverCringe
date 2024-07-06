#!mainFile "../main.opy"

rule "Junker Queen Disable Scattergun + Carnage":
    @Event eachPlayer
    @Hero junkerQueen

    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.disallowButton(Button.ABILITY_2)
    eventPlayer.setProjectileSpeed(0)

rule "Junker Queen Jagged Blade":
    @Event playerDealtDamage
    @Condition eventAbility == Button.SECONDARY_FIRE
    @Hero junkerQueen

    damage(victim, attacker, eventDamage * 5)
    attacker.applyImpulse(directionTowards(attacker, victim), 1, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    
rule "Junker Queen Commanding Shout":
    @Event eachPlayer
    @Hero junkerQueen
    @Condition eventPlayer.isUsingAbility1()


    eventPlayer.var1 = getPlayersInRadius(eventPlayer, 10, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES_AND_ENEMY_BARRIERS)
    for eventPlayer.i in range(0, len(eventPlayer.var1)):
        damage(eventPlayer.var1[eventPlayer.i], eventPlayer, eventPlayer.var1[eventPlayer.i].getHealth()/4)


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


rule "Junker Queen Carnage Primary Fire":
    @Event eachPlayer
    @Hero junkerQueen
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true
    
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

    wait(0.74)

    for eventPlayer.i in range(0,25):
        createProjectile(Projectile.ROADHOG_SCRAP_BALL, eventPlayer, null, null, Relativity.TO_PLAYER, ModifyHealth.DAMAGE, getOppositeTeam(eventPlayer.getTeam()), 25, 1, 3, DynamicEffect.BAD_EXPLOSION, DynamicEffect.BUFF_EXPLOSION_SOUND, 0, 10, 2, 5, 10, 9.68)
        wait(0.03)


rule "Junker Queen Patch Notes":
    @Event eachPlayer
    @Hero junkerQueen
    
    eventPlayer.patchNotesData.append([["{} removed. Do not look in the bottom right corner.".format(abilityIconString(Hero.JUNKER_QUEEN, Button.PRIMARY_FIRE)), 0, Color.WHITE]])
    eventPlayer.patchNotesData.append([["{} Connecting Jagged Blade will now magnetize her to the victim.".format(abilityIconString(Hero.JUNKER_QUEEN, Button.SECONDARY_FIRE)), 1, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Jagged Blade just drops out of Junker Queen's hand, and deals 5x damage.".format(abilityIconString(Hero.JUNKER_QUEEN, Button.SECONDARY_FIRE)), 2, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Commanding Shout now damages nearby enemies for 25% of their current health.".format(abilityIconString(Hero.JUNKER_QUEEN, Button.ABILITY_1)), 3, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Carnage replaces the Scattergun. MIssing now deals 200 self-damage.".format(abilityIconString(Hero.JUNKER_QUEEN, Button.ABILITY_2)), 4, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Rampage now leaves a trail of mines while casting.".format(abilityIconString(Hero.JUNKER_QUEEN, Button.ULTIMATE)), 5, Color.SKY_BLUE]])
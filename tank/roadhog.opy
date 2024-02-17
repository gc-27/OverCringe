#!mainFile "../main.opy"

playervar roadhogDamageVar 
playervar roadhogHookCooldown

rule "Roadhog init":
    @Event eachPlayer
    @Hero roadhog

    eventPlayer.setSecondaryFireEnabled(false)

rule "Roadhog dies to Symmetra - Disable":
    @Event playerDied
    @Hero roadhog
    @Condition attacker.currentHero == Hero.SYMMETRA

    attacker.addHealthPool(Health.ARMOR, 50, true, false)
    attacker.setUltCharge(attacker.getUltCharge() + 50)


rule "Roadhog Stank":
    @Event eachPlayer
    @Condition teamHasHero(Hero.ROADHOG, getOppositeTeam(eventPlayer.getTeam()))
    @Condition distance(eventPlayer, getPlayersOnHero(Hero.ROADHOG, getOppositeTeam(eventPlayer.getTeam()))) <= 10
    @Condition eventPlayer.getCurrentHero() != Hero.ROADHOG
    @Condition isInLoS(eventPlayer, getPlayersOnHero(Hero.ROADHOG, getOppositeTeam(eventPlayer.getTeam())), BarrierLos.PASS_THROUGH_BARRIERS)
    
    eventPlayer.roadhogDamageVar += 1
    damage(eventPlayer, getPlayersOnHero(Hero.ROADHOG, getOppositeTeam(eventPlayer.getTeam())), eventPlayer.roadhogDamageVar)
    wait(0.25)
    if RULE_CONDITION:
        goto RULE_START
    eventPlayer.roadhogDamageVar = 0

rule "Roadhog Melee":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.isMeleeing()
    
    if random.randint(1, 10) == 10:
        damage(getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())), eventPlayer, 30)


rule "Roadhog Hook":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.isUsingAbility1()
    
    if random.randint(1, 5) == 1:
        eventPlayer.var1 = raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 3, null, getAllPlayers(), false).getHitPosition()
        eventPlayer.var2 = raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 3, null, eventPlayer, false).getNormal()
        (random.choice([player for player in getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())) if player.getCurrentHero() != Hero.WINSTON])).teleport(raycast(eventPlayer.var1, eventPlayer.var1 + eventPlayer.var2 * 1.5, null, getAllPlayers(), false).getHitPosition() - vect(0, 1, 0))


rule "Roadhog Pig Pen":
    @Event playerDealtDamage
    @Hero roadhog
    @Condition eventAbility == Button.ABILITY_2
    
    victim.setAimSpeed(25)
    wait(3)
    victim.setAimSpeed(100)

rule "Roadhog Hook Cooldown":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.roadhogHookCooldown != eventPlayer.getAbilityCooldown(Button.ABILITY_1)
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_1) != 0
    
    eventPlayer.roadhogHookCooldown = eventPlayer.getAbilityCooldown(Button.ABILITY_1)
    chase(eventPlayer.roadhogHookCooldown, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)


rule "Roadhog Hook Cooldown Set":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.roadhogHookCooldown != 0
    
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, eventPlayer.roadhogHookCooldown)


rule "Roadhog Whole Hog":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.isUsingUltimate()
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE)
    @Condition not eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN)
    @Condition not eventPlayer.hasStatusEffect(Status.ASLEEP)
    @Condition not eventPlayer.hasStatusEffect(Status.FROZEN)
    @Condition not eventPlayer.hasStatusEffect(Status.STUNNED)
    @Condition not eventPlayer.isUsingAbility1()
    @Condition not eventPlayer.isUsingAbility2()
    @Condition not eventPlayer.isMeleeing()
    
    eventPlayer.applyImpulse(eventPlayer.getFacingDirection() - eventPlayer.getFacingDirection() * 2, 15, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    wait(0.128, Wait.ABORT_WHEN_FALSE)
    if RULE_CONDITION:
        goto RULE_START


rule "Roadhog Patch Notes":
    @Event eachPlayer
    @Hero roadhog
    @Disabled

    eventPlayer.patchNotesData.append([["New Name: Tier 2 Wanna-Be", -3, Color.WHITE]])
    eventPlayer.patchNotesData.append([["NEW PASSIVE: {} Stank: Enemies near Tier 2 Wanna-Be take exponential damage due to his odor.".format(iconString(Icon.POISON)), -2, Color.WHITE]])
    eventPlayer.patchNotesData.append([["{} Quick Melee has a 10% chance of damaging enemies regardless of distance.".format(abilityIconString(Hero.ROADHOG, Button.MELEE)), -1, Color.WHITE]])
    eventPlayer.patchNotesData.append([["{} Take a Breather disabled. He is too powerful to need it.".format(abilityIconString(Hero.ROADHOG, Button.SECONDARY_FIRE)), 0, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Hook has a 20% chance to teleport a random enemy in front of him, has a system cooldown.".format(abilityIconString(Hero.ROADHOG, Button.ABILITY_1)), 1, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Pig Pen slows the aim of the victim by 75%.".format(abilityIconString(Hero.ROADHOG, Button.ABILITY_2)), 2, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Whole Hog sends Tier 2 Wanna-Be flying backwards when firing.".format(abilityIconString(Hero.ROADHOG, Button.ULTIMATE)), 3, Color.SKY_BLUE]])
    
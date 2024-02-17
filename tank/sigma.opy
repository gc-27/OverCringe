#!mainFile "../main.opy"

rule "Sigma Init":
    @Event eachPlayer
    @Hero sigma

    eventPlayer.moveSpeed -= 25


rule "Sigma Absorption":
    @Event eachPlayer
    @Hero sigma
    @Condition eventPlayer.isUsingAbility1() == true
    
    kill([i for i in [i for i in [i for i in [i for i in [i for i in [player for player in getPlayersInRadius(eventPlayer, 3, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES) if isInLoS(eventPlayer, player, BarrierLos.PASS_THROUGH_BARRIERS)] if not (i.getCurrentHero() == Hero.MAUGA and i.isUsingAbility1())] if not (i.getCurrentHero() == Hero.ORISA and i.isUsingAbility1())] if not i.hasStatusEffect(Status.PHASED_OUT)] if not i.hasStatusEffect(Status.INVINCIBLE)] if not i.hasStatusEffect(Status.UNKILLABLE)], eventPlayer)
    wait(0.25)
    if RULE_CONDITION:
        goto RULE_START


rule "Sigma Accretion":
    @Event playerDealtDamage
    @Hero sigma
    @Condition eventAbility == Button.ABILITY_2
    
    victim.applyImpulse(directionTowards(victim, attacker), 25, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)


rule "Sigma Gravitic Flux":
    @Event eachPlayer
    @Hero sigma
    @Condition eventPlayer.isUsingUltimate() == true
    
    getAllPlayers().gravity -= 1000
    waitUntil(not eventPlayer.isUsingUltimate(), 99999)
    getAllPlayers().gravity += 1000


rule "Sigma Patch Notes":
    @Event eachPlayer
    @Hero sigma
    @Disabled

    eventPlayer.patchNotesData.append([["Base move speed reduced by 25%.", 0, Color.WHITE]])
    eventPlayer.patchNotesData.append([["{} Kinetic Grasp now absorbs enemies, adding their health pool to Sigma's as Overhealth.".format(abilityIconString(Hero.SIGMA, Button.ABILITY_1)), 1, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Cannot affect invincible players, Mauga during Overrun, or Orisa during Fortify.".format(abilityIconString(Hero.SIGMA, Button.ABILITY_1)), 2, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Accretion sends hit enemies towards Sigma.".format(abilityIconString(Hero.SIGMA, Button.ABILITY_2)), 3, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Gravitic Flux turns off gravity for the duration of the ultimate.".format(abilityIconString(Hero.SIGMA, Button.ULTIMATE)), 1, Color.SKY_BLUE]])
    
    
    
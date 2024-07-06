#!mainFile "../main.opy"

rule "Wrecking Ball Roll":
    @Event eachPlayer
    @Hero hammond
    @Condition eventPlayer.isInAlternateForm() == false
    
    eventPlayer.setDamageDealt(125)
    eventPlayer.addHealthPool(Health.ARMOR, 300, true, true)
    eventPlayer.var1 = getLastCreatedHealthPool()
    eventPlayer.moveSpeed -= 50
    waitUntil(eventPlayer.isInAlternateForm(), 99999)
    eventPlayer.moveSpeed += 50
    removeHealthPool(eventPlayer.var1)
    eventPlayer.setDamageDealt(100)


rule "Wrecking Ball Adaptive Shields":
    @Event eachPlayer
    @Hero hammond
    @Condition eventPlayer.isUsingAbility2() == true
    
    getPlayersInRadius(eventPlayer, 10, eventPlayer.getTeam(), LosCheck.SURFACES).addHealthPool(Health.NORMAL, 50, false, false)
    eventPlayer.var2 = getLastCreatedHealthPool()
    wait(8)
    removeHealthPool(eventPlayer.var2)


rule "Wrecking Ball Piledriver":
    @Event playerDealtDamage
    @Hero hammond
    @Condition eventAbility == Button.CROUCH
    
    victim.setStatusEffect(attacker, Status.KNOCKED_DOWN, 1)


rule "Wrecking Ball Patch Notes":
    @Event eachPlayer
    @Hero hammond

    eventPlayer.patchNotesData.append([["Base damage increased by 25%.", 0, Color.WHITE]])
    eventPlayer.patchNotesData.append([["{} No longer has ammo requirement.".format(abilityIconString(eventPlayer.currentHero, Button.PRIMARY_FIRE)), 1, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Move speed in crab form reduced to 50%. Crab form health pool increased by 300 armor.".format(abilityIconString(eventPlayer.currentHero, Button.ABILITY_1)), 2, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Now provides 50 Overhealth to nearby teammates.".format(abilityIconString(eventPlayer.currentHero, Button.ABILITY_2)), 3, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Now knocks opponents he hits down for one second.".format(abilityIconString(eventPlayer.currentHero, Button.CROUCH)), 4, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Knockback increased by 300%".format(abilityIconString(eventPlayer.currentHero, Button.CROUCH)), 5, Color.SKY_BLUE]])
    
    
    
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



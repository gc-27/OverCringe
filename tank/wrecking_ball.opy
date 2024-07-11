#!mainFile "../main.opy"

rule "Wrecking Ball Init":
    @Event eachPlayer
    @Hero hammond
    
    eventPlayer.health_different = true
    eventPlayer.health = 100
    eventPlayer.armor = 400
    eventPlayer.shields = 100
    wait(0.5)
    eventPlayer.forceButtonPress(Button.ABILITY_1)

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

    eventPlayer.hero_description = "I thought he didn't wreck enough."

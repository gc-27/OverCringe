#!mainFile "../main.opy"

rule "Wrecking Ball Init":
    @Event eachPlayer
    @Hero hammond
    
    eventPlayer.health_different = true
    eventPlayer.health = 100
    eventPlayer.armor = 400
    eventPlayer.shields = 100


rule "Wrecking Ball Roll":
    @Event eachPlayer
    @Hero hammond
    @Condition eventPlayer.isInAlternateForm() == false
    
    eventPlayer.setDamageDealt(125)
    eventPlayer.setDamageReceived(75)
    eventPlayer.moveSpeed -= 50
    waitUntil(eventPlayer.isInAlternateForm(), 99999)
    eventPlayer.moveSpeed += 50
    eventPlayer.setDamageDealt(100)
    eventPlayer.setDamageReceived(75)


rule "Wrecking Ball Adaptive Shields":
    @Event eachPlayer
    @Hero hammond
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer.setJumpVerticalSpeed(175)
    waitUntil(not eventPlayer.isUsingAbility2(), 8)
    eventPlayer.setJumpVerticalSpeed(100)


rule "Wrecking Ball Piledriver":
    @Event playerDealtDamage
    @Hero hammond
    @Condition eventAbility == Button.CROUCH
    
    victim.setStatusEffect(attacker, Status.KNOCKED_DOWN, 1)


rule "Wrecking Ball Patch Notes":
    @Event eachPlayer
    @Hero hammond

    eventPlayer.hero_description = "I thought he didn't wreck enough."

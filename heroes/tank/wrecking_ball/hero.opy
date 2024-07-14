#!mainFile "../../../main.opy"


rule "Wrecking Ball Init":
    @Event eachPlayer
    @Hero hammond
    
    set_health_pool(eventPlayer, 100, 400, 100)


rule "Wrecking Ball Roll":
    @Event eachPlayer
    @Hero hammond
    @Condition eventPlayer.isInAlternateForm() == false
    
    eventPlayer.setDamageDealt(125)
    eventPlayer.setDamageReceived(75)
    eventPlayer.move_speed -= 50
    waitUntil(eventPlayer.isInAlternateForm(), 99999)
    eventPlayer.move_speed += 50
    eventPlayer.setDamageDealt(100)
    eventPlayer.setDamageReceived(75)


rule "Wrecking Ball Adaptive Shields":
    @Event eachPlayer
    @Hero hammond
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer.setJumpVerticalSpeed(175)
    waitUntil(not eventPlayer.isUsingAbility2(), 8)
    eventPlayer.setJumpVerticalSpeed(100)


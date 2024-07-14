#!mainFile "../../../main.opy"


rule "Reinhardt Init":
    @Event eachPlayer
    @Hero reinhardt

    set_health_pool(eventPlayer, 300, 250, 0)

rule "Reinhardt Charge":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.isUsingAbility1()
    
    eventPlayer.setDamageDealt(500)
    eventPlayer.move_speed -= 90
    waitUntil(not eventPlayer.isUsingAbility1(), 9999)
    wait()
    eventPlayer.setDamageDealt(100)
    eventPlayer.move_speed += 90

rule "Reinhardt Fire Strike":
    @Event playerDealtDamage
    @Hero reinhardt
    @Condition eventAbility == Button.ABILITY_2

    heal(eventPlayer, eventPlayer, eventDamage)

rule "Reinhardt Earthshatter":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.isUsingUltimate()
    
    [player for player in getAllPlayers() if player.isOnGround()].setStatusEffect(eventPlayer, Status.KNOCKED_DOWN, 3)
    damage([player for player in getAllPlayers() if player.isOnGround()], eventPlayer, 50)
    eventPlayer.setEnvironmentalKillCreditor([player for player in getAllPlayers() if player.isOnGround()])

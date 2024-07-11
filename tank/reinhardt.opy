#!mainFile "../main.opy"

rule "Reinhardt Init":
    @Event eachPlayer
    @Hero reinhardt

    eventPlayer.health_different = true
    eventPlayer.health = 300
    eventPlayer.armor = 250

rule "Reinhardt Charge":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.isUsingAbility1()
    
    eventPlayer.setDamageDealt(500)
    eventPlayer.moveSpeed -= 135
    waitUntil(not eventPlayer.isUsingAbility1(), 9999)
    wait()
    eventPlayer.setDamageDealt(100)
    eventPlayer.moveSpeed += 135

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


rule "Reinhardt Patch Notes":
    @Event eachPlayer
    @Hero reinhardt

    eventPlayer.hero_description = "If only he had this armor during the crisis..."

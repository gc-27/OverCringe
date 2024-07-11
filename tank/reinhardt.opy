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
    eventPlayer.patchNotesData.append([["Base move speed increased by 50%.", 0, Color.WHITE]])
    eventPlayer.patchNotesData.append([["{} Charge deals 400% more damage. Moves 90% slower.".format(abilityIconString(Hero.REINHARDT, Button.ABILITY_1)), 1, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Fire Strike now has 100% lifesteal.".format(abilityIconString(Hero.REINHARDT, Button.ABILITY_2)), 2, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Earthshatter now stuns everyone on the ground when it hits.".format(abilityIconString(Hero.REINHARDT, Button.ULTIMATE)), 3, Color.SKY_BLUE]])
    
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
    eventPlayer.moveSpeed -= 90
    waitUntil(not eventPlayer.isUsingAbility1(), 9999)
    wait()
    eventPlayer.setDamageDealt(100)
    eventPlayer.moveSpeed += 90

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
    eventPlayer.hero_general_changes[1] = "Move speed increased by 50%."

    eventPlayer.weapon_names[0] = "Rocket Hammer"
    eventPlayer.weapon_names[1] = "Barrier Field"
    eventPlayer.weapon_names[2] = "Charge"
    eventPlayer.weapon_names[3] = "Fire Strike"
    eventPlayer.weapon_names[5] = "Earthshatter"

    eventPlayer.patchNotes[3] = ["Move Speed while active reduced to 10%.", "Damage dealt increased by 400%."]
    eventPlayer.patchNotes[4] = ["Dealing damage will heal Reinhardt for 100% of the damage."]
    eventPlayer.patchNotes[5] = ["Stuns everyone on the ground when it hits.", "I mean, everyone. Literaly everyone."]
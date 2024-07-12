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

    eventPlayer.weapon_names[0] = "Quad Cannons"
    eventPlayer.weapon_names[1] = "Grappling Claw"
    eventPlayer.weapon_names[2] = "Roll"
    eventPlayer.weapon_names[3] = "Adaptive Shield"
    eventPlayer.weapon_names[4] = "Piledriver"
    eventPlayer.weapon_names[5] = "Minefield"

    eventPlayer.patchNotes[0] = ["No longer requires ammo.", "Damage increased by 25%."]
    eventPlayer.patchNotes[2] = ["Move speed in mech form reduced by 50%.", "Mech form grants a 25% damage resistance."]
    eventPlayer.patchNotes[3] = ["Jump height while active increased by 75%."]
    eventPlayer.patchNotes[4] = ["Knocks down hit opponents for one second."]
    eventPlayer.patchNotes[5] = ["Mine knockback increased by 300%."]


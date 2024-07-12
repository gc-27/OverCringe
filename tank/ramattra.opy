#!mainFile "../main.opy"

rule "Ramattra Init":
    @Event eachPlayer
    @Hero ramattra

    eventPlayer.health_different = true
    eventPlayer.health = 200
    eventPlayer.armor = 250

rule "Ramattra Void Barrier":
    @Event eachPlayer
    @Hero ramattra
    @Condition eventPlayer.isFiringSecondaryFire() == true
    @Condition eventPlayer.isUsingAbility1() != true
    @Condition eventPlayer.isUsingUltimate() != true
    @Condition eventPlayer.isMoving() == true
    
    eventPlayer.moveSpeed += 50
    waitUntil(not eventPlayer.isFiringSecondaryFire(), 99999)
    eventPlayer.moveSpeed -= 50


rule "Ramattra Nemesis Form":
    @Event eachPlayer
    @Hero ramattra
    @Condition eventPlayer.isUsingAbility1() == true
    
    eventPlayer.setJumpVerticalSpeed(300)
    waitUntil(not eventPlayer.isUsingAbility1(), 8)
    eventPlayer.setJumpVerticalSpeed(100)


rule "Ramattra Ravenous Vortex":
    @Event playerDealtDamage
    @Hero ramattra
    @Condition eventAbility == Button.ABILITY_2
    
    victim.startAcceleration(Vector.UP, 500, 60, Relativity.TO_PLAYER, AccelReeval.DIRECTION_RATE_AND_MAX_SPEED)
    wait(1)
    victim.stopAcceleration()


rule "Ramattra Annihilation":
    @Event eachPlayer
    @Hero ramattra
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.moveSpeed -= 50
    eventPlayer.setDamageDealt(300)
    eventPlayer.setPrimaryFireEnabled(false)
    eventPlayer.setAbility2Enabled(false)
    eventPlayer.addHealthPool(Health.ARMOR, 250, true, true)
    waitUntil(not eventPlayer.isUsingUltimate(), 99999)
    eventPlayer.moveSpeed += 50
    eventPlayer.setDamageDealt(100)
    eventPlayer.setPrimaryFireEnabled(true)
    eventPlayer.setAbility2Enabled(true)
    removeHealthPool(getLastCreatedHealthPool())


rule "Ramattra Patch Notes":
    @Event eachPlayer
    @Hero ramattra

    eventPlayer.hero_description = "Now Ram is truly a dive tank!"
    eventPlayer.weapon_names[0] = "Void Accelerator (Omnic Form)"
    eventPlayer.weapon_names[1] = "Void Barrier (Omnic Form)"
    eventPlayer.weapon_names[2] = "Nemesis Form"
    eventPlayer.weapon_names[3] = "Ravenous Vortex"
    eventPlayer.weapon_names[5] = "Annihilation"

    eventPlayer.patchNotes[1] = ["Holding right click to create a barrier will grant Ramattra a 50% speed boost."]
    eventPlayer.patchNotes[2] = ["Jump Height while in Nemesis Form increased by 200%."]
    eventPlayer.patchNotes[3] = ["Now sends enemies upward.", "Enemies are slingshotted up at the end of the vortex."]
    eventPlayer.patchNotes[5] = ["Movement speed in Annihilation reduced by 50%.", "Grants Ramattra an additional 250 armor.", "Pummel and Ravenous Vortex are disabled while in use.", "Damage dealt increased by 200%.", "Duration increased to 6 seconds."]

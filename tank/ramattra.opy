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

    eventPlayer.hero_description = "Ramattra is a very situational hero. I think he should be viable in ALL of them."

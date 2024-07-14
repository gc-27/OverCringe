#!mainFile "../../../main.opy"


rule "Ramattra Init":
    @Event eachPlayer
    @Hero ramattra

    set_health_pool(eventPlayer, 200, 0, 250)

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
    removeHealthPool(eventPlayer.health_pools[2])
    waitUntil(not eventPlayer.isUsingAbility1(), 10)
    eventPlayer.addHealthPool(Health.SHIELDS, 250, true, true)
    eventPlayer.health_pools[2] = getLastCreatedHealthPool()

    eventPlayer.setJumpVerticalSpeed(100)


rule "Ramattra Ravenous Vortex":
    @Event playerDealtDamage
    @Hero ramattra
    @Condition eventAbility == Button.ABILITY_2
    
    victim.applyImpulse(Vector.UP, 20, Relativity.TO_PLAYER, Impulse.CANCEL_CONTRARY_MOTION)


rule "Ramattra Annihilation":
    @Event eachPlayer
    @Hero ramattra
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.moveSpeed -= 50
    eventPlayer.setDamageDealt(300)

    eventPlayer.setPrimaryFireEnabled(false)
    eventPlayer.setAbility2Enabled(false)

    removeHealthPool(eventPlayer.health_pools[1])
    removeHealthPool(eventPlayer.health_pools[2])
    eventPlayer.addHealthPool(Health.ARMOR, 250, true, true)
    eventPlayer.health_pools[1] = getLastCreatedHealthPool()

    waitUntil(not eventPlayer.isUsingUltimate(), 99999)


    eventPlayer.addHealthPool(Health.SHIELDS, 250, true, true)
    eventPlayer.health_pools[2] = getLastCreatedHealthPool()
    removeHealthPool(eventPlayer.health_pools[1])

    eventPlayer.moveSpeed += 50
    eventPlayer.setDamageDealt(100)

    eventPlayer.setPrimaryFireEnabled(true)
    eventPlayer.setAbility2Enabled(true)

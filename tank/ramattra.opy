#!mainFile "../main.opy"


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
    @Event playerTookDamage
    @Condition eventAbility == Button.ABILITY_2
    @Condition attacker.getCurrentHero() == Hero.RAMATTRA
    
    victim.gravity -= 100
    victim.applyImpulse(Vector.UP, 25, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    wait(1)
    victim.gravity += 100


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

    eventPlayer.patchNotesData.append([["{} Void Barrier grants a 50% speed buff while holding his hand out.".format(abilityIconString(Hero.RAMATTRA, Button.SECONDARY_FIRE)), 0, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Nemesis Form grants a 200% jump height increase while active.".format(abilityIconString(Hero.RAMATTRA, Button.ABILITY_1)), 1, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Ravenous Vortex sends enemies sky high.".format(abilityIconString(Hero.RAMATTRA, Button.ABILITY_2)), 2, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Annihilation reduces move speed by 50%. Can only melee and block.".format(abilityIconString(Hero.RAMATTRA, Button.ULTIMATE)), 3, Color.SKY_BLUE]])
    eventPlayer.patchNotesData.append([["{} Damage dealt by tendrils and melee increased 3x.".format(abilityIconString(Hero.RAMATTRA, Button.ULTIMATE)), 4, Color.SKY_BLUE]])
    


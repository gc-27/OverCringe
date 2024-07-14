#!mainFile "../../../main.opy"


rule "D.Va init":
    @Event eachPlayer
    @Hero dva
    
    set_health_pool(eventPlayer, 175, 425, 0)


rule "D.Va matrix infinity":
    @Event eachPlayer
    @Hero dva
    @Condition eventPlayer.isFiringSecondaryFire()

    eventPlayer.var1 = 0
    while eventPlayer.isFiringSecondaryFire():
        eventPlayer.setAbilityResource(Button.SECONDARY_FIRE, 100)
        eventPlayer.var1 -= 0.1
        eventPlayer.move_speed -= 0.1
        wait()
    eventPlayer.move_speed -= eventPlayer.var1
    eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 10)


rule "D.Va Self Destruct":
    @Event playerDealtFinalBlow
    @Hero dva
    @Condition eventAbility == Button.ULTIMATE

    wait(1)
    if eventPlayer.isInAlternateForm():
        getPlayers(eventPlayer.getTeam()).addHealthPool(Health.NORMAL, 50, false, false)
    

rule "D.Va demech":
    @Event eachPlayer
    @Hero dva
    @Condition eventPlayer.isInAlternateForm()

    eventPlayer.removeAllHealthPools()
    waitUntil(not eventPlayer.isInAlternateForm(), 99999)
    set_player_health()

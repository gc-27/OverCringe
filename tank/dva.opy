#!mainFile "../main.opy"

rule "D.Va init":
    @Event eachPlayer
    @Hero dva
    
    eventPlayer.health_different = true
    eventPlayer.health = 175
    eventPlayer.armor = 425


rule "D.Va matrix infinity":
    @Event eachPlayer
    @Hero dva
    @Condition eventPlayer.isFiringSecondaryFire()

    eventPlayer.var1 = 0
    while eventPlayer.isFiringSecondaryFire():
        eventPlayer.setAbilityResource(Button.SECONDARY_FIRE, 100)
        eventPlayer.var1 -= 0.1
        eventPlayer.moveSpeed -= 0.1
        wait()
    eventPlayer.moveSpeed -= eventPlayer.var1
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

rule "D.Va patch notes":
    @Event eachPlayer
    @Hero dva
    @Condition not eventPlayer.isInAlternateForm()

    eventPlayer.hero_description = "This hopefully addresses the issue of D.Va dealing too much damage."

    eventPlayer.weapon_names[0] = "Fusion Cannons"
    eventPlayer.weapon_names[1] = "Defense Matrix"
    eventPlayer.weapon_names[2] = "Boosters"
    eventPlayer.weapon_names[3] = "Micro Missiles"
    eventPlayer.weapon_names[5] = "Self Destruct"

    eventPlayer.patchNotes[1] = ["Now lasts indefinitely.", "Now has a 10 second cooldown.", "Slowly reduces move speed while in use."]
    eventPlayer.patchNotes[5] = ["Eliminating enemies with Self Destruct", " will grant your team 50 overhealth."]
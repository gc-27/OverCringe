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

    getPlayers(eventPlayer.getTeam()).addHealthPool(Health.NORMAL, 50, false, false)

rule "D.Va patch notes":
    @Event eachPlayer
    @Hero dva
    @Condition not eventPlayer.isInAlternateForm()

    eventPlayer.hero_description = "This hopefully addresses the issue of D.Va dealing too much damage."
    eventPlayer.patchNotes[1] = ["Now lasts indefinitely.", "Now has a 10 second cooldown.", "Slowly reduces move speed while in use."]
    eventPlayer.patchNotes[5] = ["Eliminating enemies with Self Destruct or Call Mech", " will grant your team 50 overhealth."]
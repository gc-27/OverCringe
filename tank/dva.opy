#!mainFile "../main.opy"

rule "D.Va matrix infinity":
    @Event eachPlayer
    @Hero dva
    @Condition eventPlayer.isFiringSecondaryFire()

    do:
        eventPlayer.setAbilityResource(Button.SECONDARY_FIRE, 100)
        wait()


    while RULE_CONDITION
    eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 10)

rule "D.Va Fusion Cannons":
    @Event eachPlayer
    @Hero dva
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE)
    @Condition not eventPlayer.isInAlternateForm()

    kill(eventPlayer, null)


rule "D.Va Self Destruct":
    @Event playerDealtFinalBlow
    @Hero dva
    @Condition eventAbility == Button.ULTIMATE

    getPlayers(eventPlayer.getTeam()).addHealthPool(Health.NORMAL, 50, false, false)

rule "D.Va patch notes":
    @Event eachPlayer
    @Hero dva
    @Disabled

    eventPlayer.patchNotesData.append([["{} Fusion Cannons now instantly de-mechs D.Va.".format(abilityIconString(Hero.DVA, Button.PRIMARY_FIRE)), 0, Color.WHITE]])
    eventPlayer.patchNotesData.append([["{} Defense Matrix now lasts indefinitely, with a ten second cooldown.".format(abilityIconString(Hero.DVA, Button.SECONDARY_FIRE)), 1, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Eliminating enemies with an ultimate will now grant your team 50 overhealth.".format(abilityIconString(Hero.DVA, Button.ULTIMATE)), 2, Color.SKY_BLUE]])
    
#!mainFile "../../../main.opy"


rule "Genji Init":
    @Event eachPlayer
    @Hero genji
    
    set_health_pool(eventPlayer, 150, 50, 0)

rule "Genji Swift Strike":
    @Event eachPlayer
    @Hero genji
    @Condition eventPlayer.isUsingAbility1()

    eventPlayer.setDamageReceived(50)
    waitUntil(not eventPlayer.isUsingAbility1(), 1)
    eventPlayer.setDamageReceived(100)

rule "Genji Swift Strike Damage":
    @Event playerDealtDamage
    @Hero genji
    @Condition eventAbility == Button.ABILITY_1

    victim.startDoT(attacker, 2, 25)

rule "Genji Deflect during Blade":
    @Event eachPlayer
    @Hero genji
    @Condition eventPlayer.isUsingUltimate()
    @Condition eventPlayer.isUsingAbility2()

    waitUntil(not eventPlayer.isUsingAbility2(), 4)
    waitUntil(eventPlayer.getAbilityCooldown(Button.ABILITY_2) != 0, 1)
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0)

rule "Genji Deflect Heal":
    @Event playerDealtDamage
    @Hero genji
    @Condition eventAbility == Button.ABILITY_2

    heal(eventPlayer, eventPlayer, eventDamage/2)

rule "Genji Blade":
    @Event eachPlayer
    @Hero genji
    @Condition eventPlayer.isUsingUltimate()

    eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0)

#!mainFile "../../../main.opy"


rule "Ashe Init":
    @Event eachPlayer
    @Hero ashe
    
    set_health_pool(eventPlayer, 175, 0, 0)

rule "Ashe Headhunter":
    @Event playerEarnedElimination
    @Hero ashe
    
    waitUntil(not eventPlayer.isUsingAbility1(), 1)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, eventPlayer.getAbilityCooldown(Button.ABILITY_1) - 2)

rule "Ashe Dynamite":
    @Event playerTookDamage
    @Condition attacker.currentHero == Hero.ASHE
    @Condition eventAbility == Button.ABILITY_2
    @Condition eventDamage >= 10

    if not victim.ccimmune:
        victim.applyImpulse(Vector.UP, 5, Relativity.TO_PLAYER, Impulse.INCORPORATE_CONTRARY_MOTION)
        victim.applyImpulse(eventDirection, 5 if victim.currentHero in getTankHeroes() else 10, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)

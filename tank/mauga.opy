#!mainFile "../main.opy"

rule "Mauga Init":
    @Event eachPlayer
    @Hero mauga

    eventPlayer.health_different = true
    eventPlayer.health = 400
    eventPlayer.armor = 200

rule "Mauga Overrun Usage":
    @Event eachPlayer
    @Hero mauga
    @Condition eventPlayer.isUsingAbility1()
    
    wait(0.71)
    eventPlayer.ccimmune = true
    waitUntil(not eventPlayer.isUsingAbility1(), 4)
    eventPlayer.ccimmune = false

rule "Mauga Overrun":
    @Event eachPlayer
    @Condition getPlayersOnHero(Hero.MAUGA, getOppositeTeam(eventPlayer.getTeam())).isUsingAbility1()
    @Condition distance(eventPlayer, getPlayersOnHero(Hero.MAUGA, getOppositeTeam(eventPlayer.getTeam()))) <= 5

    eventPlayer.setStatusEffect(getPlayersOnHero(Hero.MAUGA, getOppositeTeam(eventPlayer.getTeam())), Status.BURNING, 4)
    eventPlayer.startDoT(getPlayersOnHero(Hero.MAUGA, getOppositeTeam(eventPlayer.getTeam())), 4, 25)
    wait(4)

rule "Mauga Cardiac Overdrive":
    @Event eachPlayer
    @Hero mauga
    @Condition eventPlayer.isUsingAbility2()

    eventPlayer.moveSpeed += 25
    waitUntil(not eventPlayer.isUsingAbility2(), 8)
    if eventPlayer.var1 < 200:
        if not eventPlayer.isDead():
            if eventPlayer.isUsingAbility1():
                eventPlayer.cancelPrimaryAction()
            eventPlayer.setStatusEffect(null, Status.STUNNED, 5)
            eventPlayer.startDoT(null, 5, 50)
    eventPlayer.var1 = 0
    eventPlayer.moveSpeed -= 25
    
rule "Mauga Cardiac Overdrive damage":
    @Event playerDealtDamage
    @Hero mauga
    @Condition eventPlayer.isUsingAbility2()

    eventPlayer.var1 += eventDamage

rule "Mauga Cage Fight":
    @Event eachPlayer
    @Hero mauga
    @Condition eventPlayer.isUsingUltimate()

    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 8)

    disable_abilities()
    disable_inputs()

    eventPlayer.setStatusEffect(null, Status.ROOTED, 8)
    while eventPlayer.isUsingUltimate():
        if eventPlayer.isOnGround():
            if not eventPlayer.isCommunicatingEmote():
                eventPlayer.communicate(Comms.EMOTE_UP)
        wait()
    eventPlayer.clearStatusEffect(Status.PHASED_OUT)


    enable_abilities()
    enable_inputs()

    eventPlayer.cancelPrimaryAction()


rule "Mauga Patch Notes":
    @Event eachPlayer
    @Hero mauga

    eventPlayer.hero_description = "He's been struggling recently. He misses Baptiste."
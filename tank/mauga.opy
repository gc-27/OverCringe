#!mainFile "../main.opy"

rule "Mauga Overrun":
    @Event eachPlayer
    @Hero mauga
    @Condition eventPlayer.isUsingAbility1()

    wait(0.21)
    waitUntil(eventPlayer.isHoldingButton(Button.JUMP), 2)
    wait(0.6)
    if not eventPlayer.isUsingAbility1():
        return
    if ([player for player in getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())) if player.hasSpawned() and not player.isInSpawnRoom()]) != []:
        eventPlayer.teleport((random.choice([player for player in getLivingPlayers(getOppositeTeam(eventPlayer.getTeam())) if player.hasSpawned() and not player.isInSpawnRoom()])).getPosition())


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

    eventPlayer.setDamageReceived(0)
    eventPlayer.setKnockbackReceived(0)
    eventPlayer.setMaxHealth(1000)
    wait()
    eventPlayer.setHealth(1000000)

    disable_abilities()
    disable_inputs()

    eventPlayer.setStatusEffect(null, Status.ROOTED, 8)
    while eventPlayer.isUsingUltimate():
        if not eventPlayer.isCommunicatingEmote():
            eventPlayer.communicate(Comms.EMOTE_UP)
        wait(0)
    eventPlayer.clearStatusEffect(Status.ROOTED)

    eventPlayer.setDamageReceived(100)
    eventPlayer.setKnockbackReceived(100)
    eventPlayer.setMaxHealth(100)

    enable_abilities()
    enable_inputs()

    eventPlayer.forceButtonPress(Button.JUMP)



rule "Mauga Patch Notes":
    @Event eachPlayer
    @Hero mauga
    @Disabled

    eventPlayer.patchNotesData.append([["{} Overrun now teleports Mauga to a random person when he stomps.".format(abilityIconString(Hero.MAUGA, Button.ABILITY_1)), 0, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Cardiac Overdrive now gives Mauga a heart attack if he doesn't deal 200 damage while active.".format(abilityIconString(Hero.MAUGA, Button.ABILITY_2)), 1, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Cardiac Overdrive Increases Mauga's move speed by 25% while active.".format(abilityIconString(Hero.MAUGA, Button.ABILITY_2)), 2, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Disables all of Mauga's inputs, forces him to emote, and makes him invulnerable.".format(abilityIconString(Hero.MAUGA, Button.ULTIMATE)), 3, Color.SKY_BLUE]])
    
    
    

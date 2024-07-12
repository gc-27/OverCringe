#!mainFile "../main.opy"

rule "Spawn Dummy Bots":
    @Event global
    @Condition debug
    @Condition hostPlayer.isHoldingButton(Button.INTERACT)
    @Disabled
    
    createDummy(Hero.LIFEWEAVER, getOppositeTeam(hostPlayer.getTeam()), -1, hostPlayer.getPosition(), hostPlayer.getFacingDirection())
    #getLastCreatedEntity().startForcingButton(Button.PRIMARY_FIRE)

rule "Display server performance characteristics":
    @Condition debug
    hudSubheader(getAllPlayers(), l"{0}: {1}".format(l"Server Load", l"{0}%".format(getServerLoad())), HudPosition.RIGHT, -1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers(), l"{0}: {1}".format(l"Server Load Average", l"{0}%".format(getAverageServerLoad())), HudPosition.RIGHT, -0.9, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    hudSubheader(getAllPlayers(), l"{0}: {1}".format(l"Server Load Peak", l"{0}%".format(getPeakServerLoad())), HudPosition.RIGHT, -0.8, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)



    
rule "Dummy bot died - Delete":
    @Event playerDied
    @Condition debug
    @Condition eventPlayer.isDummy()


    destroyDummy(eventPlayer.getTeam(), eventPlayer.getSlot())

rule "Ultimate charge if debug mode":
    @Event eachPlayer
    @Condition debug
    @Condition eventPlayer.getUltCharge() != 100

    waitUntil(eventPlayer.hasSpawned(), 1000)
    eventPlayer.setUltCharge(100)

rule "Debug":
    @Event global
    @Condition debug

    hudText(getAllPlayers(), "Health: {} \nArmor: {} \nShields: {}".format(
        localPlayer.getHealthOfType(Health.NORMAL), 
        localPlayer.getHealthOfType(Health.ARMOR), 
        localPlayer.getHealthOfType(Health.SHIELDS)
        ), null, null, HudPosition.RIGHT, 0, Color.WHITE, null, null, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.ALWAYS)
    hudText(getAllPlayers(), "Firing Primary: {} \n Firing Secondary: {} \n Using Ability 1: {} \n Using Ability 2: {} \n Using Ultimate: {}".format(
        localPlayer.isFiringPrimaryFire(),
        localPlayer.isFiringSecondaryFire(),
        localPlayer.isUsingAbility1(),
        localPlayer.isUsingAbility2(),
        localPlayer.isUsingUltimate()
    ), null, null, HudPosition.RIGHT, 0, Color.WHITE, null, null, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.ALWAYS)

    
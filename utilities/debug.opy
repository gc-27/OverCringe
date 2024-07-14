#!mainFile "../main.opy"

globalvar debug = createWorkshopSetting(bool, "DEVELOPMENT", "DEBUG", true, 0)
rule "Global Init":
    @Event global

    if debug:
        pass
    else:
        disableInspector()

rule "Spawn Dummy Bots":
    @Event global
    @Condition debug
    @Condition hostPlayer.isHoldingButton(Button.INTERACT)
    @Condition not hostPlayer.isInSpawnRoom()
    
    createDummy(Hero.ASHE, getOppositeTeam(hostPlayer.getTeam()), -1, hostPlayer.getPosition(), hostPlayer.getFacingDirection())
    #createDummy(Hero.DOOMFIST, getOppositeTeam(hostPlayer.getTeam()), -1, hostPlayer.getPosition(), hostPlayer.getFacingDirection())
    #createDummy(Hero.DOOMFIST, getOppositeTeam(hostPlayer.getTeam()), -1, hostPlayer.getPosition(), hostPlayer.getFacingDirection())
    #createDummy(Hero.DOOMFIST, getOppositeTeam(hostPlayer.getTeam()), -1, hostPlayer.getPosition(), hostPlayer.getFacingDirection())
    #createDummy(Hero.DOOMFIST, getOppositeTeam(hostPlayer.getTeam()), -1, hostPlayer.getPosition(), hostPlayer.getFacingDirection())
    #createDummy(Hero.DOOMFIST, hostPlayer.getTeam(), -1, hostPlayer.getPosition(), hostPlayer.getFacingDirection())
    #createDummy(Hero.DOOMFIST, hostPlayer.getTeam(), -1, hostPlayer.getPosition(), hostPlayer.getFacingDirection())
    #createDummy(Hero.DOOMFIST, hostPlayer.getTeam(), -1, hostPlayer.getPosition(), hostPlayer.getFacingDirection())
    #createDummy(Hero.DOOMFIST, hostPlayer.getTeam(), -1, hostPlayer.getPosition(), hostPlayer.getFacingDirection())
    #createDummy(Hero.DOOMFIST, hostPlayer.getTeam(), -1, hostPlayer.getPosition(), hostPlayer.getFacingDirection())
    #damage(hostPlayer, getPlayers(Team.2), 50)

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

    wait()
    eventPlayer.setUltCharge(100)
    if RULE_CONDITION:
        goto RULE_START

rule "Debug":
    @Event global
    @Condition debug

    hudHeader(getAllPlayers(), "Health: {} \nArmor: {} \nShields: {}".format(
        localPlayer.getHealthOfType(Health.NORMAL), 
        localPlayer.getHealthOfType(Health.ARMOR), 
        localPlayer.getHealthOfType(Health.SHIELDS)
        ), HudPosition.RIGHT, 0, Color.WHITE, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.ALWAYS)
    hudHeader(getAllPlayers(), "Throttle: {}".format(localPlayer.getThrottle()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR)
    hudHeader(getAllPlayers(), "Firing Primary: {}\n Firing Secondary: {}\n Using Ability 1: {}\n Using Ability 2: {}\n Using Ultimate: {}\nJumping: {}\nCrouching:{}".format(
        localPlayer.isFiringPrimaryFire(),
        localPlayer.isFiringSecondaryFire(),
        localPlayer.isUsingAbility1(),
        localPlayer.isUsingAbility2(),
        localPlayer.isUsingUltimate(),
        localPlayer.isJumping(),
        localPlayer.isCrouching()
    ), HudPosition.RIGHT, 0, Color.WHITE, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.ALWAYS)

rule "Debug World Text":
    @Event eachPlayer
    @Condition debug

    createInWorldText(getAllPlayers(), eventPlayer.getHealth(), eventPlayer.getEyePosition() + vect(0, 0.5, 0), 1, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE,  SpecVisibility.ALWAYS)
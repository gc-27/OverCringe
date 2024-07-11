#!mainFile "../main.opy"

rule "Sigma Init":
    @Event eachPlayer
    @Hero sigma

    eventPlayer.health_different = true
    eventPlayer.health = 300
    eventPlayer.shields = 250

rule "Sigma movement":
    @Event eachPlayer
    @Hero sigma
    @Condition eventPlayer.getThrottle() != vect(0,0,0) or eventPlayer.isHoldingButton(Button.JUMP) or eventPlayer.isHoldingButton(Button.CROUCH)
    @Condition eventPlayer.canUseAbilities

    eventPlayer.startAcceleration(eventPlayer.getThrottle() + vect(0, eventPlayer.isHoldingButton(Button.JUMP) - eventPlayer.isHoldingButton(Button.CROUCH), 0), 25, 5.5, Relativity.TO_PLAYER, AccelReeval.DIRECTION_RATE_AND_MAX_SPEED)

rule "Cancel Sigma Movement":
    @Event eachPlayer
    @Hero sigma
    @Condition not (eventPlayer.getThrottle() != vect(0,0,0) or eventPlayer.isHoldingButton(Button.JUMP) or eventPlayer.isHoldingButton(Button.CROUCH))
   
    eventPlayer.stopAcceleration()


rule "Sigma Grounded on stunned":
    @Event eachPlayer
    @Hero sigma
    @Condition not eventPlayer.canUseAbilities

    
    eventPlayer.gravity += 100

rule "Sigma Ungrounded when unstunned":
    @Event eachPlayer
    @Hero sigma
    @Condition eventPlayer.canUseAbilities
    
    eventPlayer.gravity -= 100


rule "Sigma Accretion":
    @Event playerDealtDamage
    @Hero sigma
    @Condition eventAbility == Button.ABILITY_2
    
    victim.applyImpulse(directionTowards(victim, attacker), 25, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)

rule "Sigma Kinetic Grasp":
    @Event eachPlayer
    @Hero sigma
    @Condition eventPlayer.isUsingAbility1()
    @Condition ([player for player in getPlayersInRadius(eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 2, 3, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES) if not player.ccimmune])
    @Condition not eventPlayer.var1
    
    eventPlayer.var1 = ([player for player in getPlayersInRadius(eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 2, 3, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES) if not player.ccimmune])[0]
    eventPlayer.var1.setStatusEffect(eventPlayer, Status.ROOTED, 4)
    eventPlayer.var1.disablePlayerCollision()
    eventPlayer.var1.startAcceleration(directionTowards(eventPlayer.var1, eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 2 - vect(0,1.5,0)), 1000, 5, Relativity.TO_WORLD, AccelReeval.DIRECTION_RATE_AND_MAX_SPEED)
    eventPlayer.var1.setEnvironmentalKillCreditor(eventPlayer)
    waitUntil(not eventPlayer.isUsingAbility1(), 4)
    eventPlayer.var1.enablePlayerCollision()
    eventPlayer.var1.stopAcceleration()
    eventPlayer.var1.clearStatusEffect(Status.ROOTED)
    eventPlayer.var1 = null

rule "Sigma Gravitic Flux Bounce":
    @Event playerDealtDamage
    @Hero sigma
    @Condition eventAbility == Button.ULTIMATE
    
    victim.applyImpulse(Vector.UP, 50, Relativity.TO_PLAYER, Impulse.CANCEL_CONTRARY_MOTION_XYZ)

rule "Sigma Patch Notes":
    @Event eachPlayer
    @Hero sigma

    eventPlayer.hero_description = "Seriously, what is that melody?"
    eventPlayer.patchNotesData.append([["No longer affected by gravity.", 0, Color.WHITE]])
    eventPlayer.patchNotesData.append([["{} Will now pull a closeby enemy in front of Sigma, allowing him to move them during the duration of the ability.".format(abilityIconString(Hero.SIGMA, Button.ABILITY_1)), 1, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Accretion sends hit enemies towards Sigma.".format(abilityIconString(Hero.SIGMA, Button.ABILITY_2)), 3, Color.YELLOW]])
    eventPlayer.patchNotesData.append([["{} Enemies now bounce upon landing.".format(abilityIconString(Hero.SIGMA, Button.ULTIMATE)), 1, Color.SKY_BLUE]])
    
    
    
#!mainFile "../../../main.opy"


rule "Junker Queen Init":
    @Event eachPlayer
    @Hero junkerQueen

    eventPlayer.setProjectileSpeed(0)
    set_health_pool(eventPlayer, 400, 100, 0)


rule "Junker Queen Jagged Blade ":
    @Event eachPlayer
    @Condition eventPlayer.isFiringSecondaryFire()
    @Hero junkerQueen
    
    eventPlayer.chase_var_1 = eventPlayer.getEyePosition()
    chase(eventPlayer.chase_var_1, evalOnce(raycast(eventPlayer.getPosition(), eventPlayer.getPosition() + Vector.DOWN, null, null, false).getHitPosition()), rate=5, ChaseReeval.DESTINATION_AND_RATE)
    waitUntil(eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) <= 2.0 or eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) and eventPlayer.canUseAbilities, 4)
    eventPlayer.chase_var_2 = eventPlayer.getPosition()
    chase(eventPlayer.chase_var_2, eventPlayer.chase_var_1, rate=50, ChaseReeval.DESTINATION_AND_RATE)
    eventPlayer.startForcingPosition(eventPlayer.chase_var_2, true)
    waitUntil(eventPlayer.chase_var_2 == eventPlayer.chase_var_1, 99999)
    #wait(0.1)
    eventPlayer.stopForcingPosition()
    stopChasingVariable(eventPlayer.chase_var_1)
    stopChasingVariable(eventPlayer.chase_var_2)


rule "Junker Queen Jagged Blade Damage":
    @Event playerDealtDamage
    @Condition eventAbility == Button.SECONDARY_FIRE
    @Condition eventDamage >= 40
    @Hero junkerQueen

    eventPlayer.chase_var_1 = victim
    
rule "Junker Queen Commanding Shout":
    @Event eachPlayer
    @Hero junkerQueen
    @Condition eventPlayer.isUsingAbility1()

    eventPlayer.var1 = getPlayersInRadius(eventPlayer, 10, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES_AND_ENEMY_BARRIERS)
    for eventPlayer.counter in range(0, len(eventPlayer.var1)):
        damage(eventPlayer.var1[eventPlayer.counter], eventPlayer, eventPlayer.var1[eventPlayer.counter].getHealth()/4)


rule "Junker Queen Carnage Check":
    @Event eachPlayer
    @Hero junkerQueen
    @Condition eventPlayer.isUsingAbility2() == true
    
    eventPlayer.var2 = true
    eventPlayer.moveSpeed -= 25
    waitUntil(not eventPlayer.isUsingAbility2(), 99999)
    eventPlayer.moveSpeed += 25
    if eventPlayer.var2:
        damage(eventPlayer, null, 200)


rule "Junker Queen Carnage Damage":
    @Event playerDealtDamage
    @Hero junkerQueen
    @Condition eventAbility == Button.ABILITY_2
    
    eventPlayer.var2 = false

rule "Junker Queen Rampage Mines":
    @Event eachPlayer
    @Hero junkerQueen
    @Condition eventPlayer.isUsingUltimate()

    wait(0.5)

    for eventPlayer.counter in range(0,25):
        createProjectile(Projectile.ROADHOG_SCRAP_BALL, eventPlayer, null, null, Relativity.TO_PLAYER, ModifyHealth.DAMAGE, getOppositeTeam(eventPlayer.getTeam()), 25, 1, 3, DynamicEffect.BAD_EXPLOSION, DynamicEffect.BUFF_EXPLOSION_SOUND, 0, 10, 2, 5, 10, 9.68)
        wait(0.03)



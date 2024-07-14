#!mainFile "../main.opy"

def disable_inputs():
    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.disallowButton(Button.ABILITY_1)
    eventPlayer.disallowButton(Button.ABILITY_2)
    eventPlayer.disallowButton(Button.MELEE)
    eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer.disallowButton(Button.JUMP)
    eventPlayer.disallowButton(Button.CROUCH)
    eventPlayer.disallowButton(Button.RELOAD)
    eventPlayer.disallowButton(Button.INTERACT)

def enable_inputs():
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.allowButton(Button.SECONDARY_FIRE)
    eventPlayer.allowButton(Button.ABILITY_1)
    eventPlayer.allowButton(Button.ABILITY_2)
    eventPlayer.allowButton(Button.MELEE)
    eventPlayer.allowButton(Button.ULTIMATE)
    eventPlayer.allowButton(Button.JUMP)
    eventPlayer.allowButton(Button.CROUCH)
    eventPlayer.allowButton(Button.RELOAD)
    eventPlayer.allowButton(Button.INTERACT)

def disable_abilities():
    eventPlayer.setUltEnabled(false)
    eventPlayer.setPrimaryFireEnabled(false)
    eventPlayer.setSecondaryFireEnabled(false)
    eventPlayer.setAbility1Enabled(false)
    eventPlayer.setAbility2Enabled(false)
    eventPlayer.setMeleeEnabled(false)
    eventPlayer.setReloadEnabled(false)
    eventPlayer.setCrouchEnabled(false)
    eventPlayer.setJumpEnabled(false)

def enable_abilities():
    eventPlayer.setUltEnabled(true)
    eventPlayer.setPrimaryFireEnabled(true)
    eventPlayer.setSecondaryFireEnabled(true)
    eventPlayer.setAbility1Enabled(true)
    eventPlayer.setAbility2Enabled(true)
    eventPlayer.setMeleeEnabled(true)
    eventPlayer.setReloadEnabled(true)
    eventPlayer.setCrouchEnabled(true)
    eventPlayer.setJumpEnabled(true)

def clear_status_effects():
    eventPlayer.clearStatusEffect(Status.ASLEEP)
    eventPlayer.clearStatusEffect(Status.BURNING)
    eventPlayer.clearStatusEffect(Status.FROZEN)
    eventPlayer.clearStatusEffect(Status.HACKED)
    eventPlayer.clearStatusEffect(Status.INVINCIBLE)
    eventPlayer.clearStatusEffect(Status.KNOCKED_DOWN)
    eventPlayer.clearStatusEffect(Status.PHASED_OUT)
    eventPlayer.clearStatusEffect(Status.ROOTED)
    eventPlayer.clearStatusEffect(Status.STUNNED)
    eventPlayer.clearStatusEffect(Status.UNKILLABLE)


def clear_player_health():
    eventPlayer.health = 0
    eventPlayer.shields = 0
    eventPlayer.armor = 0
    eventPlayer.removeAllHealthPools()

def set_player_health():
    if eventPlayer.isInSpawnRoom():
        eventPlayer.player_spawn_pos = eventPlayer.getPosition()
        eventPlayer.teleport(eventPlayer.getPosition() + 100 * Vector.UP)
        waitUntil(not (eventPlayer.isInSpawnRoom() or eventPlayer.hasStatusEffect(Status.INVINCIBLE) or eventPlayer.hasStatusEffect(Status.UNKILLABLE)), 1)
    eventPlayer.setStatusEffect(eventPlayer, Status.UNKILLABLE, Math.INFINITY)
    damage(eventPlayer, null, Math.INFINITY)

    eventPlayer.addHealthPool(Health.ARMOR, Math.INFINITY, true, true)
    eventPlayer.addHealthPool(Health.NORMAL, Math.INFINITY, true, true)
    eventPlayer.addHealthPool(Health.SHIELDS, Math.INFINITY, true, true)

    wait()
    eventPlayer.removeAllHealthPools()

    if eventPlayer.player_spawn_pos:
        eventPlayer.teleport(eventPlayer.player_spawn_pos)
        eventPlayer.player_spawn_pos = null

    if eventPlayer.health:
        eventPlayer.addHealthPool(Health.NORMAL, max(1, eventPlayer.health - 1), true, true)
        eventPlayer.health_pools[0] = getLastCreatedHealthPool()
    if eventPlayer.armor:
        eventPlayer.addHealthPool(Health.ARMOR, max(1, eventPlayer.armor), true, true)
        eventPlayer.health_pools[1] = getLastCreatedHealthPool()
    if eventPlayer.shields:
        eventPlayer.addHealthPool(Health.SHIELDS, max(1, eventPlayer.shields), true, true)
        eventPlayer.health_pools[2] = getLastCreatedHealthPool()

    eventPlayer.clearStatusEffect(Status.UNKILLABLE)


def check_and_set_hp():
    set_player_health()

    if eventPlayer.getHealthOfType(Health.ARMOR) != eventPlayer.armor:
        goto RULE_START
    if eventPlayer.getHealthOfType(Health.NORMAL) != eventPlayer.health:
        goto RULE_START
    if eventPlayer.getHealthOfType(Health.SHIELDS) != eventPlayer.shields:
        goto RULE_START
#!mainFile "../../../main.opy"

rule "Hanzo Init":
    @Event eachPlayer
    @Hero hanzo
    
    set_health_pool(eventPlayer, 200, 0, 0)

rule "Hanzo Damage Headshot Fix":
    @Event playerDealtDamage
    @Hero hanzo
    
    if eventAbility == Button.PRIMARY_FIRE:
        damage(victim, attacker, 10 if eventWasCriticalHit else eventDamage * 2 + 10)
    elif eventAbility == null:
        return
    else:
        damage(victim, attacker, eventDamage)

rule "Hanzo Lunge":
    @Event eachPlayer
    @Hero hanzo
    @Condition eventPlayer.getAbilityCooldown(Button.JUMP) != 0

    damage(eventPlayer, null, 10)

rule "Hanzo Disable Lunge if 10 HP":
    @Event eachPlayer
    @Hero hanzo
    @Condition eventPlayer.getHealth() <= 10

    eventPlayer.disallowButton(Button.JUMP)
    waitUntil(eventPlayer.getHealth() > 10, 99999)
    eventPlayer.allowButton(Button.JUMP)



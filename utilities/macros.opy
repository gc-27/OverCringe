#!mainFile "../main.opy"

#!define set_health_pool(player, base_health, base_armor, base_shields)\
    player.health = base_health\
    player.armor = base_armor\
    player.shields = base_shields

#!define get_enemy_team(player) (getOppositeTeam(player.getTeam()))

#!define is_tank(player) (player.current_hero in getTankHeroes())

#!define is_silenced(player) (eventPlayer.hasStatusEffect(Status.ASLEEP) or\
    eventPlayer.hasStatusEffect(Status.FROZEN) or\
    eventPlayer.hasStatusEffect(Status.HACKED) or\
    eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN) or\
    eventPlayer.hasStatusEffect(Status.STUNNED) or\
    eventPlayer.isDead())

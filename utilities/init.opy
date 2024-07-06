#!mainFile "../main.opy"

playervar damageMod
#Before you ask, I am gay.
globalvar LGBT_HEROES = [Hero.LIFEWEAVER, Hero.BAPTISTE, Hero.TRACER, Hero.PHARAH, Hero.MAUGA, Hero.SOLDIER, Hero.VENTURE]
globalvar debug = createWorkshopSetting(bool, "DEVELOPMENT", "DEBUG", true, 0)

rule "LGBTQ Heroes Damage Mod":
    @Event eachPlayer
    @Condition eventPlayer.getCurrentHero() in LGBT_HEROES

    startDamageModification(eventPlayer, [player for player in getPlayers(getOppositeTeam(eventPlayer.getTeam())) if player.getCurrentHero() in LGBT_HEROES], 50, DamageReeval.RECEIVERS_DAMAGERS_AND_DMGPERCENT)
    eventPlayer.damageMod = getLastDamageModification()
    waitUntil(not eventPlayer.getCurrentHero() in LGBT_HEROES, 99999)
    stopDamageModification(eventPlayer.damageMod)

rule "General Init":
    @Event eachPlayer

    eventPlayer.addHealthPool(Health.SHIELDS, 100, true, false)
    eventPlayer.setMaxHealth(100)

rule "Global Init":
    @Event global

    if debug:
        pass
    else:
        disableInspector()
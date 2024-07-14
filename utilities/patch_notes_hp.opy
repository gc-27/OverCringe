#!mainFile "../main.opy"

rule "Patch Notes Health in General Changes":
    @Event eachPlayer
    @Condition eventPlayer.current_hero != eventPlayer.getCurrentHero()
    @Condition eventPlayer.health != 0

    eventPlayer.hero_general_changes = ["Health pool changed to {} health{}{}.".format(eventPlayer.health, ", {} armor".format(eventPlayer.armor) if eventPlayer.armor else "", ", {} shields".format(eventPlayer.shields) if eventPlayer.shields else "")]
    
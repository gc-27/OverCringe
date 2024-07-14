#!mainFile "../../../main.opy"


rule "Winston Patch Notes":
    @Event eachPlayer
    @Hero winston

    eventPlayer.hero_description = "Guxue's dream."

    eventPlayer.primary_fire_name = "Tesla Cannon"
    eventPlayer.secondary_fire_name = "Tesla Cannon (Secondary Fire)"
    eventPlayer.ability_1_name = "Jump Pack"
    eventPlayer.ability_2_name = "Barrier Projector"
    eventPlayer.ultimate_name = "Primal Rage"

    eventPlayer.secondary_fire_notes = ["Jumps between enemies, up to five times.", "Jumped attacks deal 50% less damage each jump."]
    eventPlayer.ability_1_notes = ["Deals 100 extra damage to any enemies you land directly on.", "Cooldown during Primal Rage removed."]
    eventPlayer.ultimate_notes = ["Press Secondary Fire (Default bound to Right Click) to shoot out a", "small bouncy ball that can knock enemies away."]
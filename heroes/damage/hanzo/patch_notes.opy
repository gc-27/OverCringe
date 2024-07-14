#!mainFile "../../../main.opy"

rule "Hanzo Patch Notes":
    @Event eachPlayer
    @Hero hanzo

    eventPlayer.hero_description = "This Legolas looking POS!"

    eventPlayer.primary_fire_name = "Storm Bow"
    eventPlayer.ability_1_name = "Sonic Arrow"
    eventPlayer.ability_2_name = "Storm Arrows"
    eventPlayer.ultimate_name = "Dragonstrike"
    eventPlayer.passive_name = "Lunge"
    eventPlayer.patch_notes_buttons[6] = Button.JUMP

    eventPlayer.primary_fire_notes  = ["Can no longer deal headshot damage.", "Base damage increased to 125."]
    eventPlayer.ability_2_notes = ["No longer deals headshot damage.", "Arrow damage increased to 100"]
    eventPlayer.passive_notes = ["Cooldown removed", "Casting Lunge deals 10 damage to Hanzo.", "Being 10 HP or less makes Hanzo unable to jump."]
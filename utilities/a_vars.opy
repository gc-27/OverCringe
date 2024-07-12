#!mainFile "../main.opy"

globalvar debug = createWorkshopSetting(bool, "DEVELOPMENT", "DEBUG", true, 0)
globalvar patchNotesButtons = [Button.PRIMARY_FIRE, Button.SECONDARY_FIRE, Button.ABILITY_1, Button.ABILITY_2, Button.CROUCH, Button.ULTIMATE, null]
globalvar patchNotesColors = [Color.YELLOW, Color.YELLOW, Color.YELLOW, Color.YELLOW, Color.YELLOW, Color.SKY_BLUE, Color.ORANGE]

playervar moveSpeed = 100
playervar prevMoveSpeed

playervar gravity = 100
playervar prevGravity

playervar currentHero
playervar canUseAbilities = true
playervar ccimmune = false

playervar effects
playervar counter
playervar var1
playervar var2
playervar var3
playervar var4

playervar health_different
playervar player_spawn_pos
playervar health
playervar armor
playervar shields

playervar weapon_names = ["not set", "not set", "not set", "not set", "not set", "not set", "not set", "not set"] #0: Primary Fire Name, #1: Secondary Fire Name, #2: Ability 1 Name, #3: Ability 2 Name, #4: Crouch Name, #5: Ultimate Name, #6: Passive
playervar hero_description
playervar hero_general_changes
playervar patchNotesCounter
playervar patchNotesCounter2 
playervar patchNotesVisible
playervar patchNotesReady
playervar patchNotesText = []
playervar patchNotes = []




#!mainFile "../main.opy"

globalvar debug = createWorkshopSetting(bool, "DEVELOPMENT", "DEBUG", true, 0)
globalvar debug_dummy_bots

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

playervar hero_description

playervar i

playervar patchNotesColorArray = [Color.WHITE, Color.WHITE, Color.YELLOW, Color.YELLOW, Color.YELLOW, Color.SKY_BLUE, Color.RED]
playervar patchNotesButtonArray = [Button.PRIMARY_FIRE, Button.SECONDARY_FIRE, Button.ABILITY_1, Button.ABILITY_2, Button.CROUCH, Button.ULTIMATE, null]
playervar patchNotes = [[], [], [], [], [], [], [], []] 
playervar patchNotesText = []

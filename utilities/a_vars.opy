#!mainFile "../main.opy"

globalvar debug = createWorkshopSetting(bool, "DEVELOPMENT", "DEBUG", true, 0)
globalvar debug_dummy_bots

playervar moveSpeed = 100
playervar prevMoveSpeed

playervar gravity = 100
playervar prevGravity

playervar healthMax = 100
playervar prevHealthMax

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

playervar patchNotesData = [] # 0: text, 1: sort order, 2: color

playervar patchNotesText = []

playervar i
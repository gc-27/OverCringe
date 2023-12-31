#!mainFile "../main.opy"
playervar patchNotesData = [] # 0: text, 1: sort order, 2: color

playervar patchNotesText = []

playervar i



def clear_text_from_screen():
    for eventPlayer.i in range(len(eventPlayer.patchNotesText)):
        destroyHudText(eventPlayer.patchNotesText[eventPlayer.i])
    eventPlayer.patchNotesText = []


def read_patch_notes_data():
    for eventPlayer.i in range(0, len(eventPlayer.patchNotesData)):
        hudText(eventPlayer, 
                null, 
                evalOnce(eventPlayer.patchNotesData[eventPlayer.i-1][0]), 
                null,
                HudPosition.LEFT, 
                evalOnce(eventPlayer.patchNotesData[eventPlayer.i-1][1]), 
                null,
                evalOnce(eventPlayer.patchNotesData[eventPlayer.i-1][2]), 
                null, 
                HudReeval.SORT_ORDER_STRING_AND_COLOR, 
                SpecVisibility.ALWAYS
            )
        eventPlayer.patchNotesText.append(getLastCreatedText())



rule "Show menu in spawn":
    @Event eachPlayer
    @Condition eventPlayer.isInSpawnRoom()

    RULE_START

    hudText(eventPlayer, "Press {0} to show see your hero's changes.".format(buttonString(Button.INTERACT)),null, null, HudPosition.LEFT, 0, Color.WHITE, null, null, HudReeval.STRING, SpecVisibility.ALWAYS)
    eventPlayer.patchNotesText.append(getLastCreatedText())
    hudText(eventPlayer, null,"Full patch notes can be found at workshop.codes/8GT3J", null, HudPosition.LEFT, 0, null, Color.YELLOW, null, HudReeval.STRING, SpecVisibility.ALWAYS)
    eventPlayer.patchNotesText.append(getLastCreatedText())

    waitUntil(not eventPlayer.isInSpawnRoom() or eventPlayer.isHoldingButton(Button.INTERACT), 99999)

    clear_text_from_screen()

    if not eventPlayer.isInSpawnRoom() or not eventPlayer.isHoldingButton(Button.INTERACT):
        return

    eventPlayer.disableGamemodeHud()
    read_patch_notes_data()

    waitUntil(not eventPlayer.isHoldingButton(Button.INTERACT), 99999)
    eventPlayer.enableGamemodeHud()
    clear_text_from_screen()

    if RULE_CONDITION:
        goto RULE_START

    









#!mainFile "../main.opy"

def clear_text_from_screen():
    for eventPlayer.i in range(len(eventPlayer.patchNotesText)):
        destroyHudText(eventPlayer.patchNotesText[eventPlayer.i])
    eventPlayer.patchNotesText = []


def read_patch_notes_data():
    hudText(eventPlayer, "{} {}".format(heroIcon(eventPlayer.getCurrentHero()), eventPlayer.getCurrentHero()), null, null, HudPosition.LEFT, -100, Color.WHITE, null, null, HudReeval.SORT_ORDER_STRING_AND_COLOR, SpecVisibility.ALWAYS)
    eventPlayer.patchNotesText.append(getLastCreatedText())
    if eventPlayer.hero_description:
        hudText(eventPlayer, null, null, '"{}"'.format(eventPlayer.hero_description), HudPosition.LEFT, -100, null, null, Color.ROSE, HudReeval.SORT_ORDER_STRING_AND_COLOR, SpecVisibility.ALWAYS)
        eventPlayer.patchNotesText.append(getLastCreatedText())
    hudText(eventPlayer, null, "─────────────", null, HudPosition.LEFT, -100, null, Color.GRAY, null, HudReeval.SORT_ORDER_STRING_AND_COLOR, SpecVisibility.ALWAYS)
    eventPlayer.patchNotesText.append(getLastCreatedText())
    if eventPlayer.health_different:
        hudText(eventPlayer, null, null, "Health changed to {} health{}{}".format(eventPlayer.health, ", {} armor".format(eventPlayer.armor) if eventPlayer.armor else "", ", {} shields".format(eventPlayer.shields) if eventPlayer.shields else ""), HudPosition.LEFT, -100, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.SORT_ORDER_STRING_AND_COLOR, SpecVisibility.ALWAYS)
        eventPlayer.patchNotesText.append(getLastCreatedText())
    for eventPlayer.i in range(0, len(eventPlayer.patchNotes)):
        if eventPlayer.patchNotes[eventPlayer.i] != []:
            hudText(
                eventPlayer, 
                "{}{}".format(abilityIconString(eventPlayer.currentHero, eventPlayer.patchNotesButtonArray[evalOnce(eventPlayer.i)]), 
                buttonString(eventPlayer.patchNotesButtonArray[evalOnce(eventPlayer.i)])), 
                "{}{}{}{}".format(
                    eventPlayer.patchNotes[evalOnce(eventPlayer.i)][0], 
                    "\n{}".format(eventPlayer.patchNotes[evalOnce(eventPlayer.i)][1]) if eventPlayer.patchNotes[evalOnce(eventPlayer.i)][1] else "", 
                    "\n{}".format(eventPlayer.patchNotes[evalOnce(eventPlayer.i)][2]) if eventPlayer.patchNotes[evalOnce(eventPlayer.i)][2] else "", 
                    "\n{}".format(eventPlayer.patchNotes[evalOnce(eventPlayer.i)][3]) if eventPlayer.patchNotes[evalOnce(eventPlayer.i)][3] else ""
                    ), 
                null, 
                HudPosition.LEFT, 
                eventPlayer.i,
                Color.WHITE, 
                eventPlayer.patchNotesColorArray[evalOnce(eventPlayer.i)], 
                null, 
                HudReeval.STRING
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
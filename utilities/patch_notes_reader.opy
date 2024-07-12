#!mainFile "../main.opy"

def clear_text_from_screen():
    eventPlayer.patchNotesReady = false 
    for eventPlayer.patchNotesCounter in range(len(eventPlayer.patchNotesText)):
        destroyHudText(eventPlayer.patchNotesText[eventPlayer.patchNotesCounter])
    eventPlayer.patchNotesText = []

def read_patch_notes_data():
    #Interact Text
    hudHeader(eventPlayer if not eventPlayer.patchNotesVisible and eventPlayer.isInSpawnRoom() else null, "Press '{0}' to view your hero's changes.".format(buttonString(Button.INTERACT)), HudPosition.LEFT, len(eventPlayer.patchNotesText), Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    eventPlayer.patchNotesText.append(getLastCreatedText())
    #Workshop.codes Link
    hudSubheader(eventPlayer if not eventPlayer.patchNotesVisible and eventPlayer.isInSpawnRoom() else null, "Changes can be found at workshop.codes/code", HudPosition.LEFT, len(eventPlayer.patchNotesText), Color.YELLOW, HudReeval.VISIBILITY)
    eventPlayer.patchNotesText.append(getLastCreatedText())

    #Hero
    hudHeader(eventPlayer if eventPlayer.patchNotesVisible else null, "{} {}".format(heroIcon(eventPlayer.currentHero), eventPlayer.currentHero), HudPosition.TOP, len(eventPlayer.patchNotesText), Color.WHITE, HudReeval.VISIBILITY)
    eventPlayer.patchNotesText.append(getLastCreatedText())

    if eventPlayer.hero_description:
        hudSubtext(eventPlayer if eventPlayer.patchNotesVisible else null, '"{}"'.format(eventPlayer.hero_description[0]), HudPosition.TOP, len(eventPlayer.patchNotesText), Color.ROSE, HudReeval.VISIBILITY_AND_STRING)
        eventPlayer.patchNotesText.append(getLastCreatedText())
        hudSubtext(eventPlayer if eventPlayer.patchNotesVisible else null, '─────────────────────────────', HudPosition.TOP, len(eventPlayer.patchNotesText), Color.GRAY, HudReeval.VISIBILITY_AND_STRING)
        eventPlayer.patchNotesText.append(getLastCreatedText())

    if eventPlayer.hero_general_changes:
        hudSubtext(eventPlayer if eventPlayer.patchNotesVisible else null, "General Changes", HudPosition.TOP, len(eventPlayer.patchNotesText), Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
        eventPlayer.patchNotesText.append(getLastCreatedText())
        hudSubheader(eventPlayer if eventPlayer.patchNotesVisible else null, '─────────────────────────', HudPosition.TOP, len(eventPlayer.patchNotesText), Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
        eventPlayer.patchNotesText.append(getLastCreatedText())

    for eventPlayer.patchNotesCounter in range(0, len(eventPlayer.hero_general_changes)):
        hudSubheader(eventPlayer if eventPlayer.patchNotesVisible else null, '{}'.format(eventPlayer.hero_general_changes[eventPlayer.patchNotesCounter]), HudPosition.TOP, len(eventPlayer.patchNotesText), Color.WHITE, HudReeval.VISIBILITY)
        eventPlayer.patchNotesText.append(getLastCreatedText())
    
    if eventPlayer.patchNotes == [["not set"], ["not set"], ["not set"], ["not set"], ["not set"], ["not set"], ["not set"]] and not eventPlayer.hero_general_changes:
        hudSubtext(eventPlayer if eventPlayer.patchNotesVisible else null, "This character currently has no changes.", HudPosition.TOP, len(eventPlayer.patchNotesText), Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
        eventPlayer.patchNotesText.append(getLastCreatedText())
    
    hudSubheader(eventPlayer if eventPlayer.patchNotesVisible else null, "\n", HudPosition.TOP, len(eventPlayer.patchNotesText), Color.WHITE, HudReeval.VISIBILITY)
    eventPlayer.patchNotesText.append(getLastCreatedText())
        
    eventPlayer.patchNotesCounter = 0
    eventPlayer.patchNotesCounter2 = 0
    for eventPlayer.patchNotesCounter in range(0, len(eventPlayer.patchNotes)):
        if eventPlayer.patchNotes[eventPlayer.patchNotesCounter] != ["not set"]:
            hudSubtext(eventPlayer if eventPlayer.patchNotesVisible else null, "{}{}({})".format(abilityIconString(eventPlayer.currentHero, patchNotesButtons[evalOnce(eventPlayer.patchNotesCounter)]) if patchNotesButtons[evalOnce(eventPlayer.patchNotesCounter)] else iconString(Icon.BOLT), eventPlayer.weapon_names[evalOnce(eventPlayer.patchNotesCounter)], buttonString(patchNotesButtons[evalOnce(eventPlayer.patchNotesCounter)]) if patchNotesButtons[evalOnce(eventPlayer.patchNotesCounter)] else "Passive"), HudPosition.TOP, len(eventPlayer.patchNotesText), Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
            eventPlayer.patchNotesText.append(getLastCreatedText())
            hudSubheader(eventPlayer if eventPlayer.patchNotesVisible else null, "─────────────────────────", HudPosition.TOP, len(eventPlayer.patchNotesText), Color.WHITE, HudReeval.VISIBILITY)
            eventPlayer.patchNotesText.append(getLastCreatedText())
            for eventPlayer.patchNotesCounter2 in range(0, len(eventPlayer.patchNotes[eventPlayer.patchNotesCounter])):
                hudSubheader(eventPlayer if eventPlayer.patchNotesVisible else null, "{}".format(evalOnce(eventPlayer.patchNotes[eventPlayer.patchNotesCounter][eventPlayer.patchNotesCounter2])), HudPosition.TOP, len(eventPlayer.patchNotesText), patchNotesColors[evalOnce(eventPlayer.patchNotesCounter)], HudReeval.VISIBILITY_AND_STRING)
                eventPlayer.patchNotesText.append(getLastCreatedText())
            hudSubheader(eventPlayer if eventPlayer.patchNotesVisible else null, "\n", HudPosition.TOP, len(eventPlayer.patchNotesText), Color.WHITE, HudReeval.VISIBILITY)
            eventPlayer.patchNotesText.append(getLastCreatedText())
            
    
    eventPlayer.patchNotesCounter2 = len(eventPlayer.patchNotesText)
    for eventPlayer.patchNotesCounter in range(0, eventPlayer.patchNotesCounter2):
        hudSubtext(eventPlayer if eventPlayer.patchNotesVisible else null, "                                                                             ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒", HudPosition.LEFT, 0, Color.BLACK, HudReeval.VISIBILITY_AND_STRING)
        eventPlayer.patchNotesText.append(getLastCreatedText())
    
    eventPlayer.patchNotesReady = true

    

rule "Show menu":
    @Event eachPlayer
    @Condition eventPlayer.isInSpawnRoom() and eventPlayer.isHoldingButton(Button.INTERACT) and eventPlayer.patchNotesReady
    @Condition eventPlayer.patchNotesReady

    eventPlayer.disableGamemodeHud()
    eventPlayer.disableHeroHud()
    eventPlayer.disableGamemodeInWorldUi()
    eventPlayer.disableScoreboard()
    eventPlayer.patchNotesVisible = true


rule "Hide Menu":
    @Event eachPlayer
    @Condition not eventPlayer.isHoldingButton(Button.INTERACT) and eventPlayer.patchNotesReady

    eventPlayer.enableGamemodeHud()
    eventPlayer.enableHeroHud()
    eventPlayer.enableGamemodeInWorldUi()
    eventPlayer.enableScoreboard()
    eventPlayer.patchNotesVisible = false

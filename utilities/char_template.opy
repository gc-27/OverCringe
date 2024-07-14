#!mainFile "../main.opy"


rule "Hero Init":
    @Event eachPlayer
    @Hero echo
    
    set_health_pool(eventPlayer, 0, 0, 0)


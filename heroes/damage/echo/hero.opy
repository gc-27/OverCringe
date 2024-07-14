#!mainFile "../../../main.opy"


rule "Echo Init":
    @Event eachPlayer
    @Hero echo
    
    set_health_pool(eventPlayer, 100, 150, 0)

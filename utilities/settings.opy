#!mainFile "../main.opy"
settings {
    "main": {
        "description": "OverCringe 2.0",
        "modeName": '"Tournament Ready"'
    },
    "gamemodes": {
        "assault": {},
        "control": {},
        "escort": {},
        "flashpoint": {},
        "hybrid": {},
        "push": {},
        "general": {
            "gamemodeStartTrigger": "manual",
            "roleLimit": "1Tank2Offense2Support",
            "tankPassiveHealthBonus": "alwaysEnabled"
        }
    },
    "heroes": {
        "allTeams": {
            "hammond": {
                "ultKb%": 400,
                "enableInfiniteAmmo": true,
                "enablePrimaryFire": false
            },
            "zarya": {
                "health%": 200,
                "enableInfiniteAmmo": true,
                "ability1Cooldown%": 50,
                "secondaryFireKb%": 200,
                "ability2Cooldown%": 50
            }
        }
    }
}
#!mainFile "../main.opy"
settings {
    "main": {
        "modeName": "OverCringe 2.0",
        "description": "\"Tournament Ready\""
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
                "enableInfiniteAmmo": true
            },
            "zarya": {
                "secondaryFireKb%": 200
            },
            "doomfist": {
                "enableInfiniteAmmo": true,
                "secondaryFireKb%": 300
            }
        }
    }
}

#!mainFile "../main.opy"
settings {
    "main": {
        "modeName": "OverCringe 2.0",
        "description": "\"Tournament Ready\" \n Echo is currently disabled due to server crashes caused by Duplicate."
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
            "reinhardt": {
                "movementSpeed%": 150
            },
            "zarya": {
                "secondaryFireKb%": 200
            },
            "doomfist": {
                "enableInfiniteAmmo": true,
                "secondaryFireKb%": 300
            },
            "junkerQueen": {
                "secondaryFireRecallDelay%": 200,
                "ability2Cooldown%": 0
            },
            "ramattra": {
                "ultDuration%": 200
            },
            "bastion": {
                "secondaryFireKb%": 125,
                "ability1Cooldown%": 0
            },
            "hanzo": {
                "ability3Cooldown%": 1,
                "damageDealt%": 50
            },
            "disabledHeroes": [
                "echo"
            ]
        }
    }
}


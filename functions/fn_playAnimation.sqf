/*
    Spuštěno modulem → uloží jednotky a otevře dialog
    OPRAVENÁ VERZE PRO MULTIPLAYER
*/

params ["_logic", "_units", "_activated"];

// Debug výpis
diag_log format ["[RR_ANIM] Module executed - Logic: %1, Units: %2, Server: %3", _logic, _units, isServer];

// fallback: attached/nearest
if (_units isEqualTo []) then {
    private _attached = attachedTo _logic;
    if (!isNull _attached) then {
        _units = [_attached];
        diag_log format ["[RR_ANIM] Using attached unit: %1", _attached];
    } else {
        private _nearest = nearestObjects [getPos _logic, ["Man"], 10]; // zvětšil jsem dosah na 10m
        if (count _nearest > 0) then {
            _units = [_nearest select 0];
            diag_log format ["[RR_ANIM] Using nearest unit: %1", _nearest select 0];
        };
    };
};

if (_units isEqualTo []) exitWith {
    diag_log "[RR_ANIM] No units found!";
    hint parseText format [
        "<t color='#FF0000'>%1</t>",
        "Žádné jednotky nenalezeny!"
    ];
};

diag_log format ["[RR_ANIM] Found units: %1", _units];

// JEDNODUCHÉ ŘEŠENÍ - otevři dialog lokálně na tom kdo umístil modul
if (hasInterface) then {
    diag_log "[RR_ANIM] Opening dialog locally";
    
    // uložíme globálně, aby dialog věděl na koho
    RR_anim_units = _units;
    
    // otevřít dialog
    [] spawn {
        sleep 0.1; // malé zpoždění pro jistotu
        createDialog "RR_PlayAnimationDialog";
        diag_log "[RR_ANIM] Dialog should be open now";
    };
};

deleteVehicle _logic;
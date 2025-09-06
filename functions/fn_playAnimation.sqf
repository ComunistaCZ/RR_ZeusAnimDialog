/*
    Spuštěno modulem → uloží jednotky a otevře dialog
    OPRAVENÁ VERZE PRO DEDIKOVANÝ SERVER
*/

params ["_logic", "_units", "_activated"];

diag_log format ["[RR_ANIM] Module executed - Logic: %1, Units: %2, Server: %3", _logic, _units, isServer];

// fallback: attached/nearest
if (_units isEqualTo []) then {
    private _attached = attachedTo _logic;
    if (!isNull _attached) then {
        _units = [_attached];
        diag_log format ["[RR_ANIM] Using attached unit: %1", _attached];
    } else {
        private _nearest = nearestObjects [getPos _logic, ["Man"], 10];
        if (count _nearest > 0) then {
            _units = [_nearest select 0];
            diag_log format ["[RR_ANIM] Using nearest unit: %1", _nearest select 0];
        };
    };
};

if (_units isEqualTo []) exitWith {
    diag_log "[RR_ANIM] No units found!";
    // Pošli hint všem klientům
    [parseText "<t color='#FF0000'>Žádné jednotky nenalezeny!</t>"] remoteExec ["hint"];
    deleteVehicle _logic;
};

diag_log format ["[RR_ANIM] Found units: %1", _units];

// Najdi Zeus hráče který umístil modul
private _curator = objNull;

// Zkus najít curatora z logiky
if (!isNull _logic) then {
    _curator = getAssignedCuratorUnit _logic;
};

// Pokud se nepodařilo najít curatora, zkus všechny aktivní curatory
if (isNull _curator) then {
    {
        private _curatorUnit = getAssignedCuratorUnit _x;
        if (!isNull _curatorUnit && {alive _curatorUnit}) then {
            _curator = _curatorUnit;
            break;
        };
    } forEach allCurators;
};

diag_log format ["[RR_ANIM] Found curator: %1", _curator];

if (!isNull _curator) then {
    // Pošli jednotky a otevři dialog na kuratorově klientovi
    [_units] remoteExec ["rr_zeus_anim_fnc_openDialog", _curator];
} else {
    diag_log "[RR_ANIM] No curator found - opening on all clients";
    // Fallback - otevři na všech klientech
    [_units] remoteExec ["rr_zeus_anim_fnc_openDialog"];
};

// Smaž modul
deleteVehicle _logic;
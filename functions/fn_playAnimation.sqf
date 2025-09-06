/*
    Spuštěno modulem → uloží jednotky a otevře dialog
*/

params ["_logic", "_units", "_activated"];

if (!local _logic) exitWith {};

// fallback: attached/nearest
if (_units isEqualTo []) then {
    private _attached = attachedTo _logic;
    if (!isNull _attached) then {
        _units = [_attached];
    } else {
        private _nearest = nearestObjects [getPos _logic, ["Man"], 3];
        if (count _nearest > 0) then {
            _units = [_nearest select 0];
        };
    };
};

if (_units isEqualTo []) exitWith {
    hint parseText format [
        "<t color='#00BFFF'>%1</t>",
        localize "STR_NO_UNIT_HINT"
    ];
};

// uložíme globálně, aby dialog věděl na koho
RR_anim_units = _units;

// otevřít dialog
createDialog "RR_PlayAnimationDialog";


deleteVehicle _logic;
/*
    Spuštěno modulem → uloží jednotky a otevře dialog
    Modified for multiplayer support
*/

params ["_logic", "_units", "_activated"];

// Only execute on server
if (!isServer) exitWith {};

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
    // Send hint to curator who placed the module
    private _curator = getAssignedCuratorUnit _logic;
    if (!isNull _curator) then {
        [parseText format [
            "<t color='#00BFFF'>%1</t>",
            localize "STR_NO_UNIT_HINT"
        ]] remoteExec ["hint", _curator];
    };
};

// Get the curator who placed this module
private _curator = getAssignedCuratorUnit _logic;
if (isNull _curator) exitWith {
    // Fallback: find any curator
    private _curators = allCurators;
    if (count _curators > 0) then {
        _curator = getAssignedCuratorUnit (_curators select 0);
    };
};

if (!isNull _curator) then {
    // Send units data and open dialog on curator's client
    [_units] remoteExec ["rr_zeus_anim_fnc_openDialogClient", _curator];
} else {
    // Fallback: open on all clients (not recommended but works)
    [_units] remoteExec ["rr_zeus_anim_fnc_openDialogClient"];
};

deleteVehicle _logic;
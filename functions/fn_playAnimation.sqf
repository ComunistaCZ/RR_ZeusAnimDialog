/*
    FINÁLNÍ VERZE PRO DEDIKOVANÝ SERVER
*/

params ["_logic", "_units", "_activated"];

diag_log format ["[RR_ANIM] Module started - Server: %1, Interface: %2", isServer, hasInterface];

// fallback: attached/nearest
if (_units isEqualTo []) then {
    private _attached = attachedTo _logic;
    if (!isNull _attached) then {
        _units = [_attached];
    } else {
        private _nearest = nearestObjects [getPos _logic, ["Man"], 10];
        if (count _nearest > 0) then {
            _units = [_nearest select 0];
        };
    };
};

if (_units isEqualTo []) exitWith {
    hint "Žádné jednotky nenalezeny!";
    deleteVehicle _logic;
};

diag_log format ["[RR_ANIM] Found units: %1", _units];

// ŘEŠENÍ PRO DEDIKOVANÝ SERVER
if (isServer) then {
    diag_log "[RR_ANIM] Running on server - sending to clients";
    
    // Najdi všechny kuratory
    private _curators = [];
    {
        private _curatorUnit = getAssignedCuratorUnit _x;
        if (!isNull _curatorUnit && {alive _curatorUnit}) then {
            _curators pushBack _curatorUnit;
        };
    } forEach allCurators;
    
    diag_log format ["[RR_ANIM] Found curators: %1", _curators];
    
    if (count _curators > 0) then {
        // Pošli na všechny kuratory
        {
            [_units] remoteExec ["RR_openDialogOnClient", _x];
            diag_log format ["[RR_ANIM] Sent to curator: %1", _x];
        } forEach _curators;
    } else {
        // Fallback - pošli na všechny klienty
        diag_log "[RR_ANIM] No curators found - sending to all clients";
        [_units] remoteExec ["RR_openDialogOnClient"];
    };
} else {
    // Lokální spuštění (SP nebo klient)
    diag_log "[RR_ANIM] Running locally";
    [_units] call RR_openDialogOnClient;
};

deleteVehicle _logic;

// GLOBÁLNÍ FUNKCE PRO OTEVŘENÍ DIALOGU NA KLIENTOVI
RR_openDialogOnClient = {
    params ["_units"];
    
    // Pouze na klientech s GUI
    if (!hasInterface) exitWith {
        diag_log "[RR_ANIM] No interface - skipping dialog";
    };
    
    diag_log format ["[RR_ANIM] Opening dialog on client for units: %1", _units];
    
    RR_anim_units = _units;
    
    [] spawn {
        sleep 0.2;
        if (createDialog "RR_PlayAnimationDialog") then {
            diag_log "[RR_ANIM] Dialog opened successfully on client!";
            hint "Dialog otevřen!";
        } else {
            diag_log "[RR_ANIM] ERROR: Failed to create dialog on client!";
            hint "CHYBA: Dialog se neotevřel!";
        };
    };
};
/*
    FINÁLNÍ VERZE PRO DEDIKOVANÝ SERVER - SPRÁVNÁ SQF SYNTAXE
    Funkce pro otevření dialogu je nyní definována mimo hlavní funkci
*/

// GLOBÁLNÍ FUNKCE PRO OTEVŘENÍ DIALOGU - definuj při načtení mise
if (isNil "RR_openDialogOnClient") then {
    RR_openDialogOnClient = {
        params ["_units"];
        
        // Pouze na klientech s GUI
        if (!hasInterface) exitWith {
            diag_log "[RR_ANIM] No interface - skipping dialog";
        };
        
        diag_log format ["[RR_ANIM] Opening dialog on client for units: %1", _units];
        
        RR_anim_units = _units;
        
        [] spawn {
            // Malé zpoždění pro jistotu
            sleep 0.1;
            if (createDialog "RR_PlayAnimationDialog") then {
                diag_log "[RR_ANIM] Dialog opened successfully on client!";
                // hint localize "STR_HINT_DialOpen";
            } else {
                diag_log "[RR_ANIM] ERROR: Failed to create dialog on client!";
                hint "CHYBA: Dialog se neotevřel!";
            };
        };
    };
};

// HLAVNÍ FUNKCE MODULU
params ["_logic", "_units", "_activated"];

diag_log format ["[RR_ANIM] Module started - Server: %1, Interface: %2", isServer, hasInterface];

// Fallback: attached/nearest
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
    //hint "Žádné jednotky nenalezeny!";
    deleteVehicle _logic;
};

diag_log format ["[RR_ANIM] Found units: %1", _units];

// ŘEŠENÍ PRO RŮZNÁ PROSTŘEDÍ
if (isServer) then {
    if (!hasInterface) then {
        // Dedikovaný server
        diag_log "[RR_ANIM] Running on dedicated server - sending to clients";
        
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
            // Fallback - pošli na všechny klienty s GUI
            diag_log "[RR_ANIM] No curators found - sending to all clients";
            [_units] remoteExec ["RR_openDialogOnClient", 0];
        };
    } else {
        // Server s GUI (lokální hosted server)
        diag_log "[RR_ANIM] Running on server with interface";
        [_units] call RR_openDialogOnClient;
    };
} else {
    // Klient
    if (hasInterface) then {
        diag_log "[RR_ANIM] Running on client with interface";
        [_units] call RR_openDialogOnClient;
    };
};

deleteVehicle _logic;
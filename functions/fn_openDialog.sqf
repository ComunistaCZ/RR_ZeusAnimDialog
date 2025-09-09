/*
    Otevře dialog na klientovi
    Vytvoř jako: functions/fn_openDialog.sqf
*/

params ["_units"];

// Pouze na klientovi s GUI
if (!hasInterface) exitWith {};

diag_log format ["[RR_ANIM] Opening dialog on client for units: %1", _units];

// Ulož jednotky globálně pro dialog
RR_anim_units = _units;

// Otevři dialog s malým zpožděním
[] spawn {
    //sleep 0.1;
    if (createDialog "RR_PlayAnimationDialog") then {
        diag_log "[RR_ANIM] Dialog opened successfully";
    } else {
        diag_log "[RR_ANIM] ERROR: Failed to create dialog";
        //hint "Chyba: Dialog se nepodařilo otevřít!";
    };
};
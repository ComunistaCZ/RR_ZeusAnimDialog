/*
    Zavoláno z tlačítka OK v dialogu
    OPRAVENÁ VERZE - jednoduchá a fungující
*/

params ["_move", "_units"];

diag_log format ["[RR_ANIM] Executing animation: %1 on units: %2", _move, _units];

// Jednoduché řešení - spusť na všech klientech
[_move, _units] remoteExec ["rr_zeus_anim_fnc_executeAnim", 0];

// A spusť i lokálně pro okamžitý efekt
[_move, _units] call rr_zeus_anim_fnc_executeAnim;
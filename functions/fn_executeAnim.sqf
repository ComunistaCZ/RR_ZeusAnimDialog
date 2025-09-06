/*
    Nová funkce pro spuštění animace
    Vytvoř tuto funkce jako: functions/fn_executeAnim.sqf
*/

params ["_move", "_units"];

diag_log format ["[RR_ANIM] executeAnim called with: %1, %2", _move, _units];

{
    if (!isNull _x && {alive _x}) then {
        diag_log format ["[RR_ANIM] Applying animation %1 to unit %2", _move, _x];
        _x switchMove _move;
        
        // Pokud je animace prázdná, zastav všechny animace
        if (_move == "") then {
            _x playMove "";
            _x switchMove "";
        };
    };
} forEach _units;
/*
    Zavoláno z tlačítka OK v dialogu
    _this select 0 = string animace
    _this select 1 = jednotky
*/

params ["_move", "_units"];

{
    if (!isNull _x && {alive _x}) then {
        _x switchMove _move;
    };
} forEach _units;


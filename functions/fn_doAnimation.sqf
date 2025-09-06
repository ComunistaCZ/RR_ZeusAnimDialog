/*
    Zavoláno z tlačítka OK v dialogu
    Modified for multiplayer - executes on server and syncs to all clients
    _this select 0 = string animace
    _this select 1 = jednotky
*/

params ["_move", "_units"];

// Execute the animation change on server and broadcast to all clients
[_move, _units] remoteExec ["rr_zeus_anim_fnc_doAnimationGlobal", 0, true];

// Function to actually apply the animation (will be called on all machines)
rr_zeus_anim_fnc_doAnimationGlobal = {
    params ["_move", "_units"];
    
    {
        if (!isNull _x && {alive _x}) then {
            _x switchMove _move;
        };
    } forEach _units;
};

// If we're on the client that initiated this, also execute locally for immediate feedback
if (hasInterface) then {
    {
        if (!isNull _x && {alive _x}) then {
            _x switchMove _move;
        };
    } forEach _units;
};
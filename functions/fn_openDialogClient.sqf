/*
    Called on client to open the animation dialog
    This function runs on the client side only
*/

params ["_units"];

// Only execute on client
if (!hasInterface) exitWith {};

// Store units globally for the dialog to access
RR_anim_units = _units;

// Open dialog on client
createDialog "RR_PlayAnimationDialog";
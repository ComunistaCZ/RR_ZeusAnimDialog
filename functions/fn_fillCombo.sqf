disableSerialization;
private _display = findDisplay 8000;
private _ctrlCombo = _display displayCtrl 8004;
lbClear _ctrlCombo;

// Seznam animací: [stringtableKey, className]
disableSerialization;
private _display = findDisplay 8000;
private _ctrlCombo = _display displayCtrl 8004;
lbClear _ctrlCombo;

// Seznam animací: [stringtableKey, className]
private _anims = [
    ["$STR_RR_ANIM_Stop", ""],
    ["$STR_RR_ANIM_Pray_Loop", "Acts_ws_anim_prayer_loop"],
    ["$STR_RR_ANIM_SittingWounded_Loop", "Acts_SittingWounded_loop"],
    ["$STR_RR_ANIM_Surrender", "Acts_Surrender"],
    ["$STR_RR_ANIM_Proslov1", "UnaErcVelitelProslov1"],
    ["$STR_RR_ANIM_Proslov2", "UnaErcVelitelProslov2"],
    ["$STR_RR_ANIM_Proslov3", "UnaErcVelitelProslov3"],
    ["$STR_RR_ANIM_Proslov4", "UnaErcVelitelProslov4"],
    ["$STR_RR_ANIM_Proslov5", "UnaErcVelitelProslov5"],
    ["$STR_RR_ANIM_Protest1", "c7a_bravo_dovadeni1"],
    ["$STR_RR_ANIM_Protest2", "shaftoe_c0briefing_otazky_loop5"],
    ["$STR_RR_ANIM_Protest3", "c7a_bravo_dovadeni3"],
    ["$STR_RR_ANIM_Listening", "Acts_CivilListening_1"]
];

// Naplnění comboboxu
{
    private _idx = _ctrlCombo lbAdd (localize (_x select 0));  // Načte lokalizovaný text z stringtable.xml
    _ctrlCombo lbSetData [_idx, _x select 1];                  // Uloží className
} forEach _anims;

// Nastavit výchozí výběr na první položku v seznamu (pokud není prázdný)
if (lbSize _ctrlCombo > 0) then {
    _ctrlCombo lbSetCurSel 0;  // Nastaví první položku jako vybranou
};
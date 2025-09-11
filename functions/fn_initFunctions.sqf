/*
    Inicializace funkcí pro RR Zeus Animation Dialog
    Toto zajistí, že všechny funkce budou dostupné od začátku mise
*/

// Definuj globální funkci pro otevření dialogu
RR_openDialogOnClient = {
    params ["_units"];
    
    // Pouze na klientech s GUI
    if (!hasInterface) exitWith {
        diag_log "[RR_ANIM] No interface - skipping dialog";
    };
    
    diag_log format ["[RR_ANIM] Opening dialog on client for units: %1", _units];
    
    RR_anim_units = _units;
    
    [] spawn {
        sleep 0.1;
        if (createDialog "RR_PlayAnimationDialog") then {
            diag_log "[RR_ANIM] Dialog opened successfully on client!";
        } else {
            diag_log "[RR_ANIM] ERROR: Failed to create dialog on client!";
            hint "CHYBA: Dialog se neotevřel!";
        };
    };
};

diag_log "[RR_ANIM] Functions initialized";
class CfgPatches {
    class RR_ZeusAnimDialog {
        units[] = {"RR_Module_PlayAnimation"};
        weapons[] = {};
        requiredAddons[] = {"A3_Modules_F"};
    };
};

class CfgFunctions {
    class rr_zeus_anim {
        class functions {
            file = "\RR_ZeusAnimDialog\functions";
            class playAnimation {};
            class doAnimation {};
            class fillCombo {};
            class executeAnim {}; // PŘIDÁNO - nová funkce
        };
    };
};

class CfgFactionClasses {
    class NO_CATEGORY;
    class RR_Modules: NO_CATEGORY {
        displayName = "[44.RR] Zeus";
        priority = 2;
        side = 7;
    };
};

class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class ModuleDescription {
            class AnyBrain;
        };
    };

    class RR_Module_PlayAnimation: Module_F {
        scope = 2;
        scopeCurator = 2;
        displayName = "$STR_PLAY_ANIM_MODUL";
        icon = "\A3\ui_f\data\GUI\cfg\CommunicationMenu\transport_ca.paa";
        category = "RR_Modules";
        function = "rr_zeus_anim_fnc_playAnimation";
        functionPriority = 1;
        isGlobal = 0; // VRÁCENO NA 0 - jednodušší řešení
        isTriggerActivated = 0;
        isDisposable = 1;
        curatorInfoType = "";
        class ModuleDescription: ModuleDescription {
            description = "Otevře dialog a spustí animaci na jednotce.";
        };
    };
};

#include "dialogs.hpp"
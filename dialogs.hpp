class WS_Button {
    type = 1; // CT_BUTTON
    style = 2; // ST_CENTER
    idc = -1;
    text = "";
    font = "PuristaMedium";
    sizeEx = 0.04;

    colorText[] = {1,1,1,1};
    colorDisabled[] = {0.4,0.4,0.4,1};

    colorBackground[] = {0,0,0,0.7};
    colorBackgroundActive[] = {0,0,0,1};
    colorBackgroundDisabled[] = {0.2,0.2,0.2,0.5};
    colorFocused[] = {0,0,0,1};

    colorShadow[] = {0,0,0,0};
    colorBorder[] = {0,0,0,0};

    soundClick[] = {"",0.07,1};
    soundEnter[] = {"",0.07,1};
    soundPush[] = {"",0.07,1};
    soundEscape[] = {"",0.07,1};

    shadow = 2;
    borderSize = 0;
    offsetX = 0;
    offsetY = 0;
    offsetPressedX = 0;
    offsetPressedY = 0;
};

// === Base GUI classes (minimal) ===
class RscText {
    type = 0; idc = -1; style = 0;
    x = 0; y = 0; w = 0.3; h = 0.037;
    font = "RobotoCondensed"; sizeEx = 0.04;
    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,1};
    text = "";
};
class RscEdit {
    type = 2; idc = -1; style = 0;
    x = 0; y = 0; w = 0.3; h = 0.04;
    font = "RobotoCondensed"; sizeEx = 0.04;
    colorBackground[] = {0,0,0,0.6};
    colorText[] = {1,1,1,1};
    autocomplete = "scripting";
    text = "";
};
class RscCombo {
    type = 4; idc = -1; style = 0;
    x = 0; y = 0; w = 0.3; h = 0.04;
    wholeHeight = 0.3;
    font = "RobotoCondensed"; sizeEx = 0.04;
    colorBackground[] = {0,0,0,0.6};
    colorSelect[] = {1,1,1,1};
    colorText[] = {1,1,1,1};
};

// === Dialog ===
class RR_PlayAnimationDialog {
    idd = 8000;
    movingEnable = 0;
    enableSimulation = 1;
    onLoad = "[] spawn rr_zeus_anim_fnc_fillCombo;";

    class controlsBackground {
        // celé pozadí
        class Background: RscText {
            x = 0.29; y = 0.23;
            w = 0.42; h = 0.32;
            colorBackground[] = {0,0,0,0.7};
        };

        // horní pruh s titulkem
        class TitleBar: RscText {
            text = "$STR_RR_ANIMDIALOG_TITLE";
            x = 0.29; y = 0.23; w = 0.42; h = 0.04;
            colorBackground[] = {0,0,0,0.9};
        };
    };

    class controls {
        class LabelInput: RscText {
            text = "$STR_RR_ANIMDIALOG_LABEL_INPUT";
            x = 0.31; y = 0.29; w = 0.38; h = 0.04;
        };

        class Input: RscEdit {
            idc = 8001;
            text = "Acts_ws_anim_prayer_loop";
            x = 0.31; y = 0.34; w = 0.38; h = 0.04;
        };

        class Combo: RscCombo {
            idc = 8004;
            x = 0.31; y = 0.39; w = 0.38; h = 0.04;
            onLBSelChanged = "_ctrl = _this select 0; _i = _this select 1; ctrlSetText [8001, _ctrl lbData _i];";
            tooltip = "$STR_RR_ANIMDIALOG_COMBO_TOOLTIP";
        };

        class Confirm: WS_Button {
            idc = 8002;
            text = "$STR_RR_ANIMDIALOG_BTN_CONFIRM";
            x = 0.31; y = 0.46; w = 0.18; h = 0.04;
            action = " \
                private _move = ctrlText 8001; \
                closeDialog 0; \
                [_move, RR_anim_units] call rr_zeus_anim_fnc_doAnimation; \
            ";
        };

        class Cancel: WS_Button {
            idc = 8003;
            text = "$STR_RR_ANIMDIALOG_BTN_CANCEL";
            x = 0.51; y = 0.46; w = 0.18; h = 0.04;
            action = "closeDialog 0;";
        };
    };
};
#include "..\..\script_macros.hpp"
/*
    File: fn_vehInventory.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Used a refresher for the vehicle inventory / trunk menu items.
*/

params [
    ["_veh",objNull,[objNull]]
];

if (isNull _veh || !alive _veh) exitWith {closeDialog 0;}; //If null / dead exit menu
disableSerialization;

private _tInv = CONTROL(3500,3502);
private _pInv = CONTROL(3500,3503);
lbClear _tInv;
lbClear _pInv;

private _veh_data = [_veh] call life_fnc_vehicleWeight;
ctrlSetText[3501,format["Trunk (%1/%2)",_veh_data select 1,_veh_data select 0]];

if ((_veh_data select 0) isEqualTo -1) exitWith {closeDialog 0};
private _data = _veh getVariable ["Trunk",[]];
if (count _data isEqualTo 0) then {_veh setVariable ["Trunk",[[],0],true]; _data = [];} else {_data = (_data select 0);};

//Player Inventory Items
{
    _val = ITEM_VALUE(configName _x);

    if (_val > 0) then {
        _pInv lbAdd format ["[%1] - %2",_val,(getText(_x >> "displayName"))];
        _pInv lbSetData [(lbSize _pInv)-1,configName _x];
        _icon = ICON((getText(_x >> "icon")));
        if (!(_icon isEqualTo "")) then {
            _pInv lbSetPicture [(lbSize _pInv)-1,_icon];
        };
    };
} forEach ("true" configClasses (missionConfigFile >> "CfgItems"));

//Trunk Inventory Items
{
    _name = M_CONFIG(getText,"CfgItems",(_x select 0),"displayName");
    _val = (_x select 1);

    if (_val > 0) then {
        _tInv lbAdd format ["[%1] - %2",_val,_name];
        _tInv lbSetData [(lbSize _tInv)-1,(_x select 0)];
        _icon = ICON(M_CONFIG(getText,"CfgItems",(_x select 0),"icon"));
        if (!(_icon isEqualTo "")) then {
            _tInv lbSetPicture [(lbSize _tInv)-1,_icon];
        };
    };
} forEach _data;

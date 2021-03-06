/*
    File: fn_vehicleDelete.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Doesn't actually delete since we don't give our DB user that type of
    access so instead we set it to alive=0 so it never shows again.
*/
params [
    ["_vid", -1, [0]],
    ["_pid", "", [""]]
];

if (_vid isEqualTo -1 || { _pid isEqualTo "" }) exitWith {};

[format ["UPDATE phxcars SET dead='1', alive='0' WHERE pid='%1' AND id='%2'", _pid, [_vid] call DB_fnc_numberSafe],1] call DB_fnc_asyncCall;
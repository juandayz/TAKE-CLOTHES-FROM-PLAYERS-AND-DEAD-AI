private ["_body","_Body_Clothes","_playerNear","_ItemBody_Clothes","_default_Epoch_Clothes","_CurrentPlayerSkin","_playerOutput","_result","_group","_oldGroup","_leader"];
if (dayz_actionInProgress) exitWith {localize "str_player_actionslimit" call dayz_rollingMessages;};
_body = _this select 3;
_Body_Clothes = typeOf _body;
if (isNull _body) exitWith {format["%1 its not a supported skin",cursorTarget] call dayz_rollingMessages;};
 
_playerNear = {isPlayer _x} count (([_body] call FNC_GetPos) nearEntities ["CAManBase", 10]) > 1;
if (_playerNear) exitWith {localize "str_pickup_limit_5" call dayz_rollingMessages;};
 
dayz_actionInProgress = true;
player removeAction s_player_clothes;
s_player_clothes = -1;
 
//Defines Output For take clothes
_ItemBody_Clothes = _Body_Clothes;
switch (_ItemBody_Clothes) do {case "Survivor3_DZ": {_Body_Clothes = "Survivor2_DZ";};case "Bandit1_DZ": {_Body_Clothes = "Survivor2_DZ";};};
_ItemBody_Clothes = "Skin_" + _ItemBody_Clothes;
_default_Epoch_Clothes = isClass (configFile >> "CfgMagazines" >> _ItemBody_Clothes);
//Define OutPut for WearClothes
_CurrentPlayerSkin = (typeOf player);
_playerOutput = "Skin_" + _CurrentPlayerSkin;
 
if ((!_default_Epoch_Clothes) && !(_Body_Clothes in Skins_For_TakeClothes)) exitWith {format["Skin %1 is not supported",_Body_Clothes] call dayz_rollingMessages;dayz_actionInProgress = false;};
 
if (_Body_Clothes in Skins_For_TakeClothes) then {
if (_CurrentPlayerSkin in Skins_For_TakeClothes) then {
_result = [player,"Skin_Survivor2_DZ"] call BIS_fnc_invAdd;
}else{
_result = [player,_playerOutput] call BIS_fnc_invAdd;
};
}else{
_result = [player,_ItemBody_Clothes] call BIS_fnc_invAdd;
};
 
if !(_result) exitWith {"You didn't have enough room in your inventory" call dayz_rollingMessages;dayz_actionInProgress = false;};
 
_body setVariable["clothesTaken",true,true];
 
///////////////////////////////////////////////////////WEAR CLOTHES////////////////////////////////////////////////////////////
 
if (_Body_Clothes in Skins_For_TakeClothes) then {
  
if ((_CurrentPlayerSkin == _Body_Clothes) && (typeOf player in Skins_For_TakeClothes)) exitWith {_body setVariable["clothesTaken",false,false];format["You alredy are using a %1 skin",_Body_Clothes] call dayz_rollingMessages;dayz_actionInProgress = false;};
if (typeOf player in DayZ_Female) exitWith {_body setVariable["clothesTaken",false,false];format["Skin %1 does not allow female characters",_Body_Clothes] call dayz_rollingMessages;dayz_actionInProgress = false;};
_group = createGroup west;
[dayz_playerUID,dayz_characterID,_Body_Clothes] call player_humanityMorph;
[player] joinSilent _group;
 
format["Your new outfit is %1. Your old clothes was added to your inventory",_Body_Clothes] call dayz_rollingMessages;
 
}else{
///////////////////////////////////////////////////////TAKE CLOTHES////////////////////////////////////////////////////////////
player playActionNow "Medic";
format["One %1 has been added to your inventory!",_Body_Clothes] call dayz_rollingMessages;
};
dayz_actionInProgress = false; 

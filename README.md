# TAKE-CLOTHES-FROM-PLAYERS-AND-DEAD-AI

The Install guide was writing thinking that you already have ESSV3 and Takeclothes.  You can use it without that mods but im lazy today to write how.

Based on Zabns take clothes. Tnks @nova for the help and idea!

Allow players for take clothes from otehrs players corps and ai too.
Fix the deafault wearclothes where others models that are not DZ models cannot wear his clothes.
Allow admins to use anykind of model faction in ESSV3 since the script relocate the player in west side again.

Issues: Players lost his DZE_Groups when they wear ai clothes. but they can join again.

**INSTALL:

1.Open your custom compiles.sqf and call a new player_wearclothes into !Dedicated section.

```ruby
//takeclothes
player_wearClothes = compile preprocessFileLineNumbers "dayz_code\compile\player_wearClothes.sqf";
```

2.Open your custom variables.sqf and in somewhere paste: 
**NOTE: YOu can add your owns. This skins gonna be used by takeclothes for allow players to take from dead ai. Also you can use this one in your class spawn selector of ESSV3. And in WAI mission or/and DZAI and whatever other AI mission file.

```
//READY FOR TAKE CLOTHES//
Skins_For_TakeClothes = [
"GUE_Soldier_Sniper","TK_INS_Soldier_AAT_EP1","TK_INS_Soldier_2_EP1","TK_INS_Soldier_EP1",
"TK_INS_Soldier_4_EP1","TK_INS_Soldier_3_EP1","TK_GUE_Soldier_2_EP1","GUE_Soldier_CO","GUE_Soldier_Crew_DZ",
"TK_Soldier_EP1","RUS_Commander","TK_Soldier_Officer_EP1","RU_Soldier_Officer","MVD_Soldier","RU_Soldier_Pilot",
"Soldier_GL_M16A2_PMC","Soldier_Bodyguard_AA12_PMC_DZ"];
AllPlayers = AllPlayers + Skins_For_TakeClothes;
//READY FOR TAKE CLOTHES//
```

3.Now assing some of those skins for example in WAI:\@DayZ_Epoch_Server\addons\dayz_server\WAI\config.sqf 

```ruby
ai_hero_skin= ["MVD_Soldier_GL","TK_Soldier_EP1","TK_Soldier_Officer_EP1","RU_Soldier_Officer"];
ai_bandit_skin =["GUE_Soldier_Sniper","TK_Aziz_EP1","GUE_Soldier_Crew_DZ","GUE_Soldier_CO"];
ai_special_skin             = ["RUS_Commander"];
```
Or for example in DZAI: 
```ruby
DZAI_BanditTypes =["TK_Aziz_EP1","TK_INS_Soldier_3_EP1","TK_INS_Soldier_EP1","TK_INS_Soldier_AAT_EP1"];
```
4.Open your ESSV3 folder spawn/main.sqf 
A.Find: 
```
if !(PVCDZ_plr_Login2 select 4) exitWith {

    #include "functions\finish.sqf"

    #include "functions\cleanup.sqf"
};
```
Replace by:

```ruby
private ["_group"];
if !(PVCDZ_plr_Login2 select 4) exitWith {
#include "functions\finish.sqf"
#include "functions\cleanup.sqf"
f (typeOf player in Skins_For_TakeClothes) then {
_group = createGroup west;
[player] joinSilent _group;
};
};
```
B.Find:
```
_handle = [dayz_playerUID,dayz_characterID,_model] spawn player_humanityMorph;
uiSleep 0.2;
```
Below paste:
```ruby
if (typeOf player in Skins_For_TakeClothes) then {
_group = createGroup west;
[player] joinSilent _group;
};
```

5.Drop player_wearclothes.sqf into MPMissions\your instance map\dayz_code\compile\
6.Replace your TakeClothes.sqf by the one provided here.






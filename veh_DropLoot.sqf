/* Vehicle loot dropping system
	
	Coded by: [GSG] Az
	For use on: GSGaming servers only!
	
*/

// Variables - Please modify these to your needs -------------------------------------------------------------->

/* Set the mod directory */					_modDir = "z\addons\dayz_server\mods\vLoot";
/* Should we alert ALL players */			_alertPlayers = false;			// Default = false			
/* Should loot spawn in a weapon box? */ 	_isContainer = false; 			// Default = false
/* Should grass be cut around the box? */ 	_cutGrass = true; 				// Default = true
/* Class for container, if enabled */ 		_container = "RUVehicleBox";	// Default = "RUVehicleBox"
/* Toggle for weapon spawning */			_isSpawn_W = true;				// Default = true - Set to false to disable
/* Toggle for backpack spawning */ 			_isSpawn_B = true;				// Default = true - Set to false to disable
/* Toggle for magazine spawning */ 			_isSpawn_M = true;				// Default = true - set to false to disable
/* Set the time until cleanup */			_waitTime = 0;				// Default = 900 - Set to 0 to make permaloot
/* Minimum distance to spawn (VehPOS) */	_minDistance = 0;				// Default = 10
/* Maximum distance to spawn (VehPOS) */	_maxDistance = 5;				// Default = 25
/* Maximum distance from nearest object */ 	_nearObject_Max = 3;			// Default = 10
/* Cooling off period to stationary */		_coolPeriod = 10;				// Default = 10
/* Allowed backpack classes */ 				_bClass = 
											[
												"CZ_VestPouch_EP1", "DZ_Patrol_Pack_EP1", "DZ_Assault_Pack_EP1", "DZ_CivilBackpack_EP1",
												"DZ_ALICE_Pack_EP1", "DZ_Backpack_EP1", "DZ_British_ACU", "DZ_Czech_Vest_Puch",
												"DZ_GunBag_EP1", "DZ_TerminalPack_EP1", "DZ_TK_Assault_Pack_EP1", "DZ_LargeGunBag_EP1"
											];
/* Enable debug? */							_debugEnabled = true; 			// Enable this to spam RPT with useless information
/* Enable EXTREME debug? */ 				_exDebugEnabled = false;		// Enable logging of EVERYTHING! Will DEGRADE server performance!

// Playing with these variables might do something cool (But in all honesty it will probably just break)

/* Can be in water */						_cWater = 0;					// Default = 0 | 0 - cant be in water, 1 - ?
/* Terrain Gradient */						_terrGrad = 2000;				// Default = 2000
/* Shore Mode */							_sMode = 0;						// Going out on a limb here, this shouldn't be changed :/

// End of variables - Please do not modify anything below this line --------------------->
private ["_minDistance","_maxDistance","_nearObject_Max","_cWater","_terrGrad","_smode","_container","_waitTime","_bClass","_prevInv","_object","_prevInv","_coolPeriod","_cutGrass"];
_object = _this select 0;
_prevInv = _this select 1;
	
// Just making sure we haven't been deleted by an admin!
if(isNull _object) exitWith {
	if (_debugEnabled) then {
		diag_log format["VEHICLE LOOT: Skipping Null Object: %1", _object];
	};
};
if ((str(_prevInv)) == '[]') exitWith {
	if (_debugEnabled) then {
		diag_log format["VEHICLE LOOT: Skipping Null Inventory: %1", _prevInv];
	};
};
if (_debugEnabled) then {
	diag_log format["VEHICLE LOOT: Starting for object : %1", _object]
};

//How are we going to do this?
if (_isContainer) then {
	_script = format["%1\v_loot_container.sqf", _modDir];
	if (_exDebugEnabled) then { diag_log format["VEHICLE LOOT EX DEBUG: SCRIPT FOR CONTAINER = %1",_script]; diag_log format["VEHICLE LOOT EX DEBUG: Loot for object = %1",_prevInv]; }; 
	[_object,_minDistance,_maxDistance,_nearObject_Max,_cWater,_terrGrad,_smode,_container,_waitTime,_bClass,_prevInv,_coolPeriod,_cutGrass] execVM _script;
} else {
	_script = format["%1\v_loot_normal.sqf", _modDir];
	if (_exDebugEnabled) then { diag_log format["VEHICLE LOOT EX DEBUG: SCRIPT FOR NORMAL = %1",_script]; diag_log format["VEHICLE LOOT EX DEBUG: Loot for object = %1",_prevInv]; }; 
	[_object,_minDistance,_maxDistance,_nearObject_Max,_cWater,_terrGrad,_smode,_container,_waitTime,_bClass,_prevInv,_coolPeriod,_cutGrass] execVM _script;
};
private ["_object","_minDistance","_maxDistance","_nearObject_Max","_cWater","_terrGrad","_smode","_container","_waitTime","_bClass","_prevInv","_prevInv","_coolPeriod","_cutGrass"];
_object = _this select 0;
_minDistance = _this select 1;
_maxDistance = _this select 2;
_nearObject_Max = _this select 3;
_cWater = _this select 4;
_terrGrad = _this select 5;
_smode = _this select 6;
_container = _this select 7;
_waitTime = _this select 8;
_bClass = _this select 9;
_prevInv = _this select 10;
_coolPeriod = _this select 11;
_cutGrass = _this select 12;

_exDebugEnabled = true;
_debugEnabled = true;


sleep _coolPeriod;

if (_exDebugEnabled) then { 
	diag_log format
	[
	"VEHICLE LOOT EX DEBUG: v_loot_container.sqf - Vars 1 | _object : %1, _minDistance : %2, _maxDistance : %3, _nearObject_Max : %4, _cWater : %5, _terrGrad : %6  "
	,_object,_minDistance,_maxDistance,_nearObject_Max,_cWater,_terrGrad
	];  
	diag_log format
	[
	"VEHICLE LOOT EX DEBUG: v_loot_container.sqf - Vars 2 | _smode : %1, _container : %2, _waitTime : %3, _bClass : %4"
	,_smode,_container,_waitTime,_bClass]; 
	diag_log format
	[
	"VEHICLE LOOT EX DEBUG: v_loot_container.sqf - Vars 3 | _prevInv = %1",_prevInv];
	}; 

// Lets get the cargo!
_weaponCargo = _prevInv select 0; 
_weapons = _weaponCargo select 0;
_wCounts = _weaponCargo select 1;
_magCargo = _prevInv select 1;
_mags = _magCargo select 0;
_mCounts = _magCargo select 1;
_backpCargo = _prevInv select 2;
_backpacks = _backpCargo select 0;
_bCounts = _backpCargo select 1;

if (_exDebugEnabled) then { 
	diag_log format["VEHICLE LOOT EX DEBUG: Weapon Cargo : %1",_weaponCargo]; 
	diag_log format["VEHICLE LOOT EX DEBUG: Magazine Cargo : %1",_magCargo]; 
	diag_log format["VEHICLE LOOT EX DEBUG: Backpack Cargo : %1",_backpCargo]; 
}; 

// Lets create the container!
_position = getPosATL _object;
_worldspace = [ round(direction _object), _position];
_shinyNewPOS = [_position,_minDistance,_maxDistance,_nearObject_Max,_cWater,_terrGrad,_smode] call BIS_fnc_findSafePos;
_tempContainer = createVehicle [_container, _shinyNewPOS, [], 0, "can_collide"];
clearMagazineCargoGlobal _tempContainer;
clearWeaponCargoGlobal _tempContainer;
clearBackpackCargoGlobal _tempContainer;

if (_exDebugEnabled) then { 
	diag_log format["VEHICLE LOOT EX DEBUG: POS of Object : %1",_position]; 
	diag_log format["VEHICLE LOOT EX DEBUG: Worldspace : %1",_worldspace]; 
	diag_log format["VEHICLE LOOT EX DEBUG: Safe POS : %1",_shinyNewPOS]; 
	diag_log format["VEHICLE LOOT EX DEBUG: Container POS : %1",getPosATL _tempContainer]; 
}; 

// Lets add all the things!
{	
	if (_exDebugEnabled) then { 
	diag_log format["VEHICLE LOOT EX DEBUG: Adding Weapon : %1 | In : %2 | At : %3",_x, _tempContainer, getPosATL _tempContainer];  
	}; 
	_count = _wCounts select (_weapons find _x);
	_tempContainer addWeaponCargoGlobal [_x,_count];
} forEach _weapons;
{	
	if (_exDebugEnabled) then { 
	diag_log format["VEHICLE LOOT EX DEBUG: Adding Magazine : %1 | In : %2 | At : %3",_x, _tempContainer, getPosATL _tempContainer];  
	}; 
	_count = _mCounts select (_mags find _x);
	_tempContainer addMagazineCargoGlobal [_x,_count];
} forEach _mags;
{	
	if (_exDebugEnabled) then { 
	diag_log format["VEHICLE LOOT EX DEBUG: Adding Backpack : %1 | In : %2 | At : %3",_x, _tempContainer, getPosATL _tempContainer];  
	}; 
	_count = _bCounts select (_backpacks find _x);
	_tempContainer addBackpackCargoGlobal [_x,_count];
} forEach _backpacks;

if (_cutGrass) then {
	_tempclutter = createVehicle ["ClutterCutter_EP1",_shinyNewPOS,[], 1, "CAN_COLLIDE"];
};

if (_waitTime > 0) then {
	if (_debugEnabled) then { 
		diag_log format["VEHICLE LOOT: Starting timeout period : %1",_waitTime];  
	};
	sleep _waitTime;
	deleteVehicle _tempContainer;
} else {
	if (_debugEnabled) then { 
		diag_log format["VEHICLE LOOT: Starting permaloot paramater on : %1",_tempContainer];  
	};
	_tempContainer setVariable["permaLoot", true];
};


server_updateObject.sqf


	_object_killed = {
		private["_hitpoints","_array","_hit","_selection","_key","_damage"];
		_hitpoints = _object call vehicle_getHitpoints;
		_prevInv = _object getVariable["lastInventory",[]];
		[_object,_prevInv] call server_vehicleloot;
		//_damage = damage _object;
		_damage = 1;
		_array = [];
		{
			_hit = [_object,_x] call object_getHit;
			_selection = getText (configFile >> "CfgVehicles" >> (typeOf _object) >> "HitPoints" >> _x >> "name");
			if (_hit > 0) then {_array set [count _array,[_selection,_hit]]};
			_hit = 1;
			_object setHit ["_selection", _hit]
		} forEach _hitpoints;
		
		if (_objectID == "0") then {
			_key = format["CHILD:306:%1:%2:%3:",_uid,_array,_damage];
		} else {
			_key = format["CHILD:306:%1:%2:%3:",_objectID,_array,_damage];
		};
		//diag_log ("HIVE: WRITE: "+ str(_key));
		_key call server_hiveWrite;
		_object setVariable ["needUpdate",false,true];
	};
	
	
	
server_functions.sqf

	/* Serverside loot */
	server_vehicleloot = 			compile preprocessFileLineNumbers "\z\addons\dayz_server\mods\vLoot\veh_Droploot.sqf";
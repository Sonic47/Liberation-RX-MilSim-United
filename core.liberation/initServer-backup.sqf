

addMissionEventHandler ['EntityKilled',{
	
	params ["_unit", "_killer"];
	
	if (isPlayer _unit) then {
		
		_hs_unconscious = _unit getVariable ['ACE_isUnconscious', false];
		if (_hs_unconscious == true) then {
			_unit setVariable ["GREUH_ammo_count", ( (_unit getVariable ["GREUH_ammo_count", 25]) - 25), true];
		};
		
	}else{
		
		if ( (side group _unit == opfor) && (isPlayer _killer) ) then {
			_killer setVariable ["GREUH_ammo_count", ( (_killer getVariable ["GREUH_ammo_count", 0]) + 1), true];
			[_killer, 1] remoteExec ["addScore", 2];
		};
		
		if (side group _unit == civilian && side _killer == blufor) then {
			_msg = format ["%1 killed a civillian. Penalty: -15 rank and ammo", name _killer];
			[gamelogic, _msg] remoteExec ["globalChat", 0];
			_killer setVariable ["GREUH_ammo_count", ( (_killer getVariable ["GREUH_ammo_count", 15]) - 15), true];
			[_killer, -15] remoteExec ["addScore", 2];
		};
		/*
		
		
		_tre = [ configFile >> "CfgVehicles" >> typeOf _unit, true ] call BIS_fnc_returnParents; 

		if (("House" in _tre) && !("Strategic" in _tre) && side _killer == blufor) then {
			_msg = format ["%1 killed a House. Penalty: -50 rank and ammo", name _killer];
			[gamelogic, _msg] remoteExec ["globalChat", 0];
			_killer setVariable ["GREUH_ammo_count", ( (_killer getVariable ["GREUH_ammo_count", 50]) - 50), true];
			[_killer, -50] remoteExec ["addScore", 2];
		};
		
		*/
	};
	
}];



addMissionEventHandler ['HandleDisconnect',{
	_unit = _this select 0;
	_hs_unconscious = _unit getVariable ['ACE_isUnconscious', false];
	if (_hs_unconscious == true) then {
		_unit setVariable ["GREUH_ammo_count", ( (_unit getVariable ["GREUH_ammo_count", 25]) - 25), true];
	};
}];



["Initialize", [true]] call BIS_fnc_dynamicGroups;

/*
This deals with creating a diary entry on the map screen after mission launch so that players can see who is in what squad and what radio channels they are on.
Only one field in here needs to be changed to match the LR channels as defined in functions\misc\fn_setradio.sqf.
*/

_TFD_ORBAT = param [0, [], [[]]];

player createDiarySubject [ "roster" , "ORBAT & Signal" ];

_glist = [];
_gList = _glist + _TFD_ORBAT;
reverse _gList;

player createDiaryRecord [ "roster" ,
							[ "LR Channels" ,
								"Platoon Net ~ Ch 1" ]]; // where neccessary change the default long range radio message here (does not change actual channels)

{

	player createDiaryRecord [ "roster" ,
								[ "SR Channels" ,
									format[ "%1 ~ Ch %2" , (_x select 0) , (_x select 1) ]]];

} forEach _gList;

_ar = playableUnits;
reverse _ar;

{

_g = format[ "%1" , groupID group _x ];
_n = name _x;
_r =  roleDescription player;

if (player diarySubjectExists _g) then {

		player createDiaryRecord [ "roster" ,
			[ _g ,
					format["%1: <marker name=''>%2</marker><br/>", _n , _r ] 
			]];
			
		} else {
		
		player createDiarySubject [ "roster" , _g ];
		
		player createDiaryRecord [ "roster" ,
			[ _g ,
					format["%1: <marker name=''>%2</marker><br/>", _n , _r ] 
			]];
			
		};
} forEach _ar;
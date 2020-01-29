-- I got this idea for using a single sprite instead of PerChoiceScrollElement
-- from k//eternal's PROJEKTXV theme.
--
-- The "GameCommand" var is defined in ScreenSelectMaster.cpp:
--   LuaThreadVariable var("GameCommand", LuaReference::Create(&mc));
local style = Var("GameCommand"):GetName()

local t = Def.ActorFrame{}

-- Loads the graphic which matches the choice name from metrics.ini!
t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(align,0.5,0;xy,_screen.cx+147,_screen.cy-60);
	OnCommand=cmd(rotationy,-90;sleep,0.333;linear,0.05;rotationy,0);
	OffCommand=cmd(sleep,0.2;diffusealpha,0);
	GainFocusCommand=cmd(stoptweening;linear,0.025;addx,5;linear,0.025;addx,-5);
	LoadActor(style);
};

return t

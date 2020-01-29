local gc = Var("GameCommand");
local t = Def.ActorFrame {};
local max_stages = PREFSMAN:GetPreference( "SongsPerPlay" );

t[#t+1] = Def.ActorFrame {
	LoadActor( gc:GetName())..{
		InitCommand=cmd(Center);
	};
};

return t

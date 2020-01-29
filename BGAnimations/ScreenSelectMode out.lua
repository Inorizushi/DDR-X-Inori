local t = Def.ActorFrame {
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,color("0,0,0,0"));
		StartTransitioningCommand=cmd(sleep,0.6;linear,0.3;diffusealpha,1);
	};
};

return t;

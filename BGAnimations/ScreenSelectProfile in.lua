return Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,Color.Black);
		OnCommand=cmd(diffusealpha,1;sleep,0.3;linear,0.2;diffusealpha,0);
	};
};

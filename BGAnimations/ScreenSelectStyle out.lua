return Def.ActorFrame {

LoadActor(THEME:GetPathS("","_swoosh_out"))..{
	StartTransitioningCommand=cmd(play);
};

Def.Quad{
	OnCommand=cmd(FullScreen;diffuse,Color.Black;diffusealpha,0;sleep,0.667);
};

}

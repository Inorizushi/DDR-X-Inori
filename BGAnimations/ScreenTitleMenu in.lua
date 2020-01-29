return Def.ActorFrame {

--Dummy
Def.Quad{
	InitCommand=cmd(diffuse,Color.Black;FullScreen);
	StartTransitioningCommand=cmd(diffusealpha,1;sleep,0.1;linear,0.2;diffusealpha,0);
};

}

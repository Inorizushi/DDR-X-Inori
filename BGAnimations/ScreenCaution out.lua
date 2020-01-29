local t = Def.ActorFrame {
	--Dummy
	Def.Actor{
		StartTransitioningCommand=cmd(diffusealpha,0;sleep,0.4);
	};
}

return t;

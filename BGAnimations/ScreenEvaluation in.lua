local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {

	Def.Actor{
	OnCommand=cmd(diffusealpha,0;sleep,1.5;);
	};

	LoadActor("eval_in")..{
		OnCommand=cmd(play);
	};
}

return t;

return Def.ActorFrame{
	LoadActor("back")..{
		InitCommand=cmd(zoomto,WideScale(230,312),20);
	};
};

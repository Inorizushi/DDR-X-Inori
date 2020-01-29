return Def.ActorFrame {
	StartTransitioningCommand=cmd(sleep,0.283);

	LoadActor( THEME:GetPathS("","_swooshInstructions") )..{
		StartTransitioningCommand=cmd(play;sleep,.5);
	};
}

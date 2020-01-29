return Def.ActorFrame {
	StartTransitioningCommand=cmd(sleep,0.5);

	LoadActor( THEME:GetPathS("","_swooshInstructions") )..{
		StartTransitioningCommand=cmd(play);
	};
}

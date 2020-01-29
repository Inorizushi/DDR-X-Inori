return Def.ActorFrame {
	LoadActor(THEME:GetPathS("","_MusicIn"))..{
		OnCommand=cmd(play);
	};
}

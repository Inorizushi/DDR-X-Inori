return Def.ActorFrame {

LoadActor(THEME:GetPathS("","_swooshStyle"))..{
	OnCommand=cmd(play);
};

Def.Quad{
OnCommand=cmd(diffuse,Color.Black;FullScreen;diffusealpha,1;decelerate,0.266;diffusealpha,0);
};

}

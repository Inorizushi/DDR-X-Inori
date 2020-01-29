return Def.ActorFrame {
	Def.ActorFrame{
		LoadActor(THEME:GetPathG("","ScreenWithMenuElements header/headbg"))..{
			InitCommand=cmd(x,_screen.cx-180;y,30);
			OnCommand=cmd(diffusealpha,0;sleep,0.5;diffusealpha,1);
			OffCommand=cmd(diffusealpha,0);
		};
		LoadActor(THEME:GetPathG("","ScreenWithMenuElements header/text/sel_opt"))..{
			InitCommand=cmd(x,_screen.cx-171;y,_screen.cy-208;rotationz,-4);
			OnCommand=cmd(diffusealpha,0;sleep,0.5;diffusealpha,1);
			OffCommand=cmd(diffusealpha,0);
		};
	};
	LoadActor(THEME:GetPathB("","ScreenPlayerOptions decorations"));
}

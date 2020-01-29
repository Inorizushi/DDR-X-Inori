local Banner =
  Def.Banner{
    SetCommand=function(self,params)
      self:finishtweening()
      local course = GAMESTATE:GetCurrentCourse();
      local so = GAMESTATE:GetSortOrder();
      local mw = SCREENMAN:GetTopScreen():GetChild("MusicWheel")
      if course then
        if course:HasBanner() then
          self:LoadBackground(course:GetBannerPath());
        else
          self:Load(THEME:GetPathG("","Common fallback banner"));
        end;
      else
        self:Load( THEME:GetPathG("","Common fallback banner") );
      end;
      self:zoomtowidth(256):zoomtoheight(80)
    end;
};

return Def.ActorFrame{
  Def.ActorFrame{
		InitCommand=cmd(xy,_screen.cx-210,_screen.cy-127);
		OnCommand=cmd(draworder,6;addx,-SCREEN_WIDTH/2;sleep,0.2;decelerate,0.233;addx,(SCREEN_WIDTH/2)+11;linear,0.066;addx,-11);
		OffCommand=cmd(sleep,0.266;accelerate,0.133;addx,-SCREEN_WIDTH/2);
    LoadActor("BannerFrame");
    LoadActor( "../_playmode" )..{
      InitCommand=cmd(x,-106;y,45;);
    };
    Banner..{
      InitCommand=cmd(xy,4,-9);
      CurrentSongChangedMessageCommand=cmd(finishtweening;sleep,0;queuecommand,"Set");
    };
  };
};

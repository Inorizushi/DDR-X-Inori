local Banner =
  Def.Banner{
    SetCommand=function(self,params)
      self:finishtweening()
      local song = GAMESTATE:GetCurrentSong();
      local so = GAMESTATE:GetSortOrder();
      local mw = SCREENMAN:GetTopScreen():GetChild("MusicWheel")
      if song then
        if song:HasBanner() then
          self:LoadBackground(song:GetBannerPath());
          self:zoomto(256,80)
          self:croptop(0):cropbottom(0)
        elseif song:HasJacket() then
          self:LoadBackground(song:GetJacketPath());
          self:zoomto(256,256);
          self:croptop(0.345):cropbottom(0.345)
        elseif song:HasBackground() then
          self:LoadFromSongBackground(GAMESTATE:GetCurrentSong());
          self:croptop(0):cropbottom(0)
        else
          self:Load(THEME:GetPathG("","Common fallback banner"));
          self:croptop(0):cropbottom(0)
        end;
      elseif mw:GetSelectedType('WheelItemDataType_Section')  then
        self:Load(bannerset(self))
        self:zoomto(256,80)
        self:croptop(0):cropbottom(0)
      else
        self:Load( THEME:GetPathG("","Common fallback banner") );
        self:croptop(0):cropbottom(0)
        self:zoomto(256,80)
      end;
    end;
};

return Def.ActorFrame{
  Def.ActorFrame{
		InitCommand=cmd(xy,WideScale(_screen.cx-180,_screen.cx-210),_screen.cy-127);
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
    Def.Sprite{
      InitCommand=cmd(xy,4,-9);
      SetCommand=function(self)
        local song = GAMESTATE:GetCurrentSong();
        local so = GAMESTATE:GetSortOrder();
        local mw = SCREENMAN:GetTopScreen():GetChild("MusicWheel")
        if not song then
          if mw:GetSelectedType() == 'WheelItemDataType_Random' then
            self:Load(THEME:GetPathG("","Banner random"))
            self:diffusealpha(1);
          elseif mw:GetSelectedType('WheelItemDataType_Section') then
            local group = mw:GetSelectedSection()
            if so == "SortOrder_Group" then
              self:diffusealpha(0)
            else
              self:diffusealpha(0)
            end;
          else
            self:diffusealpha(0)
          end;
        end;
      end;
      CurrentSongChangedMessageCommand=function(self, params)
        self:queuecommand("Set")
      end;
    };
  };
};

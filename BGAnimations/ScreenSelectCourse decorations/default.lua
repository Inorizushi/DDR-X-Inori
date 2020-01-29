local t = Def.ActorFrame{
    LoadActor(THEME:GetPathG("", "ScreenWithMenuElements header"));
    LoadActor(THEME:GetPathG("", "ScreenWithMenuElements footer"));
};

function WheelMove(mov)
    local mw = SCREENMAN:GetTopScreen("ScreenSelectMusic"):GetChild("MusicWheel");
    mw:Move(mov)
  end;
  
  for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
  t[#t+1] = Def.ActorFrame{
    OnCommand=function(self)
      SCREENMAN:GetTopScreen():AddInputCallback(DDR.Input(self))
      SCREENMAN:set_input_redirected(pn, false)
    end,
    OffCommand=function(self)
      SCREENMAN:GetTopScreen():RemoveInputCallback(DDR.Input(self))
      SCREENMAN:set_input_redirected(pn, false)
    end,
    MenuLeftCommand=function(self) WheelMove(-1) end;
    MenuLeftRepeatCommand=cmd(queuecommand,"MenuLeft");
    MenuLeftReleaseCommand=function(self) WheelMove(0) end;
    MenuRightCommand=function(self) WheelMove(1) end;
    MenuRightRepeatCommand=cmd(queuecommand,"MenuRight");
    MenuRightReleaseCommand=function(self) WheelMove(0) end;
    BackCommand=function(self)SCREENMAN:GetTopScreen():SetNextScreenName("ScreenTitleMenu"):StartTransitioningScreen("SM_MenuTimer") end;
    StartReleaseCommand=function(self)
      local mw = SCREENMAN:GetTopScreen("ScreenSelectMusic"):GetChild("MusicWheel");
          local course = GAMESTATE:GetCurrentCourse()
          if course then
              SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_MenuTimer")
          --[[elseif mw:GetSelectedType() == 'WheelItemDataType_Section' then
        if GAMESTATE:GetExpandedSectionName() == mw:GetSelectedSection() then
          mw:SetOpenSection("")
        else
          mw:SetOpenSection(mw:GetSelectedSection())
        end;
        SOUND:PlayOnce(THEME:GetPathS("","MusicWheel expand.ogg"))]]--
      else
          end;
      end;
    StartRepeatCommand=function(self)
          local mw = SCREENMAN:GetTopScreen():GetChild("MusicWheel")
      local course = GAMESTATE:GetCurrentCourse()
          --if mw:GetSelectedType('WheelItemDataType_Song') then
      if course then
              SCREENMAN:AddNewScreenToTop("ScreenPlayerOptions","SM_MenuTimer")
        SCREENMAN:set_input_redirected(pn, false)
      else
          end;
      end;
  };
  end;

--[[t[#t+1] = Def.Actor{
    OnCommand=function(s)
        local mw = SCREENMAN:GetTopScreen():GetChild("MusicWheel")
        mw:ChangeSort("SortOrder_AllCourses")
    end,
}]]--

t[#t+1] = Def.ActorFrame{
    --Decorations
	LoadActor(THEME:GetPathB("","ScreenSelectMusic decorations/_bg"))..{
        OnCommand=cmd(FullScreen;cropbottom,1;sleep,0.265;linear,0.25;cropbottom,0);
        OffCommand=cmd(sleep,0.016;accelerate,0.25;addx,380);
    };
    LoadActor(THEME:GetPathB("","ScreenSelectMusic decorations/playerframe_bg"))..{
        OnCommand=cmd(x,SCREEN_CENTER_X-200;y,SCREEN_CENTER_Y+93;addx,-294;rotationz,-90;diffusealpha,0;sleep,0.2;linear,0.166;rotationz,0;addx,230;diffusealpha,1;linear,0.05;rotationz,10;addx,64;linear,0.066;rotationz,0);
        OffCommand=cmd(sleep,0.266;accelerate,0.133;addx,-SCREEN_WIDTH/2);
        };
    LoadActor("BannerHandler.lua");
};

t[#t+1] = StandardDecorationFromFile("CourseContentsList","CourseContentsList")

return t;
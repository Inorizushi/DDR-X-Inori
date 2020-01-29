local t = Def.ActorFrame{
  OnCommand=cmd(sleep,4);};

t[#t+1] = Def.ActorFrame{
  LoadActor("_doors/Open.lua")..{
    OnCommand=cmd(queuecommand,"AnOn");
  };
  LoadActor("_Banner/Side Off.lua");
  Def.ActorFrame{
    InitCommand=cmd(xy,_screen.cx,_screen.cy-133);
    OnCommand=cmd(sleep,0.316;decelerate,0.066;zoomx,1.05;zoomy,0);
    LoadActor(THEME:GetPathB("","_Banner/BannerFrame"));
    Def.Banner{
      BeginCommand=cmd(playcommand,'Set');
      SetCommand=function(self)
        local songorcourse;
        if GAMESTATE:IsCourseMode() then
          songorcourse = GAMESTATE:GetCurrentCourse()
        else
          songorcourse = GAMESTATE:GetCurrentSong()
        end;
        if songorcourse then
          if GAMESTATE:IsCourseMode() then
            self:LoadFromCourse(songorcourse)
          else
            self:LoadFromSong(songorcourse)
          end;
        end;
        self:setsize(256,80);
      end;
    };
  };
};

t[#t+1] = Def.ActorFrame{
  InitCommand=cmd(Center;zoom,1.2);
  LoadActor(THEME:GetPathB("","_Banner/stageframe"))..{
    OnCommand=cmd(rotationz,-11.5;sleep,0.05;linear,0.1;diffusealpha,0;rotationz,-90);
  };
  LoadActor(THEME:GetPathB("","_Banner/s01"))..{
    InitCommand=cmd(xy,-181,-13);
    OnCommand=cmd(linear,0.1;diffusealpha,0);
  };
  LoadActor(THEME:GetPathB("","_Banner/s02"))..{
    InitCommand=cmd(xy,179,2);
    OnCommand=cmd(linear,0.1;diffusealpha,0);
  };
  LoadActor("ScreenStageInformation in/StageDisplay")..{
    OnCommand=cmd(rotationz,-11.5;sleep,0.05;linear,0.1;diffusealpha,0;rotationz,-90);
  };
};

return t;

local t = Def.ActorFrame{
  OnCommand=cmd(sleep,4);
};

--Sounds
t[#t+1] = Def.ActorFrame{
  LoadActor(THEME:GetPathS("","_Doors/Close.ogg"))..{
    OnCommand=cmd(sleep,0.2;queuecommand,"Play");
    PlayCommand=cmd(play)
  };
  LoadActor(THEME:GetPathS("","_Doors/end.ogg"))..{
    OnCommand=cmd(sleep,1.516;queuecommand,"Play");
    PlayCommand=cmd(play)
  };
  LoadActor(THEME:GetPathS("","_Doors/splatter.ogg"))..{
    OnCommand=cmd(sleep,1.966;queuecommand,"Play");
    PlayCommand=cmd(play)
  };
};

--Door
t[#t+1] = LoadActor(THEME:GetPathB("","_doors/Close.lua"))..{
  OnCommand=cmd(queuecommand,"AnOn");
};

--Banner
t[#t+1] = Def.ActorFrame{
  LoadActor(THEME:GetPathB("","_Banner/Side On"))..{
    InitCommand=cmd(xy,_screen.cx-158,_screen.cy-110);
  };
  LoadActor(THEME:GetPathB("","_Banner/Side On"))..{
    InitCommand=cmd(xy,_screen.cx+158,_screen.cy-110;zoomx,-1);
  };
  Def.ActorFrame{
    InitCommand=cmd(xy,_screen.cx,_screen.cy-133);
    OnCommand=cmd(zoomy,0;diffusealpha,0.8;sleep,0.000;sleep,0.816;decelerate,0.15;zoomy,1;diffusealpha,1;accelerate,0.033;zoomx,1.06;decelerate,0.033;zoomx,1);
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
  LoadActor("../_playmode")..{
    InitCommand=cmd(xy,_screen.cx-107,_screen.cy-90;valign,0);
	   OnCommand=cmd(zoomy,0;diffusealpha,0.8;addy,-43;sleep,0.000;sleep,0.816;decelerate,0.15;zoomy,1;diffusealpha,1;addy,43;accelerate,0.033;zoomx,1.05;addx,-9;decelerate,0.033;zoomx,1;addx,9);
	};
};

--Stage Indicator
t[#t+1] = Def.ActorFrame{
  InitCommand=cmd(Center;zoom,1.2);
  LoadActor(THEME:GetPathB("","_Banner/stageframe"))..{
    OnCommand=cmd(diffusealpha,0;sleep,0.000;sleep,1.516;accelerate,0.3;rotationz,349.5;diffusealpha,1;accelerate,0.05;zoom,1.6;decelerate,0.083;zoom,0.95;decelerate,0.016;zoom,1);
  };
  LoadActor(THEME:GetPathB("","_Banner/s01"))..{
    InitCommand=cmd(xy,-181,-13);
    OnCommand=cmd(diffusealpha,0;sleep,0.000;sleep,1.966;diffusealpha,1);
  };
  LoadActor(THEME:GetPathB("","_Banner/s02"))..{
    InitCommand=cmd(xy,179,2);
    OnCommand=cmd(diffusealpha,0;sleep,0.000;sleep,2.016;diffusealpha,1);
  };
  LoadActor("StageDisplay")..{
    OnCommand=cmd(diffusealpha,0;sleep,0.000;sleep,1.516;accelerate,0.3;rotationz,349.5;diffusealpha,1;accelerate,0.05;zoom,1.6;decelerate,0.083;zoom,0.95;decelerate,0.016;zoom,1);
  };
};

return t;

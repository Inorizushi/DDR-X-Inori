return Def.ActorFrame{
  Def.ActorFrame{
    InitCommand=cmd(xy,_screen.cx-3,_screen.cy-105);
	OffCommand=cmd(linear,.133;zoomy,0);
	GainFocusCommand=function(s)
		s:sleep(1):queuecommand("Play")
	end,
	PlayCommand=function(s)
		SOUND:PlayAnnouncer("ScreenSelectPlayMode comment/Battle")
	end,
    LoadActor("../_shared/spl1")..{
  		OnCommand=cmd(diffusealpha,0);
  		OverCommand=cmd(diffusealpha,.5;zoomx,.5;y,-2;x,-56;linear,.1;zoom,1;diffusealpha,1;addx,56;sleep,0;diffusealpha,0);
  		GainFocusCommand=cmd(stoptweening;diffusealpha,0;sleep,0.117;diffusealpha,1;playcommand,"Over");
  		LoseFocusCommand=cmd(stoptweening;sleep,.1;diffusealpha,.5;addx,-56;linear,.05;addx,56;linear,.05;addx,-56;diffusealpha,0);
  	};
  	LoadActor("../_shared/spl2")..{
  		OnCommand=cmd(diffusealpha,0);
  		OverCommand=cmd(diffusealpha,.5;zoomx,.5;y,-2;x,56;linear,.1;zoom,1;diffusealpha,1;addx,-56;sleep,0;diffusealpha,0);
  		GainFocusCommand=cmd(stoptweening;diffusealpha,0;sleep,0.117;diffusealpha,1;playcommand,"Over");
  		LoseFocusCommand=cmd(stoptweening;sleep,.1;diffusealpha,.5;addx,56;linear,.05;addx,-56;linear,.05;addx,56;diffusealpha,0);
  	};
  	LoadActor("../_shared/splatbg")..{
  		OnCommand=cmd(diffusealpha,0);
  		OverCommand=cmd(diffusealpha,0;y,-2;sleep,.1;diffusealpha,1);
  		GainFocusCommand=cmd(stoptweening;diffusealpha,0;sleep,0.117;diffusealpha,1;playcommand,"Over");
  		LoseFocusCommand=cmd(stoptweening;diffusealpha,0);
  	};
  	LoadActor("../_shared/bgframe")..{
  		OnCommand=cmd();
  		GainFocusCommand=cmd(diffusealpha,0;sleep,0.117;diffusealpha,1);
  		LoseFocusCommand=cmd(diffusealpha,0);
  	};
  	LoadActor("Icon/back")..{
  		OnCommand=cmd(addy,-1);
  		GainFocusCommand=cmd(diffusealpha,0;sleep,0.117;diffusealpha,1);
  		LoseFocusCommand=cmd(diffusealpha,0);
  	};
  	LoadActor("../_shared/scan")..{
  		OnCommand=cmd(diffusealpha,0);
  		OverCommand=cmd(y,41;diffusealpha,0;linear,.5;addy,-42;diffusealpha,1;linear,.5;addy,-42;diffusealpha,0;sleep,0;addy,84;queuecommand,"Animate");
  		AnimateCommand=cmd(queuecommand,"Over");
  		GainFocusCommand=cmd(stoptweening;diffusealpha,0;sleep,0.117;diffusealpha,1;playcommand,"Over");
  		LoseFocusCommand=cmd(stoptweening;diffusealpha,0);
  	};
  	LoadActor("Icon/icon")..{
  		OnCommand=cmd(addy,0;addx,1);
  		GainFocusCommand=cmd(diffusealpha,0;sleep,0.117;diffusealpha,1);
  		LoseFocusCommand=cmd(diffusealpha,0);
  	};
  	LoadActor("Icon/label")..{
  		OnCommand=cmd(addy,69;addx,1;glowshift;effectperiod,0.266;);
  		GainFocusCommand=cmd(diffusealpha,0;sleep,0.117;diffusealpha,1);
  		LoseFocusCommand=cmd(diffusealpha,0);
  	};
  	--OffComand icon art
  	LoadActor("../_shared/tut")..{
  		InitCommand=cmd(addx,-262;addy,56);
  		GainFocusCommand=cmd(diffusealpha,1;queuecommand,"On");
  		LoseFocusCommand=cmd(diffusealpha,0);
  	};
  	LoadActor("../_shared/std")..{
  		InitCommand=cmd(addx,-193;addy,-4);
  		GainFocusCommand=cmd(diffusealpha,1;queuecommand,"On");
  		LoseFocusCommand=cmd(diffusealpha,0);
  	};
  	LoadActor("../_shared/non")..{
  		InitCommand=cmd(addx,176;addy,-9);
  		GainFocusCommand=cmd(diffusealpha,1;queuecommand,"On");
  		LoseFocusCommand=cmd(diffusealpha,0);
  	};
  	LoadActor("../_shared/end")..{
  		InitCommand=cmd(addx,263;addy,51);
  		GainFocusCommand=cmd(diffusealpha,1;queuecommand,"On");
  		LoseFocusCommand=cmd(diffusealpha,0);
  	};
  };
  Def.ActorFrame{
    InitCommand=cmd(xy,_screen.cx-6,_screen.cy+76);
    OffCommand=cmd(linear,.133;addx,-SCREEN_WIDTH);
    GainFocusCommand=cmd(sleep,.1;diffusealpha,1);
  	LoseFocusCommand=cmd(stoptweening;linear,0.05;addx,19;linear,0.05;addx,-19;diffusealpha,0);
    LoadActor("../_shared/nfofill");
  	LoadActor("../_shared/nfotop")..{
  		OnCommand=cmd(y,-50);
  	};
  	LoadActor("../_shared/nfobottom")..{
  		OnCommand=cmd(y,60);
  	};
  	LoadActor("../_shared/stgmax")..{
  		OnCommand=cmd(x,101;y,-63);
  	};
  	LoadActor("label")..{
  		OnCommand=cmd(x,-65;y,-41);
  	};
    Def.Sprite{
      BeginCommand=function(s)
        if GAMESTATE:GetNumPlayersEnabled() == 2 then
          s:xy(-31,12)
          s:Load(THEME:GetPathG("","ScreenSelectPlayMode Icon/Battle/desc_us"))
        else
          s:xy(-21,18)
          s:Load(THEME:GetPathG("","ScreenSelectPlayMode Icon/Battle/desc_cpu_us"))
        end;
      end;
    };
    LoadActor("badgeus")..{
  		OnCommand=cmd(x,170;y,72;diffuseshift;effectcolor1,color("1,1,1,1");effectcolor2,color("0.75,0.75,0.75,1");effectperiod,0.266);
  		Condition=GAMESTATE:GetNumPlayersEnabled()==1;
  		GainFocusCommand=cmd(zoomy,0;linear,.1;zoomy,1.5;sleep,.017;zoomy,1;sleep,.017;zoomx,1.5;sleep,.017;zoom,1);
  		LoseFocusCommand=cmd(linear,.25;zoomy,0);
  	};
  	LoadFont("maxstages")..{
  		InitCommand=cmd(horizalign,right;x,178;y,-65;playcommand,"Set");
  		SetCommand=function(self)
  		local max_stages = PREFSMAN:GetPreference("SongsPerPlay");
  			self:settext(max_stages);
  		end
  	};
  };
};
return Def.ActorFrame{
  Def.ActorFrame{
    InitCommand=cmd(xy,_screen.cx-94,_screen.cy-85);
    Def.ActorFrame{
      GainFocusCommand=function(s)
        s:sleep(1):queuecommand("Play")
      end,
      PlayCommand=function(s)
        SOUND:PlayAnnouncer("ScreenSelectPlayMode comment/Standard")
      end,
      OffCommand=cmd(linear,.133;zoomy,0);
      LoadActor("../_shared/spl1")..{
        OnCommand=cmd(diffusealpha,.5;zoomx,.5;y,-2;x,-56;linear,.1;zoom,1;diffusealpha,1;addx,56;sleep,0;diffusealpha,0);
        GainFocusCommand=cmd(stoptweening;diffusealpha,0;sleep,0.117;diffusealpha,1;playcommand,"On");
        LoseFocusCommand=cmd(stoptweening;sleep,.1;diffusealpha,.5;addx,-56;linear,.05;addx,56;linear,.05;addx,-56;diffusealpha,0);
      };
      LoadActor("../_shared/spl2")..{
        OnCommand=cmd(diffusealpha,.5;zoomx,.5;y,-2;x,56;linear,.1;zoom,1;diffusealpha,1;addx,-56;sleep,0;diffusealpha,0);
        GainFocusCommand=cmd(stoptweening;diffusealpha,0;sleep,0.117;diffusealpha,1;playcommand,"On");
        LoseFocusCommand=cmd(stoptweening;sleep,.1;diffusealpha,.5;addx,56;linear,.05;addx,-56;linear,.05;addx,56;diffusealpha,0);
      };
      Def.ActorFrame{
        OnCommand=cmd(zoomy,0;linear,0.1;zoomy,1);
        LoadActor("../_shared/splatbg")..{
          OnCommand=cmd(diffusealpha,0;y,-2;sleep,.1;diffusealpha,1);
          GainFocusCommand=cmd(stoptweening;diffusealpha,0;sleep,0.117;diffusealpha,1;playcommand,"On");
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
          OnCommand=cmd(y,41;diffusealpha,0;linear,.5;addy,-42;diffusealpha,1;linear,.5;addy,-42;diffusealpha,0;sleep,0;addy,84;queuecommand,"Animate");
          AnimateCommand=cmd(queuecommand,"On");
          GainFocusCommand=cmd(stoptweening;diffusealpha,0;sleep,0.117;diffusealpha,1;playcommand,"On");
          LoseFocusCommand=cmd(stoptweening;diffusealpha,0);
        };
        LoadActor("Icon/icon")..{
          OnCommand=cmd(addy,-12;addx,-3);
          GainFocusCommand=cmd(diffusealpha,0;sleep,0.117;diffusealpha,1);
          LoseFocusCommand=cmd(diffusealpha,0);
        };
      };
      LoadActor("Icon/label")..{
        InitCommand=cmd(xy,1,69;glowshift;effectperiod,0.266;);
        OnCommand=cmd(zoomy,0;zoomx,1.3;sleep,0.1;linear,0.1;zoomy,1;zoomx,1);
        GainFocusCommand=cmd(diffusealpha,0;sleep,0.117;diffusealpha,1);
        LoseFocusCommand=cmd(diffusealpha,0);
      };
    };
    --OffComand icon art
  	LoadActor("../_shared/tut.lua")..{
  		InitCommand=cmd(addx,-171;addy,36);
      OnCommand=cmd(zoomy,0;linear,0.1;zoomy,1);
  		GainFocusCommand=cmd(diffusealpha,1;queuecommand,"On");
  		LoseFocusCommand=cmd(diffusealpha,0);
  	};
  	LoadActor("../_shared/bat.lua")..{
  		InitCommand=cmd(addx,199;addy,34);
      OnCommand=cmd(zoomy,0;linear,0.1;zoomy,1);
  		GainFocusCommand=cmd(diffusealpha,1;queuecommand,"On");
  		LoseFocusCommand=cmd(diffusealpha,0);
  	};
  	LoadActor("../_shared/non.lua")..{
  		InitCommand=cmd(addx,267;addy,-29);
      OnCommand=cmd(zoomy,0;linear,0.1;zoomy,1);
  		GainFocusCommand=cmd(diffusealpha,1;queuecommand,"On");
  		LoseFocusCommand=cmd(diffusealpha,0);
  	};
  	LoadActor("../_shared/end.lua")..{
  		InitCommand=cmd(addx,354;addy,31);
      OnCommand=cmd(zoomy,0;linear,0.1;zoomy,1);
  		GainFocusCommand=cmd(diffusealpha,1;queuecommand,"On");
  		LoseFocusCommand=cmd(diffusealpha,0);
  	};
  };
  Def.ActorFrame{
    InitCommand=cmd(xy,_screen.cx-6,_screen.cy+76);
    OnCommand=cmd(zoomy,0;sleep,0.2;linear,0.05;zoomy,1);
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

  	LoadActor( "desc_us" )..{
  		OnCommand=cmd(x,-16;y,12);
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
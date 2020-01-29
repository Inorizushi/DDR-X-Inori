return Def.ActorFrame{
  Def.Sprite{
    InitCommand=function(s)
      s:align(0,0):xy(-367,-165);
      s:Load(THEME:GetPathG("","ScreenSelectStyle Icon/Versus/Art (doubleres).png"));
    end;
    OnCommand=cmd(diffusealpha,0);
    GainFocusCommand=cmd(rotationz,45;diffusealpha,0;diffusealpha,1;linear,0.15;rotationz,0);
    LoseFocusCommand=cmd(diffusealpha,0;);
  };
  Def.Sprite{
    InitCommand=cmd(xy,113,33);
    OnCommand=cmd(zoom,0;sleep,0.35;linear,0.05;zoom,1.1;linear,0.05;zoom,1);
    OffCommand=cmd(sleep,0.05;linear,0.05;zoomy,0;diffusealpha,0);
    GainFocusCommand=function(s)
      s:Load(THEME:GetPathG("","ScreenSelectStyle Icon/Versus/Color (doubleres).png"));
      s:diffuseshift():effectcolor1(color("1,1,1,1")):effectcolor2(color("0.75,0.75,0.75,1")):effectperiod(0.2)
    end;
    LoseFocusCommand=function(s)
      s:stoptweening()
      s:Load(THEME:GetPathG("","ScreenSelectStyle Icon/Versus/Gray (doubleres).png"));
      s:stopeffect()
    end;
  };
  Def.ActorFrame{
    InitCommand=cmd(xy,122,-96);
  	OffCommand=cmd(stoptweening;linear,0.1175;addx,SCREEN_WIDTH);
  	GainFocusCommand=cmd(stoptweening;sleep,.1;diffusealpha,1;sleep,1;queuecommand,"Play");
  	LoseFocusCommand=cmd(stoptweening;linear,0.05;x,134;linear,0.05;x,122;sleep,0;diffusealpha,0);
  	PlayCommand=function(self)
  		if self:GetVisible() then
  		SOUND:PlayAnnouncer( "ss comment/versus" )
  		end;
  	end;
    LoadActor( "../nfofill" )..{
  	};
  	LoadActor( "../nfotop" )..{
  	OnCommand=cmd(y,-50);
  	};
  	LoadActor( "../nfobottom" )..{
  	OnCommand=cmd(y,60);
  	};
  	LoadActor( "../stgmax" )..{
  	OnCommand=cmd(x,100;y,-63);
  	};
  	LoadActor( "label" )..{
  	OnCommand=cmd(x,-119;y,-41);
  	};
  	LoadActor( "desc_us" )..{
  	OnCommand=cmd(x,-21;y,5);
  	};
  	LoadFont("maxstages")..{
  		InitCommand=cmd(horizalign,right;x,177;y,-65;playcommand,"Set");
  		SetCommand=function(self)
  		local max_stages = PREFSMAN:GetPreference("SongsPerPlay");
  			self:settext(max_stages);
  		end
  	};
  };
};

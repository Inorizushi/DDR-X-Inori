local t = Def.ActorFrame{};

local xPosPlayerScore = {
    P1 = SCREEN_CENTER_X-228,
    P2 = SCREEN_CENTER_X+228
}

local xPosPlayerJudge = {
    P1 = SCREEN_CENTER_X-72,
    P2 = SCREEN_CENTER_X+72
}

for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do

local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)

local Combo = 	pss:MaxCombo();

local Marvelous = pss:GetTapNoteScores("TapNoteScore_W1");
local Perfect = pss:GetTapNoteScores("TapNoteScore_W2");
local Great = pss:GetTapNoteScores("TapNoteScore_W3");
local Good = pss:GetTapNoteScores("TapNoteScore_W4");
local Almost = pss:GetTapNoteScores("TapNoteScore_W5");
local Ok = pss:GetHoldNoteScores("HoldNoteScore_Held");
local NG = pss:GetHoldNoteScores("HoldNoteScore_LetGo");
local Miss = pss:GetTapNoteScores("TapNoteScore_Miss");

local Score = pss:GetScore();

t[#t+1] = Def.ActorFrame{
  InitCommand=function(self)
    local short = ToEnumShortString(pn)
      self:x(xPosPlayerScore[short])
    self:y(SCREEN_BOTTOM-105)
  end;
  OnCommand=function(self)
    if pn == PLAYER_1 then
      self:addx(-SCREEN_WIDTH/2):linear(0.4):addx(SCREEN_WIDTH/2)
    else
      self:addx(SCREEN_WIDTH/2):linear(0.4):addx(-SCREEN_WIDTH/2)
    end;
  end;
  OffCommand=function(self)
    if pn == PLAYER_1 then
      self:linear(0.4):addx(-SCREEN_WIDTH/2)
    else
      self:linear(0.4):addx(SCREEN_WIDTH/2)
    end;
  end;
  LoadActor("ScoreandDifficultyFrame")..{
    InitCommand=function(s) s:zoomx(pn==PLAYER_1 and 1 or -1) end,
  };
  Def.RollingNumbers{
    Font="ScoreDisplayNormal Text";
    OnCommand=function(self)
      self:strokecolor(Color.Black):y(7)
      self:Load("RollingNumbersEvaluation");
      self:targetnumber(Score);
    end;
  };
  Def.BitmapText{
    Font="_ag book stencil 20px";
    OnCommand=function(self)
      local diff = GAMESTATE:GetCurrentSteps(pn):GetDifficulty();
      self:uppercase(true):zoom(0.7):settext(THEME:GetString("CustomDifficulty",ToEnumShortString(diff)))
      :diffuse(CustomDifficultyToColor(diff)):xy(pn==PLAYER_2 and 20 or -20,-12)
    end;
  };
};

if pss:GetMachineHighScoreIndex() == 0 or pss:GetPersonalHighScoreIndex() == 0 then
  t[#t+1] = LoadActor("Newrecord.png")..{
    OnCommand=function(self)
      local short = ToEnumShortString(pn)
      self:x(xPosPlayerScore[short]):y(SCREEN_CENTER_Y+100)
      self:zoom(0):sleep(0.3):bounceend(0.2):zoom(1)
      self:glowblink():effectcolor1(color("1,1,1,0")):effectcolor2(color("1,1,1,0.2")):effectperiod(0.2)
    end;
    OffCommand=cmd(linear,0.2;zoom,0);
  };
end;

t[#t+1] = Def.ActorFrame{
  InitCommand=function(self)
		local short = ToEnumShortString(pn)
		self:x(xPosPlayerJudge[short]):y(SCREEN_CENTER_Y)
	end,
  OnCommand=cmd(zoomy,0;sleep,0.000;linear,0.2;zoomy,1);
	OffCommand=cmd(sleep,0.0000;sleep,0.016;linear,0.3;zoomy,0);
  Def.ActorFrame{
    Name="Marvelous Line";
    InitCommand=cmd(y,-52);
    Def.RollingNumbers{
      Font="ScreenEvaluation judge";
      OnCommand=function(self)
        self:Load("RollingNumbersJudge")
        self:targetnumber(Marvelous):halign(pn=='PlayerNumber_P2' and 0 or 1):strokecolor(Color.Black)
      end;
    };
  };
  Def.ActorFrame{
    Name="Perfect Line";
    InitCommand=cmd(y,-32);
    Def.RollingNumbers{
      Font="ScreenEvaluation judge";
      OnCommand=function(self)
        self:Load("RollingNumbersJudge")
        self:targetnumber(Perfect):halign(pn=='PlayerNumber_P2' and 0 or 1):strokecolor(Color.Black)
      end;
    };
  };
  Def.ActorFrame{
    Name="Great Line";
    InitCommand=cmd(y,-13);
    Def.RollingNumbers{
      Font="ScreenEvaluation judge";
      OnCommand=function(self)
        self:Load("RollingNumbersJudge")
        self:targetnumber(Great):halign(pn=='PlayerNumber_P2' and 0 or 1):strokecolor(Color.Black)
      end;
    };
  };
  Def.ActorFrame{
    Name="Good Line";
    InitCommand=cmd(y,6);
    Def.RollingNumbers{
      Font="ScreenEvaluation judge";
      OnCommand=function(self)
        self:Load("RollingNumbersJudge")
        self:targetnumber(Good):halign(pn=='PlayerNumber_P2' and 0 or 1):strokecolor(Color.Black)
      end;
    };
  };
  Def.ActorFrame{
    Name="Almost Line";
    InitCommand=cmd(y,25);
    Def.RollingNumbers{
      Font="ScreenEvaluation judge";
      OnCommand=function(self)
        self:Load("RollingNumbersJudge")
        self:targetnumber(Almost):halign(pn=='PlayerNumber_P2' and 0 or 1):strokecolor(Color.Black)
      end;
    };
  };
  Def.ActorFrame{
    Name="Miss Line";
    InitCommand=cmd(y,44);
    Def.RollingNumbers{
      Font="ScreenEvaluation judge";
      OnCommand=function(self)
        self:Load("RollingNumbersJudge")
        self:targetnumber(Miss):halign(pn=='PlayerNumber_P2' and 0 or 1):strokecolor(Color.Black)
      end;
    };
  };
  Def.ActorFrame{
    Name="Hold Line";
    InitCommand=cmd(y,63);
    Def.RollingNumbers{
      Font="ScreenEvaluation judge";
      OnCommand=function(self)
        self:Load("RollingNumbersJudge")
        self:targetnumber(Ok):halign(pn=='PlayerNumber_P2' and 0 or 1):strokecolor(Color.Black)
      end;
    };
  };
  Def.ActorFrame{
    Name="NG Line";
    InitCommand=cmd(y,82);
    Def.RollingNumbers{
      Font="ScreenEvaluation judge";
      OnCommand=function(self)
        self:Load("RollingNumbersJudge")
        self:targetnumber(NG):halign(pn=='PlayerNumber_P2' and 0 or 1):strokecolor(Color.Black)
      end;
    };
  };
  Def.ActorFrame{
    Name="Combo Line";
    InitCommand=cmd(y,101);
    Def.RollingNumbers{
      Font="ScreenEvaluation judge";
      OnCommand=function(self)
        self:Load("RollingNumbersJudge")
        self:targetnumber(Combo):halign(pn=='PlayerNumber_P2' and 0 or 1):strokecolor(Color.Black)
      end;
    };
  };
};
end;

return t;

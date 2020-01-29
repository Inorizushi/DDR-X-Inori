local t = Def.ActorFrame {};

local screen = Var("LoadingScreen")

if THEME:GetMetric(screen, "ShowHeader") then
	t[#t+1] = LoadActor(THEME:GetPathG(screen, "Header")) .. {
		Name = "Header",
	}
end

if THEME:GetMetric(screen, "ShowFooter") then
	t[#t+1] = LoadActor(THEME:GetPathG(screen, "Footer")) .. {
		Name = "Footer",
	}
end

t[#t+1] = LoadActor(THEME:GetPathS("","_siren"))..{
	OnCommand=function(self)
		if GAMESTATE:HasEarnedExtraStage() then
			self:play()
		end;
	end;
};

if GAMESTATE:HasEarnedExtraStage() == false then
t[#t+1] = LoadActor(THEME:GetPathS("","_ScreenEvaluation music (loop).ogg"))..{
	OnCommand=function(self)
		self:play()
	end;
}
end;


--Judge Area
t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+26;);
	OnCommand=cmd(zoomy,0;sleep,0.000;linear,0.2;zoomy,1);
	OffCommand=cmd(sleep,0.0000;sleep,0.016;linear,0.3;zoomy,0);
	LoadActor( "judgmentBG" );
	LoadActor( "JudgeRows" )..{
		InitCommand=cmd(y,-1);
	};
	LoadActor( "p1 (doubleres).png" )..{
		InitCommand=cmd(x,-234;y,-73;);
		OnCommand=cmd(zoomy,0;sleep,0.000;sleep,0.216;linear,0.1;zoomy,1);
		OffCommand=cmd(zoomy,1;sleep,0.0000;sleep,0.016;linear,0.1;zoomy,0);
		Condition=GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsHumanPlayer(PLAYER_1);
	};

	LoadActor( "p2 (doubleres).png" )..{
		InitCommand=cmd(x,234;y,-73);
		OnCommand=cmd(zoomy,0;sleep,0.000;sleep,0.216;linear,0.1;zoomy,1);
		OffCommand=cmd(zoomy,1;sleep,0.0000;sleep,0.016;linear,0.1;zoomy,0);
		Condition=GAMESTATE:IsPlayerEnabled(PLAYER_2) and GAMESTATE:IsHumanPlayer(PLAYER_2);
	};
};

t[#t+1] = Def.ActorFrame{
	LoadActor("stats.lua");
};

t[#t+1] = Def.ActorFrame{
	--Load Rave Decorations
	LoadActor( "RaveDec" )..{};

	--Load Course Decorations
	LoadActor( "CourseDec" )..{};
};

--Banner Area
t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(xy,_screen.cx,_screen.cy-133);
	LoadActor( "../_Banner/Side On.lua" )..{
		OnCommand=cmd(x,-158;y,23;);
		OffCommand=cmd(accelerate,0.233;addx,-20;sleep,0;diffusealpha,0);
	};
	LoadActor( "../_Banner/Side On.lua" )..{
		OnCommand=cmd(x,158;y,23;zoomx,-1);
		OffCommand=cmd(accelerate,0.233;addx,-20;sleep,0;diffusealpha,0);
	};
	Def.ActorFrame{
		OnCommand=cmd(zoomy,0;sleep,0.000;sleep,0.333;decelerate,0.133;zoomy,1;accelerate,0.033;zoomx,1.06;decelerate,0.033;zoomx,1);
		OffCommand=cmd(sleep,0.0000;sleep,0.333;decelerate,0.066;zoomx,1.05;zoomy,0);
		LoadActor( "../_Banner/BannerFrame.png" );
		Def.Sprite {
		 BeginCommand=function(self)
			 local songorcourse;
			 if GAMESTATE:IsCourseMode() then
				 songorcourse = GAMESTATE:GetCurrentCourse()
				 self:Load(songorcourse:GetBackgroundPath())
			 else
				 songorcourse = GAMESTATE:GetCurrentSong();
				 if songorcourse:HasBanner() then
					 self:Load(songorcourse:GetBannerPath())
				 else
					 self:Load(THEME:GetPathG("","Common fallback banner"));
				 end;
			 end;
		 end;
		 OnCommand=cmd(scaletoclipped,256,80);
		};
		LoadActor( "../_playmode" )..{
			InitCommand=cmd(x,-107;y,43;valign,0);
		};
		Def.Sprite{
			InitCommand=function(s) s:xy(16,54) end,
			BeginCommand=function(s)
				local stage = STATSMAN:GetCurStageStats():GetStage()
				s:Load(THEME:GetPathG("ScreenWithMenuElements","StageDisplay/"..stage))
			end,
		}
	};
};

for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
	t[#t+1] = LoadActor("grade", pn)
end


--Score sound
if GAMESTATE:GetPlayMode() ~= 'PlayMode_Rave' then
local ScoreP1 = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetScore();
local ScoreP2 = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetScore();

	if ScoreP1 > 0 or ScoreP2 > 0 then
		t[#t+1] = Def.ActorFrame {
			LoadActor("bgmscore")..{
				OnCommand=cmd(play);
			};
		}
	end
end

--Option icons
--[[for player in ivalues(GAMESTATE:GetHumanPlayers()) do

	t[#t+1] = LoadActor( "../OptionIcons", player )..{
		InitCommand=function(self)
			self:x(player == PLAYER_1 and SCREEN_LEFT+108 or SCREEN_RIGHT-84)
				:y(_screen.cy+165)
				:draworder(1)
		end
	}
end]]--

return t;

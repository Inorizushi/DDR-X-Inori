local st = GAMESTATE:GetCurrentStyle():GetStepsType();

local mStages = STATSMAN:GetStagesPlayed();
local i = 0;
local t = Def.ActorFrame {};
local screen = Var("LoadingScreen")

t[#t+1] = StandardDecorationFromFileOptional("Header","Header");

t[#t+1] = Def.ActorFrame{
	LoadActor("large page")..{
		InitCommand=cmd(CenterX;valign,0;y,_screen.cy-100);
		BeginCommand=function(self)
			self:setsize(SCREEN_WIDTH/1.02,240)
		end;
		OnCommand=cmd(zoomy,0;sleep,0.2;decelerate,0.4;zoomy,1);
		OffCommand=cmd(linear,0.2;zoomy,0);
	};
};

-- Center
for i = 1, mStages do
	local ssStats = STATSMAN:GetPlayedStageStats( i );
	t[#t+1] = Def.ActorFrame {
		InitCommand=cmd(Center);
		BeginCommand=function(self)
			if mStages == 2 then
				self:addy(-40 + ((mStages - i) * 70));
			elseif mStages == 3 then
				self:addy(-40 + ((mStages - i) * 70));
			elseif mStages == 4 then
				self:addy(-40 + ((mStages - i) * 70));
			elseif mStages == 5 then
				self:addy(-208 + ((mStages - i) * 112));
			elseif mStages == 6 then
				self:addy(-208 + ((mStages - i) * 112));
			elseif mStages == 7 then
				self:addy(-208 + ((mStages - i) * 112));
			else
				self:addy(((mStages - i) * 112));
			end;
		end;
		-- banner
		Def.ActorFrame{
			OnCommand=function(self)
				self:zoomy(0);
				self:sleep(0.25+(i-mStages)*-0.1);
				self:linear(0.2);
				self:zoomy(1);
			end;
			OffCommand=cmd(linear,0.25;zoomy,0);
			LoadActor("bannerFrame");
			Def.Sprite {
				BeginCommand=function(self)
					local sssong = ssStats:GetPlayedSongs()[1];
					self:LoadBackground(sssong:GetBannerPath());
					self:zoomto(102,32);
				end;
			};
		};
	};
end;

for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
	for i = 1, mStages do

	local sStats = STATSMAN:GetPlayedStageStats( i );
	local pStageStats = sStats:GetPlayerStageStats( pn );

	-- FullComboColor base from Default Extended by A.C
	local function GetFullComboEffectColor(pStageStats)
		local r;
			if pStageStats:FullComboOfScore('TapNoteScore_W1') then
				r=color("#fefed0");
			elseif pStageStats:FullComboOfScore('TapNoteScore_W2') then
				r=color("#f8fd6d");
			elseif pStageStats:FullComboOfScore('TapNoteScore_W3') then
				r=color("#01e603");
			elseif pStageStats:FullComboOfScore('TapNoteScore_W4') then
				r=color("#10e0f1");
			end;
		return r;
	end;

	t[#t+1] = Def.ActorFrame {
		InitCommand=cmd(player,pn;Center);
		BeginCommand=function(self)
			if mStages == 2 then
				self:addy(-40 + ((mStages - i) * 70));
			elseif mStages == 3 then
				self:addy(-40 + ((mStages - i) * 70));
			elseif mStages == 4 then
				self:addy(-40 + ((mStages - i) * 70));
			elseif mStages == 5 then
				self:addy(-208 + ((mStages - i) * 112));
			elseif mStages == 6 then
				self:addy(-208 + ((mStages - i) * 112));
			elseif mStages == 7 then
				self:addy(-208 + ((mStages - i) * 112));
			else
				self:addy(((mStages - i) * 112));
			end;
		end;
		OffCommand=function(self)
			if pn == PLAYER_1 then
				self:linear(0.4);
				self:addx(-SCREEN_WIDTH);
			else
				self:linear(0.4);
				self:addx(SCREEN_WIDTH);
			end

		end;

		-- Label
		LoadActor( "total" ) .. {
			OnCommand=function(self)
				if pn == PLAYER_1 then
					self:x(-SCREEN_WIDTH);
					self:sleep(0.05+(i-mStages)*-0.1);
					self:linear(0.4);
					self:x(-346);
					self:y(12)
					self:zoomy(1)
				else
					self:rotationy(180);
					self:x(SCREEN_WIDTH);
					self:sleep(0.05+(i-mStages)*-0.1);
					self:linear(0.4);
					self:x(346);
					self:y(12)
					self:zoomy(1)
				end
			end;
		};

		-- difficulty
		Def.Quad{
			InitCommand=cmd(setsize,10,56);
			BeginCommand=function(self)
				local sStats = STATSMAN:GetPlayedStageStats(i);
				local pss = sStats:GetPlayerStageStats(pn);
				local diff = pss:GetPlayedSteps()[1]:GetDifficulty();
				if sStats then
					self:diffuse(CustomDifficultyToColor(diff));
					self:visible(true);
				else
					self:visible(false);
				end
			end;
			OnCommand=function(self)
				if pn == PLAYER_1 then
					self:x(-SCREEN_WIDTH);
					self:sleep(0.05+(i-mStages)*-0.1);
					self:linear(0.4);
					self:x(-223);
					self:y(9);
					self:zoom(1)
				else
					self:rotationy(180);
					self:x(SCREEN_WIDTH);
					self:sleep(0.05+(i-mStages)*-0.1);
					self:linear(0.4);
					self:x(223);
					self:y(9);
					self:zoom(1)
				end
			end;
		};

		-- fullcombo
		LoadActor("FullCombo") .. {
			InitCommand=cmd();
			BeginCommand=function(self)
				self:x(pn=="PlayerNumber_P2" and 500 or -500)
				self:y(30);
				local grade = pStageStats:GetGrade();
				if grade ~= "Grade_Tier08" then
					if pStageStats:FullComboOfScore('TapNoteScore_W1') or pStageStats:FullComboOfScore('TapNoteScore_W2') or pStageStats:FullComboOfScore('TapNoteScore_W3') or pStageStats:FullComboOfScore('TapNoteScore_W4') then
						self:diffuse(GetFullComboEffectColor(pStageStats));
						self:visible(true);
					else
						self:visible(false);
					end
				else
					self:visible(false);
				end;
			end;
			OnCommand=function(self)
				self:zoom(0);
				self:sleep(0.45+(i-mStages)*-0.1);
				self:linear(0.4);
				self:zoom(0.3);
			end;
		};

		-- grade
		Def.Sprite {
			InitCommand=cmd(diffuseshift;effectcolor1,1,1,1,1;effectcolor2,1,1,1,0.8;effectperiod,0.2);
			BeginCommand=function(self)
				local Grade = pStageStats:GetGrade();
				self:Load(THEME:GetPathB("ScreenEvaluation Decorations/grade/GradeDisplayEval",ToEnumShortString(Grade)));
				if pn == PLAYER_1 then
					if pStageStats:FullComboOfScore('TapNoteScore_W1') or pStageStats:FullComboOfScore('TapNoteScore_W2') or pStageStats:FullComboOfScore('TapNoteScore_W3') or pStageStats:FullComboOfScore('TapNoteScore_W4') then
						self:addx(-300);
					else
						self:addx(-270);
					end;
				else
					if pStageStats:FullComboOfScore('TapNoteScore_W1') or pStageStats:FullComboOfScore('TapNoteScore_W2') or pStageStats:FullComboOfScore('TapNoteScore_W3') or pStageStats:FullComboOfScore('TapNoteScore_W4') then
						self:addx(300);
					else
						self:addx(270);
					end;
				end
				self:zoomx(0.4)
				self:y(10)
			end;
			OnCommand=function(self)
				self:zoomy(0);
				self:sleep(0.45+(i-mStages)*-0.1);
				self:linear(0.4);
				self:zoomy(0.4);
			end;
		};

		-- stage
		LoadFont("_helvetica Bold 24px")..{
			InitCommand=cmd(maxwidth,190;zoom,0.7);
			BeginCommand=function(self)
				local pStage = sStats:GetStage();
				local stageText = StageToLocalizedString(pStage).." STAGE"
				if pn == PLAYER_1 then
					self:halign(1)
				else
					self:halign(0)
				end
				self:settext(stageText);
			end;
			OnCommand=function(self)
				if pn == PLAYER_1 then
					self:x(-SCREEN_WIDTH);
					self:sleep(0.05+(i-mStages)*-0.1);
					self:linear(0.4);
					self:x(-300);
					self:y(-2);
				else
					self:x(SCREEN_WIDTH);
					self:sleep(0.05+(i-mStages)*-0.1);
					self:linear(0.4);
					self:x(300);
					self:y(-2);
				end
			end;
		};

		-- Score
		Def.RollingNumbers {
			File=THEME:GetPathF("","_helvetica Bold 24px");
			InitCommand=cmd(zoomx,1.1;zoomy,0.9;Load,"RollingNumbersSumm";diffusealpha,0;diffuse,color("#ffffff");strokecolor,color("#000000"));
			BeginCommand=function(self)
				local sStats = STATSMAN:GetPlayedStageStats(i);
				local pss = sStats:GetPlayerStageStats(pn)
				local song = sStats:GetPlayedSongs()[1];
				local diff = pss:GetPlayedSteps()[1]:GetDifficulty();
				local steps = song:GetOneSteps( st, diff );
				local radar = steps:GetRadarValues(pn);
				local maxsteps = math.max(radar:GetValue('RadarCategory_TapsAndHolds')+radar:GetValue('RadarCategory_Holds')+radar:GetValue('RadarCategory_Rolls'),1);
				self:targetnumber(GetEvaScore(maxsteps,pss,pn));
				if pn == PLAYER_1 then
					self:halign(1)
				else
					self:halign(0);
				end
				self:y(20);
			end;
			OnCommand=function(self)
				if pn == PLAYER_1 then
					self:x(-SCREEN_WIDTH);
					self:sleep(0.05+(i-mStages)*-0.1);
					self:linear(0.4);
					self:x(-304);
				else
					self:x(SCREEN_WIDTH);
					self:sleep(0.05+(i-mStages)*-0.1);
					self:linear(0.4);
					self:x(304);
				end
			end;
		};
	};
	end;
end;

for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(y,_screen.cy-124);
    Def.Sprite{
      Texture="Player 1x2";
      InitCommand=function(self)
				self:pause()
        self:setstate(pn=="PlayerNumber_P2" and 1 or 0)
				self:zoomy(0)
      end;
			OnCommand=function(self)
	      self:x(pn=="PlayerNumber_P2" and _screen.cx+326 or _screen.cx-326)
	      self:sleep(0.3):linear(0.2):zoomy(1)
	    end;
	    OffCommand=function(self)
	      self:linear(0.2):zoomy(0)
	    end;
    };
		Def.Sprite{
      InitCommand=function(self)
				self:y(-6)
        if pn == PLAYER_1 then
					self:Load(THEME:GetPathG("","_sharedX2/P1 BADGE"))
				else
					self:Load(THEME:GetPathG("","_sharedX2/P2 BADGE"))
				end;
      end;
			OnCommand=function(self)
	      self:x(pn=="PlayerNumber_P2" and _screen.cx+326 or _screen.cx-424)
				self:diffusealpha(0):rotationz(pn=="PlayerNumber_P2" and -90 or 90):sleep(0.3):linear(0.2):rotationz(0):diffusealpha(1)
	    end;
	    OffCommand=function(self)
	      self:linear(0.2):rotationz(pn=="PlayerNumber_P2" and -90 or 90):diffusealpha(0)
	    end;
		};
  };
end

return t

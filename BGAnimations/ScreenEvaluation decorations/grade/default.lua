local args = {...}
-- the only arg is arg 1, the player number
local function m(metric)
	metric = metric:gsub("PN", ToEnumShortString(args[1]))
	return THEME:GetMetric(Var "LoadingScreen",metric)
end

local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(args[1])

local tier = SN2Grading.ScoreToGrade(pss:GetScore(), pss:GetPlayedSteps()[1]:GetDifficulty())

local t = Def.ActorFrame {};

for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
t[#t+1] = Def.ActorFrame{
	Def.Sprite{
		InitCommand = function(s) s:draworder(98):player(pn):x(m "RingPNX"):y(m "RingPNY"):zoom(0) end,
		OnCommand=function(self)
		local staw = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetStageAward();
			if staw ~= nil then
				if((staw =="StageAward_SingleDigitW3") or (staw =="StageAward_OneW3") or (staw =="StageAward_FullComboW3") or string.find(staw,"W3")) then
					self:Load(THEME:GetPathB("","ScreenEvaluation decorations/grade/Fullcombo_ring.png"));
				elseif((staw =="StageAward_SingleDigitW2") or (staw =="StageAward_OneW2") or (staw =="StageAward_FullComboW2") ) then
					self:Load(THEME:GetPathB("","ScreenEvaluation decorations/grade/PerfectFullcombo_ring.png"));
				elseif (staw =="StageAward_FullComboW1") then
					self:Load(THEME:GetPathB("","ScreenEvaluation decorations/grade/MarvelousFullcombo_ring.png"));
				end;
				(cmd(linear,0.2;zoom,0.75;spin;effectmagnitude,0,0,170))(self);
			end;
		end;
		OffCommand=cmd(linear,0.2;zoom,0);
	};
	--Lines
	Def.Sprite{
		InitCommand = function(s) s:draworder(98):player(pn):x(m "RingPNX"):y(m "RingPNY"):zoom(0) end,
		OnCommand=function(self)
		local staw = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetStageAward();
			if staw ~= nil then
				if((staw =="StageAward_SingleDigitW3") or (staw =="StageAward_OneW3") or (staw =="StageAward_FullComboW3") or string.find(staw,"W3")) then
					self:Load(THEME:GetPathB("","ScreenEvaluation decorations/grade/Fullcombo_lines.png"));
				elseif((staw =="StageAward_SingleDigitW2") or (staw =="StageAward_OneW2") or (staw =="StageAward_FullComboW2") ) then
					self:Load(THEME:GetPathB("","ScreenEvaluation decorations/grade/PerfectFullcombo_lines.png"));
				elseif (staw =="StageAward_FullComboW1") then
					self:Load(THEME:GetPathB("","ScreenEvaluation decorations/grade/MarvelousFullcombo_lines.png"));
				end;
				(cmd(linear,0.2;zoom,0.75;spin;effectmagnitude,0,0,-170))(self);
			end;
		end;
		OffCommand=cmd(linear,0.2;zoom,0);
	};
} ;
end;

for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
t[#t+1] = Def.ActorFrame{
	InitCommand = function(s) s:x(m "GradePNX"):y(m "GradePNY"):playcommand("Set") end,
	OnCommand = m "GradePNOnCommand",
	OffCommand = m "GradePNOffCommand",
	Def.Sprite{
		SetCommand= function(s)
			local failed = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetFailed();
			if failed then
				s:Load(THEME:GetPathB("","ScreenEvaluation decorations/grade/GradeDisplayEval Failed"))
			else
				s:Load(THEME:GetPathB("ScreenEvaluation decorations/grade/GradeDisplayEval", ToEnumShortString(tier)))
			end;
		end;
	};
	Def.Sprite{
		InitCommand = function(s) s:y(40):draworder(100):player(pn):zoom(0):diffusealpha(0):rotationz(370):pause() end,
		OnCommand=function(self)
		local staw = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetStageAward();
			if staw ~= nil then
				if((staw =="StageAward_SingleDigitW3") or (staw =="StageAward_OneW3") or (staw =="StageAward_FullComboW3") or string.find(staw,"W3")) then
					self:Load(THEME:GetPathB("","ScreenEvaluation decorations/grade/FullCombo 1x2.png")):setstate(1)
				elseif((staw =="StageAward_SingleDigitW2") or (staw =="StageAward_OneW2") or (staw =="StageAward_FullComboW2") ) then
					self:Load(THEME:GetPathB("","ScreenEvaluation decorations/grade/PerfectFullCombo 1x2.png")):setstate(1)
				elseif (staw =="StageAward_FullComboW1") then
					self:Load(THEME:GetPathB("","ScreenEvaluation decorations/grade/MarvelousFullCombo 1x2.png")):setstate(1)
				end;
				(cmd(play;sleep,0.316;linear,0.266;diffusealpha,1;zoom,1;rotationz,-15))(self);
			end;
		end;
		OffCommand=cmd(stopeffect;zoomy,0.8;sleep,0.0000;sleep,0.016;linear,0.066;addy,20;diffusealpha,0.56;linear,0.083;diffusealpha,0);
	};
};
end;

return t;

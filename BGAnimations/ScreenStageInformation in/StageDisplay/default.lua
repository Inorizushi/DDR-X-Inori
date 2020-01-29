local sStage = GAMESTATE:GetCurrentStage();
local tRemap = {
	Stage_1st		= 1,
	Stage_2nd		= 2,
	Stage_3rd		= 3,
	Stage_4th		= 4,
	Stage_5th		= 5,
	Stage_6th		= 6,
};

if tRemap[sStage] == PREFSMAN:GetPreference("SongsPerPlay") then
	sStage = "Stage_Final";
else
	sStage = sStage;
end;
----------------------------------------------------------------------------
return Def.ActorFrame {
	Def.Sprite{
		OnCommand=function(self)
			if GAMESTATE:GetPlayMode() == 'PlayMode_Regular' or GAMESTATE:GetPlayMode() == 'PlayMode_Battle' or GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
				self:Load(THEME:GetPathB("", "ScreenStageInformation in/StageDisplay/ScreenStageInformation Stage " .. ToEnumShortString(sStage) ));
			elseif GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then
				self:Load(THEME:GetPathB("", "ScreenStageInformation in/StageDisplay/ScreenStageInformation Stage oni"));
			elseif GAMESTATE:GetPlayMode() == 'PlayMode_Nonstop' then
				self:Load(THEME:GetPathB("", "ScreenStageInformation in/StageDisplay/ScreenStageInformation Stage nonstop"));
			elseif (GAMESTATE:Env()).EndlessState then
				self:Load(THEME:GetPathB("", "ScreenStageInformation in/StageDisplay/ScreenStageInformation Stage endless"));
			end;
		end;
	};
};

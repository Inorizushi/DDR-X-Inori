function Branch.FirstScreen()
	return "ScreenWarning"
end

function Branch.AttractStart()
	local mode = GAMESTATE:GetCoinMode()
	if mode == "CoinMode_Home" then
		-- Only really matters if you hit Start from ScreenInit
		return "ScreenTitleMenu"
	elseif mode == "CoinMode_Free" then
		-- Start in Free Play mode goes directly into game
		return "ScreenTitleMenu"
	else
		-- Inserting a credit in Pay mode goes to logo screen
		return "ScreenTitleMenu"
	end
end

Branch.StartGame = function()
	-- XXX: we don't theme this screen
	if SONGMAN:GetNumSongs() == 0 and SONGMAN:GetNumAdditionalSongs() == 0 then
		return "ScreenHowToInstallSongs"
	end
	if PROFILEMAN:GetNumLocalProfiles() >=1 then
		return "ScreenSelectProfile"
	else
		return "ScreenCaution"
	end
end

function SelectMusicOrCourse()
	if IsNetSMOnline() then
		return "ScreenNetSelectMusic"
	elseif GAMESTATE:IsCourseMode() then
		return "ScreenSelectCourse"
	else
		return "ScreenSelectMusic"
	end
end

Branch.BackOutOfPlayerOptions = function()
	return SelectMusicOrCourse()
end;

function Branch.TitleMenu()
	local coinMode = GAMESTATE:GetCoinMode()
	if coinMode == 'CoinMode_Home' then
		return "ScreenTitleMenu"
	else
		return "ScreenTitleMenu"
	end
end;

function AfterSelectStyle()
	if IsNetConnected() then
		ReportStyle()
		GAMESTATE:ApplyGameCommand("playmode,regular")
	end
	if IsNetSMOnline() then
		return SMOnlineScreen()
	end
	if IsNetConnected() then
		return "ScreenNetRoom"
	end
	return "ScreenProfileLoad"

	--return CHARMAN:GetAllCharacters() ~= nil and "ScreenSelectCharacter" or "ScreenGameInformation"
end

function AfterCaution()
	if GAMESTATE:IsCourseMode() then
		return "ScreenSelectCourse"
	else
		return "ScreenSelectMusic"
	end
end

function AfterProfileLoad()
	return "ScreenCaution"
end

Branch.AfterGameplay = function()
	if GAMESTATE:IsCourseMode() then
		if GAMESTATE:GetPlayMode() == 'PlayMode_Nonstop' then
			return "ScreenEvaluationNonstop"
		else	-- oni and endless are shared
			return "ScreenEvaluationOni"
		end
	elseif GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
		return "ScreenEvaluationRave"
	else
		return "ScreenEvaluationNormal"
	end
end

Branch.AfterEvaluation = function()
	--normal
	if GAMESTATE:GetSmallestNumStagesLeftForAnyHumanPlayer() >= 1 then
		return "ScreenProfileSave"
	elseif GAMESTATE:GetCurrentStage() == "Stage_Extra1" then
		if STATSMAN:GetCurStageStats():AllFailed() then
			return "ScreenEvaluationSummary"
		else
			return "ScreenProfileSave"
		end;
	elseif STATSMAN:GetCurStageStats():AllFailed() then
		return "ScreenEvaluationSummary"
	elseif GAMESTATE:IsCourseMode() then
		return "ScreenProfileSaveSummary"
	else
		return "ScreenEvaluationSummary"
	end
end

Branch.AfterSummary = "ScreenProfileSaveSummary"

Branch.AfterSaveSummary = function()
	if PROFILEMAN:GetNumLocalProfiles() >= 1 then
		return "ScreenDataSaveSummary"
	else
		return "ScreenGameOver"
	end
end

Branch.AfterDataSaveSummary = function()
	if GAMESTATE:AnyPlayerHasRankingFeats() then
		return "ScreenDataSaveSummaryEnd"
	else
		return "ScreenDataSaveSummaryEnd"
	end
end

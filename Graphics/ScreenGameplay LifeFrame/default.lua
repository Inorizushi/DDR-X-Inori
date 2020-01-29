local xPosPlayer = {
    P1 = WideScale(-178,-246),
    P2 = WideScale(178,246)
}

local xPosPlayerRave = {
	P1 = -(640/6.7),
    P2 = (640/6.7)
};

local lifeframe = "frame";
local width = " 4_3";

local t = Def.ActorFrame{}
t[#t+1] = LoadActor("flicker")
for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
	t[#t+1] = Def.Sprite{
		Name = pn,
		InitCommand=function(self)
			local short = ToEnumShortString(pn)
			if GAMESTATE:GetPlayMode() == "PlayMode_Rave" then
				self:x(xPosPlayerRave[short])
			else
				self:x(xPosPlayer[short])
			end;
			if IsUsingWideScreen() then
				width = " 16_9"
			end
			if GAMESTATE:PlayerIsUsingModifier(pn,'battery') then
				if GAMESTATE:PlayerIsUsingModifier(pn,'8 lives') then
					lifeframe = "8frame";
				else
					lifeframe = "4frame";
				end
			else
				lifeframe = "frame";
			end
			self:Load(THEME:GetPathG("ScreenGameplay","LifeFrame/"..lifeframe..width))
		end,
		OnCommand=function(s) s:zoomx(pn=='PlayerNumber_P2' and -1 or 1) end,
	};
	t[#t+1] = Def.Sprite{
		Texture="Danger";
		InitCommand=function(s) s:rotationz(-6):visible(false):SetAllStateDelays(0.7)
			local short = ToEnumShortString(pn)
			s:xy(xPosPlayer[short],SCREEN_TOP);
		end,
		OnCommand=function(s)
			s:bob():effectmagnitude(0,3,0):effectperiod(0.67)
		end,
		HealthStateChangedMessageCommand=function(s,p)
			if p.PlayerNumber == pn then
				if p.HealthState=="HealthState_Danger" then
					s:visible(true)
					s:queuecommand("On")
				elseif p.HealthState=="HealthState_Dead" then
					s:visible(true)
					s:queuecommand("On")
					s:Load(THEME:GetPathG("ScreenGameplay","LifeFrame/GameOver"))
				else
					s:visible(false)
					s:stoptweening()
				end
			end
		end,
	}
end;

return t;

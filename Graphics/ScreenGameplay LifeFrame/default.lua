local xPosPlayer = {
    P1 = WideScale(-178,-246),
    P2 = WideScale(178,246)
}

local xPosPlayerRave = {
	P1 = -(640/6.7),
    P2 = (640/6.7)
};

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
			if 	IsUsingWideScreen() then
				self:Load(THEME:GetPathG("ScreenGameplay","LifeFrame/frame 16_9"))
			else
				self:Load(THEME:GetPathG("ScreenGameplay","LifeFrame/frame 4_3"))
			end
		end,
		OnCommand=function(s) s:zoomx(pn=='PlayerNumber_P2' and -1 or 1) end,
	};
end;

return t;

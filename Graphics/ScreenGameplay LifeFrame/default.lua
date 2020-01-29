local xPosPlayer = {
    P1 = -246,
    P2 = 246
}

local xPosPlayerRave = {
	P1 = -(640/6.7),
    P2 = (640/6.7)
};

local t = Def.ActorFrame{}
t[#t+1] = LoadActor("flicker")
for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
	t[#t+1] = LoadActor("frame 16_9")..{
		Name = pn,
		InitCommand=function(self)
			local short = ToEnumShortString(pn)
			if GAMESTATE:GetPlayMode() == "PlayMode_Rave" then
				self:x(xPosPlayerRave[short])
			else
				self:x(xPosPlayer[short])
			end;
		end,
		OnCommand=function(s) s:zoomx(pn=='PlayerNumber_P2' and -1 or 1) end,
	};
end;

return t;

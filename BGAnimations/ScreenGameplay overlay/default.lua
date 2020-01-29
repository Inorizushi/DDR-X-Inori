local t = Def.ActorFrame{};
-- Full combo
for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	t[#t+1] = LoadActor("FullCombo", pn) .. {
	};
	t[#t+1] = Def.Sprite{
		Texture="GO"..ToEnumShortString(pn);
		InitCommand=function(s) s:visible(false):zoom(0.65):xy(pn==PLAYER_1 and ScreenGameplay_P1X() or ScreenGameplay_P2X(),_screen.cy) end,
		BobCommand=function(s) s:bob():effectmagnitude(0,10,0):effectperiod(1) end,
		HealthStateChangedMessageCommand= function(self, param)
			if param.PlayerNumber == pn then
			if param.HealthState == 'HealthState_Dead' then
						self:visible(true):rotationz(360):linear(0.2):rotationz(0):queuecommand("Bob")
				end
			end
		end
	};
end;

return t;

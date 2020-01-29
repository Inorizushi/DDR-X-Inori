local t = ...;
t = Def.ActorFrame{
	LoadActor("../ScreenPlayerOptions LineHighlight P1/ScreenOptions line highlightPP1")..{
		InitCommand=function(s)
			s:cropleft(0.5)
		end,
	};
	LoadActor("../ScreenPlayerOptions LineHighlight P1/ScreenOptions line highlightPP1")..{
		InitCommand=function(s)
			if GAMESTATE:GetNumPlayersEnabled() == 2 then
				s:visible(false)
			end
		end,
		ChangeRowMessageCommand=function(s)
			if GAMESTATE:GetNumPlayersEnabled() == 2 then
				local screen = SCREENMAN:GetTopScreen{};
				if screen:GetCurrentRowIndex(PLAYER_1) == screen:GetCurrentRowIndex(PLAYER_2) then
					s:visible(false)
				else
					s:visible(true)
				end
			end
		end,
	};
	Def.Sprite {
	Texture="ScreenPlayerOptions LineHighlight P1 1x2";

	Frame0000=0;
	Delay0000=0.5;

	Frame0001=1;
	Delay0001=0.5;
	InitCommand=cmd(addx,200);
	};
};
return t;

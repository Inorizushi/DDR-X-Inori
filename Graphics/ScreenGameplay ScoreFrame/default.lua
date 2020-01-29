local xPosPlayer = {
    P1 = WideScale(SCREEN_LEFT-60,SCREEN_LEFT),
    P2 = WideScale(SCREEN_RIGHT+60,SCREEN_RIGHT)
}

local yval = SCREEN_BOTTOM-40;


local t = Def.ActorFrame{};
t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(y,yval);
	LoadActor("mid")..{
		InitCommand=cmd(CenterX;diffusealpha,0.75);
	};
	Def.BitmapText{
		Name="Title";
		Font="_russell square 12px";
		InitCommand=cmd(xy,_screen.cx-110,-8;zoomx,1.25;halign,0;maxwidth,250);
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local title = song:GetTranslitFullTitle()
			self:settext(title)
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	};
	Def.BitmapText{
		Name="Artist";
		Font="_russell square 10px";
		InitCommand=cmd(xy,_screen.cx-110,8;zoomx,1.25;halign,0;maxwidth,250);
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local artist = song:GetTranslitArtist()
			self:settext(artist)
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	};
};

--ScoreFrames
for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
	t[#t+1]=Def.ActorFrame{
		InitCommand=function(self)
			local short = ToEnumShortString(pn)
			self:x(xPosPlayer[short])
			self:halign(pn=="PlayerNumber_P2" and 1 or 0)
		end;
		LoadActor("Frame")..{
			InitCommand=cmd(zoomx,pn=="PlayerNumber_P2" and -1 or 1;halign,0;y,yval+2);
		};
		Def.ActorFrame{
			InitCommand=function(self)
				if GAMESTATE:PlayerIsUsingModifier(pn,'reverse') then
					self:y(SCREEN_TOP+40);
				else
					self:y(yval-17);
				end;
			end;
			LoadActor("DiffFrame")..{
				OnCommand=function(self)
					if GAMESTATE:PlayerIsUsingModifier(pn,'reverse') then
						self:zoomy(-1)
					else
						self:zoomy(1)
					end;
					self:halign(0)
	        self:zoomx(pn=="PlayerNumber_P2" and -1 or 1)
				end;
			};
			LoadFont("_helvetica Bold 14px")..{
	       Name="Difficulty Label";
				InitCommand=function(self)
					self:xy(pn=='PlayerNumber_P2' and -100 or 100,1)
					self:playcommand("Set")
					self:zoomx(1.1):zoomy(0.9)
				end;
				SetCommand=function(s)
	         local diff;
	         if GAMESTATE:IsCourseMode() then
	           diff = GAMESTATE:GetCurrentTrail(pn):GetDifficulty()
	         else
					  diff = GAMESTATE:GetCurrentSteps(pn):GetDifficulty();
	         end;
					s:settext(THEME:GetString("CustomDifficulty",ToEnumShortString(diff))):uppercase(true):diffuse(CustomDifficultyToColor(diff))
				end;
				CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
			};
		};
	};
end;

return t;

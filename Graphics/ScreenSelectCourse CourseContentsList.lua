local maxVisibleContents = 5 -- equivalent of MAX_VISIBLE_CONTENTS
local maxTotalContents = 56 -- equivalent of MAX_TOTAL_CONTENTS
local entryHeight = 46
local itemSecondsPause = 0.75
local GetOn = 0
return Def.ActorFrame{
	Def.Quad{
		Name="TopMask";
		InitCommand=cmd(valign,0;y,-(entryHeight*4);zoomto,288,entryHeight*2.5;MaskSource);
	};

	-- course contents list = rage
	Def.CourseContentsList{
		NumItemsToDraw=maxVisibleContents;
		MaxSongs=maxTotalContents;
		SecondsPerItem=itemSecondsPause;

		TransformFunction=function(self,offset,itemIndex,numItems)
			self:y(offset*entryHeight)
		end;

		BeginCommand=cmd(playcommand,"Set");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");
		SetCommand=function(self)
			self:SetFromGameState()
			self:SetCurrentAndDestinationItem(1)
			self:PositionItems()

			self:SetLoop(false)
			self:SetPauseCountdownSeconds(1)
			self:SetSecondsPauseBetweenItems(itemSecondsPause)
		end;

		Display=Def.ActorFrame{
			InitCommand=cmd(setsize,288,46);
			SetSongCommand=function(s,param)
				if GetOn == 0 then
					s:finishtweening():addx(-SCREEN_WIDTH/2.2):sleep(0.5):sleep(param.Number/5):decelerate(0.2):addx((SCREEN_WIDTH/2.2)+10):decelerate(0.05):addx(-10):sleep(0):queuecommand("SetOn")
				end
			end,
			SetOnCommand=function(s) GetOn = 1 end,
			LoadActor(THEME:GetPathG("CourseEntryDisplay","bar"));

			-- entry number
			LoadFont("_ag book stencil 24px")..{
				InitCommand=cmd(x,-120;zoomx,1.4;zoomy,1.2);
				SetSongCommand=function(self,param)
					self:settext(param.Number)
					self:diffuse(Color.Yellow)
				end;
			};
			LoadActor(THEME:GetPathG("CourseEntryDisplay","diff"))..{
				InitCommand=function(s) s:x(20) end,
				SetSongCommand=function(self,param)
					local difficulty = param.Difficulty
					local customDiff = GetCustomDifficulty(param.Steps:GetStepsType(),difficulty,nil)
					self:diffuse(CustomDifficultyToColor(customDiff))
				end;
			},
			-- textbanner
			Def.BitmapText{
				Font="_russell square 16px";
				InitCommand=cmd(halign,0;x,-89;y,-8;zoom,0.75;maxwidth,278);
				SetSongCommand=function(self,param)
					if not param.Song or param.Secret then
						-- set fake ("??????????" with no artist)
						self:settext("??????????")
						self:diffuse(color("#FFFFFF"))
					else
						-- set real
						self:settext(param.Song:GetDisplayMainTitle())
						self:diffuse(color("#FFFFFF"))
					end
				end;
			};
			Def.ActorFrame{
				InitCommand=function(s) s:xy(10,14) end,
				LoadActor(THEME:GetPathG("CourseEntryDisplay","meter"))..{
					SetSongCommand=function(self,param)
						local difficulty = param.Difficulty
						local customDiff = GetCustomDifficulty(param.Steps:GetStepsType(),difficulty,nil)
						self:diffuse(ColorDarkTone(CustomDifficultyToColor(customDiff)))
					end;
				};
				LoadActor(THEME:GetPathG("CourseEntryDisplay","meter"))..{
					SetSongCommand=function(self,param)
						local difficulty = param.Difficulty
						local customDiff = GetCustomDifficulty(param.Steps:GetStepsType(),difficulty,nil)
						local meter = param.Meter;
						self:diffuse(CustomDifficultyToColor(customDiff))
						if  meter ~= "?" then
							self:cropright(1-meter/10)
						else
							self:cropright(0)
						end
					end;
				};
				LoadFont("_ag book stencil 20px")..{
					Name="DifficultyMeter";
					InitCommand=cmd(x,112;zoomx,0.75;zoomy,0.5);
					SetSongCommand=function(self,param)
						if param.Meter ~= "?" then
							self:settext(string.format("%02d",param.Meter))
						else
							self:settext("??")
						end
						local difficulty = param.Difficulty
						local customDiff = GetCustomDifficulty(param.Steps:GetStepsType(),difficulty,nil)
						self:diffuse(CustomDifficultyToColor(customDiff))
					end;
				};
			};
		};
	};
};
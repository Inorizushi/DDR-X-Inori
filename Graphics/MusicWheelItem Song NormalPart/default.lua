local t = Def.ActorFrame{
  LoadActor("normal");
  Def.Sprite{
    Texture="NewSong 2x1";
    InitCommand=cmd(xy,-138,-25;draworder,1);
    SetCommand=function(self,param)
			if param.Song then
				if PROFILEMAN:IsSongNew(param.Song) then
					self:visible(true);
				else
					self:visible(false);
				end
			else
				self:visible(false);
			end
		end;
  };
  --TextBanner
  Def.ActorFrame{
    Def.BitmapText{
  		Font="_russell square 12px";
  		InitCommand=cmd(halign,0;x,-140;maxwidth,150/0.8;wrapwidthpixels,2^24;zoomx,1.25);
  		SetMessageCommand=function(self, param)
  			local Song = param.Song;
  			local Course = param.Course;
  			if Song then
  				self:y(-8)
  				self:settext(Song:GetDisplayFullTitle());
  				self:diffuse(SongAttributes.GetMenuColor(Song))
  			elseif Course then
  				self:settext(Course:GetDisplayFullTitle());
  			end
  		end;
  	};
  	--Artist
  	Def.BitmapText{
  		Font="_russell square 10px";
  		InitCommand=cmd(halign,0;xy,-140,8;zoomx,1.25;maxwidth,160/0.6;wrapwidthpixels,2^24);
  		CurrentSongChangedMessageCommand=function(s) s:queuecommand("Set") end,
  		CurrentCourseChangedMessageCommand=function(s) s:queuecommand("Set") end,
  		ChangedLanguageDisplayMessageCommand=function(s) s:queuecommand("Set") end,
  		SetMessageCommand=function(self, param)
  			local Song = param.Song;
  			local Course = param.Course;
  			if Song then
  				self:visible(true);
  				self:settext(Song:GetTranslitArtist());
  				self:diffuse(SongAttributes.GetMenuColor(Song))
  			end
  		end;
  	};
  }
};

for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
	table.insert(t, WheelLight(pn, true))
end

return t;

local t = Def.ActorFrame{
  LoadActor("../MusicWheelItem Song NormalPart/normal");
	Def.BitmapText{
  		Font="_ag book stencil 20px";
  		InitCommand=cmd(halign,0;x,-140;maxwidth,150/0.8;wrapwidthpixels,2^24;zoomx,1.25);
  		SetMessageCommand=function(self, param)
  			local Song = param.Song;
  			local Course = param.Course;
  			if Song then
  				self:y(-8)
  				self:settext(Song:GetTranslitFullTitle());
  				self:diffuse(SongAttributes.GetMenuColor(Song))
  			elseif Course then
  				self:settext(Course:GetDisplayFullTitle());
  			end
  		end;
	};
};

return t;

return Def.ActorFrame{
  LoadActor(THEME:GetPathG("","MusicWheelItem Song NormalPart/normal"));
  Def.BitmapText{
		Font="_ag book stencil 24px";
		InitCommand=cmd(y,-2;addx,-140;halign,0;zoomx,1.2);
		SetMessageCommand=function(self, params)
			self:settext(THEME:GetString("MusicWheel","Random"));
			self:diffuse(Color.Yellow):uppercase(true):strokecolor(Color.Black)
		end;
	};
}

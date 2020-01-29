local t = Def.ActorFrame {
	Def.Sprite{
		SetMessageCommand=function(self, param)
			self:Load(THEME:GetPathG("","MusicWheelItem SectionCollapsed NormalPart/Section Red"))
		end;
	};
	Def.BitmapText{
		Font="_ag book stencil 24px";
		InitCommand=cmd(y,-2;addx,-140;halign,0;zoomx,1.2;maxwidth,200);
		SetMessageCommand=function(self, params)
			local so = GAMESTATE:GetSortOrder();
			local label = params.Label
			self:strokecolor(Color.Black)
			self:settext(label)
		end;
	};
};




return t;

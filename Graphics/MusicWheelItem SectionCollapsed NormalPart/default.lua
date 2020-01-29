local t = Def.ActorFrame {
	Def.Sprite{
		SetMessageCommand=function(self, param)
			group = param.Text;
			local so = GAMESTATE:GetSortOrder();
			if group then
				if so == "SortOrder_Group" or so == "SortOrder_Title" then
					if group_name[group] then
						self:Load(THEME:GetPathG("","MusicWheelItem SectionCollapsed NormalPart/Section "..group_color[group]));
					else
						self:Load(THEME:GetPathG("","MusicWheelItem SectionCollapsed NormalPart/Section Red"))
					end;
				else
					self:Load(THEME:GetPathG("","MusicWheelItem SectionCollapsed NormalPart/Section Red"))
				end;
			end;
		end;
	};
	Def.BitmapText{
		Font="_ag book stencil 24px";
		InitCommand=cmd(y,-2;addx,-140;halign,0;zoomx,1.2;maxwidth,200);
		SetMessageCommand=function(self, params)
			local group = params.Text;
			local so = GAMESTATE:GetSortOrder();
			if so == 'SortOrder_Group' then
				if group_name[group] ~= nil then
					self:settext(group_rename[group])
					self:diffuse(color(color_group[group]))
				else
					self:settext(group);
					self:diffuse(color("#ff9f39"))
				end;
			else
				self:settext(group);
				self:diffuse(color("#ff9f39"))
			end;
			self:strokecolor(Color.Black)
		end;
	};
};




return t;

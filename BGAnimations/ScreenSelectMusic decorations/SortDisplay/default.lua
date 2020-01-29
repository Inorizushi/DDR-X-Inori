local t = Def.ActorFrame {
	Def.Sprite{
		SetGraphicCommand=function(self)
			local so = GAMESTATE:GetSortOrder();
			if so ~= nil then
				local sort = ToEnumShortString(so)
				self:Load(THEME:GetPathB("", "ScreenSelectMusic decorations/SortDisplay/_"..sort.."_sort"));
			end;
		end;
		SortOrderChangedMessageCommand=function(self)
			self:align(0,0)
			self:finishtweening()
			self:linear(0.2)
			self:rotationz(-90):diffusealpha(0)
			self:queuecommand("SetGraphic");
			self:linear(0.2)
			self:rotationz(0):diffusealpha(1)
		end;
	};
};

return t;

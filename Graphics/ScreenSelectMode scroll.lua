local gc = Var("GameCommand");

return Def.ActorFrame {
	Def.Actor{
		GainFocusCommand=function(self)
			MESSAGEMAN:Broadcast("TitleSelection", {Choice=gc:GetName()})
		end,
	};
};

local lang = "us";
local t = Def.ActorFrame {};

if THEME:GetCurLanguage() == "ja" then
	lang = "jp";
end;

t[#t+1] = LoadActor("caut"..lang)..{
	InitCommand=function(s)
		if lang == "jp" then
			s:setsize(640,480)
		else
			s:setsize(800,480)
		end
		s:Center()
	end;
	OnCommand=cmd(diffusealpha,0;decelerate,0.3;diffusealpha,1;sleep,2.4;accelerate,0.3;diffusealpha,0);
};

return t;
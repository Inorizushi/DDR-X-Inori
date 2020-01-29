local t = Def.ActorFrame {
	LoadActor(THEME:GetPathG("", "ScreenWithMenuElements header"));
  LoadActor(THEME:GetPathG("", "ScreenWithMenuElements footer"));
	--Dummy rows
};

for i=1,8 do
	local ri = (i==9) and 8 or i
	t[#t+1] = Def.ActorFrame{
		InitCommand=function(self)
			local xpos;
			if i == 8 then
				xpos = SCREEN_LEFT+100;
			else
				xpos = SCREEN_LEFT+188;
			end;
			self:x(xpos)
			self:y(_screen.cy-202)
		end;
		Def.Quad{
			InitCommand=function(self)
				self:y(ri*30):setsize(376,22)
				self:diffuse(color("0,0,0,0.8"))
			end;
		};
	};
end;

--[[	LoadActor("rowbg")..{
	OnCommand=cmd(x,SCREEN_LEFT+188;y,SCREEN_CENTER_Y-141);
	OffCommand=cmd();
	};

	LoadActor("rowbg")..{
	OnCommand=cmd(x,SCREEN_LEFT+188;y,SCREEN_CENTER_Y-111);
	OffCommand=cmd();
	};

	LoadActor("rowbg")..{
	OnCommand=cmd(x,SCREEN_LEFT+188;y,SCREEN_CENTER_Y-81);
	OffCommand=cmd();
	};

	LoadActor("rowbg")..{
	OnCommand=cmd(x,SCREEN_LEFT+188;y,SCREEN_CENTER_Y-51);
	OffCommand=cmd();
	};

	LoadActor("rowbg")..{
	OnCommand=cmd(x,SCREEN_LEFT+188;y,SCREEN_CENTER_Y-21);
	OffCommand=cmd();
	};

	LoadActor("rowbg")..{
	OnCommand=cmd(x,SCREEN_LEFT+188;y,SCREEN_CENTER_Y+9);
	OffCommand=cmd();
	};

	LoadActor("rowbg")..{
	OnCommand=cmd(x,SCREEN_LEFT+100;y,SCREEN_CENTER_Y+39);
	OffCommand=cmd();
};]]--

t[#t+1] = Def.ActorFrame{
	LoadActor( "../_Banner/Side On" )..{
		OnCommand=cmd(x,SCREEN_CENTER_X-302;y,SCREEN_BOTTOM-90;);
		OffCommand=cmd(accelerate,0.233;addx,20;sleep,0;diffusealpha,0);
	};

	LoadActor( "../_Banner/Side On" )..{
		OnCommand=cmd(x,SCREEN_CENTER_X+302;y,SCREEN_BOTTOM-90;zoomx,-1);
		OffCommand=cmd(accelerate,0.233;addx,-20;sleep,0;diffusealpha,0);
	};
	LoadActor("description")..{
	OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-110);
	OffCommand=cmd();
	};
};

return t;

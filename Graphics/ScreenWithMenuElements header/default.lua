local screen = Var "LoadingScreen"
local screenName = THEME:GetMetric(screen,"HeaderText");
local CenterHeader = THEME:GetMetric(screen,"CenterHeader")
local ShowCap = THEME:GetMetric(screen,"ShowCaption");
local headerTextImage

local out = Def.ActorFrame {
	LoadActor("header_shadow.png")..{
		InitCommand = cmd(xy,_screen.cx,_screen.cy-228),
		OnCommand = cmd(addy,-24;sleep,0.2;linear,0.133;addy,24),
		OffCommand=cmd(linear,0.133;addy,-24);
	};
	LoadActor("headbg") .. {
		InitCommand=function(self)
			if CenterHeader == true then
				self:x(_screen.cx)
				self:y(30)
			else
				self:x(_screen.cx-180)
				self:y(43)
			end;

		end;
		OnCommand=function(self)
			if CenterHeader == true then
				self:diffusealpha(0):rotationz(360):sleep(0.3):linear(0.2):rotationz(0):diffusealpha(1)
			else
				self:diffusealpha(0):rotationz(270):addx(-300):sleep(0.3):linear(0.2):rotationz(0):addx(300):diffusealpha(1)
			end;
		end;
		OffCommand=function(self)
			if CenterHeader == true then
				self:linear(0.2):rotationz(360):addy(-24):diffusealpha(0)
			else
				self:linear(0.2):rotationz(360):addx(-300):diffusealpha(0)
			end;
		end;
	};
};

if screenName then
	table.insert(out,LoadActor("text/"..screenName.." (doubleres).png")..{
		InitCommand=function(self)
			if CenterHeader == true then
				self:x(_screen.cx)
				self:y(_screen.cy-213)
			else
				self:x(_screen.cx-171)
				self:y(_screen.cy-208)
			end;
			self:rotationz(-4)
		end;
		OnCommand=cmd(diffusealpha,0;zoom,1.06;sleep,0.5;decelerate,0.083;diffusealpha,1;decelerate,0.083;zoom,1);
		OffCommand=cmd(linear,0.05;addx,-35;diffusealpha,0);
	})
end;

if ShowCap == true then
	table.insert(out,LoadActor("text/mode_"..getenv("sMode")..".png")..{
		InitCommand=function(self)
			if CenterHeader == true then
				self:x(_screen.cx)
				self:y(_screen.cy-213)
			else
				self:halign(0)
				self:x(_screen.cx-300)
				self:y(_screen.cy-218)
			end;
			self:rotationz(-4)
		end;
		OnCommand=cmd(diffusealpha,0;zoom,1.06;sleep,0.5;decelerate,0.083;diffusealpha,1;decelerate,0.083;zoom,1);
		OffCommand=cmd(linear,0.05;addx,-35;diffusealpha,0);
	})
end;

if PREFSMAN:GetPreference("MenuTimer") == true then
	table.insert(out,Def.ActorFrame{
		InitCommand=cmd(draworder,999;xy,WideScale(_screen.cx+266,_screen.cx+373),_screen.cy-213);
		OnCommand=cmd(zoom,0;sleep,0.2;linear,0.15;zoom,1);
		LoadActor("timerbg")..{
			OnCommand=cmd(zoom,0;decelerate,0.1;zoom,1);
			OffCommand=cmd(accelerate,0.1;zoom,0);
		};
		LoadActor("white_overlay")..{
			OnCommand=cmd(diffusealpha,0;sleep,0.4;diffusealpha,1;linear,0.166;diffusealpha,0;linear,0.066;diffusealpha,1;sleep,0.066;linear,0.333;diffusealpha,0);
			OffCommand=cmd(diffusealpha,1;linear,0.266;rotationz,180;diffusealpha,0);
		};
		LoadActor("orange_overlay")..{
			OnCommand=cmd(zoom,0;diffusealpha,0;rotationz,-360;sleep,0.1;linear,0.3;zoom,1;rotationz,0;diffusealpha,1);
			OffCommand=cmd(linear,0.266;rotationz,180;sleep,0;linear,0.3;rotationz,-180;zoom,0;diffusealpha,0);
		};
	})
end

return out

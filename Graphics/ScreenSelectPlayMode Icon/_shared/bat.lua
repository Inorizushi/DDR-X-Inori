local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
	OffCommand=cmd(linear,.133;addx,-SCREEN_WIDTH);
	Def.ActorFrame {
		OnCommand=cmd(x,-39;y,-2;zoom,0;linear,.084;zoom,1;pulse;effectmagnitude,.75,1,1;);
		LoadActor("sp (doubleres)")..{
			OnCommand=cmd(diffuse,color("#d8402e");spin;effectmagnitude,0,0,-300;);
		};
	};
	LoadActor("lblbat")..{
		OnCommand=function(s)
			s:zoomx(1.2):zoomy(.2):linear(.05):zoom(1.2):sleep(0):zoom(1):sleep(0.117):bob():effectperiod(1):effectmagnitude(0,2,0)
		end,
	}
};

return t;
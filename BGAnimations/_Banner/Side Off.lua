local t = Def.ActorFrame {};

	t[#t+1] = LoadActor("01")..{
		OnCommand=cmd(addy,-15;addx,-20;accelerate,0.233;addx,20;sleep,0;diffusealpha,0);
	};

	t[#t+1] = Def.ActorFrame {
		OnCommand=cmd(addy,-130);

		LoadActor("c1")..{
		OnCommand=cmd(y,_screen.cy-150;addx,-30;accelerate,0.233;addx,20;sleep,0;diffusealpha,0);
		};

		LoadActor("c1")..{
		OnCommand=cmd(y,_screen.cy-140;addx,-30;accelerate,0.233;addx,20;sleep,0;diffusealpha,0);
		};

		LoadActor("c1")..{
		OnCommand=cmd(y,_screen.cy-130;addx,-30;accelerate,0.233;addx,20;sleep,0;diffusealpha,0);
		};

		LoadActor("c1")..{
		OnCommand=cmd(y,_screen.cy-120;addx,-30;accelerate,0.233;addx,20;sleep,0;diffusealpha,0);
		};

		LoadActor("c1")..{
		OnCommand=cmd(y,_screen.cy-110;addx,-30;accelerate,0.233;addx,20;sleep,0;diffusealpha,0);
		};

		LoadActor("c1")..{
		OnCommand=cmd(y,_screen.cy-100;addx,-30;accelerate,0.233;addx,20;sleep,0;diffusealpha,0);
		};

	};

return t;

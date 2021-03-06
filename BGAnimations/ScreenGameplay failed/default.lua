return Def.ActorFrame {
LoadActor("failed.ogg")..{
	StartTransitioningCommand=cmd(play);
};
LoadActor( "../ScreenWithMenuElements background" )..{
	OnCommand=cmd(diffusealpha,0;sleep,3;diffusealpha,1);
};
LoadActor("cage")..{
	OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;addy,-480;sleep,0;accelerate,.316;addy,480;sleep,3;diffusealpha,0);
};
LoadActor(THEME:GetPathB("","_doors/Close.lua"))..{
    OnCommand=cmd(queuecommand,"GameOut");
};
LoadActor("../ScreenGameplay out/s01")..{
	OnCommand=cmd(x,SCREEN_CENTER_X+188;y,SCREEN_CENTER_Y-115;diffusealpha,0;sleep,0;sleep,.766;diffusealpha,1;sleep,4.3;linear,.05;diffusealpha,0);
};
LoadActor("../ScreenGameplay out/s02")..{
	OnCommand=cmd(x,SCREEN_CENTER_X-204;y,SCREEN_CENTER_Y+48;diffusealpha,0;sleep,0;sleep,.833;diffusealpha,1;sleep,4.233;linear,.05;diffusealpha,0);
};
LoadActor("../ScreenGameplay out/s01")..{
	OnCommand=cmd(x,SCREEN_CENTER_X-104;y,SCREEN_CENTER_Y+109;diffusealpha,0;sleep,0;sleep,.883;diffusealpha,1;sleep,4.183;linear,.05;diffusealpha,0);
};
LoadActor("../ScreenGameplay out/s03")..{
	OnCommand=cmd(x,SCREEN_CENTER_X+96;y,SCREEN_CENTER_Y+22;diffusealpha,0;sleep,0;sleep,.899;diffusealpha,1;sleep,4.167;linear,.05;diffusealpha,0);
};
LoadActor("../ScreenGameplay out/s04")..{
	OnCommand=cmd(x,SCREEN_CENTER_X+186;y,SCREEN_CENTER_Y+20;diffusealpha,0;sleep,0;sleep,.933;diffusealpha,1;sleep,4.133;linear,.05;diffusealpha,0);
};
LoadActor("../ScreenGameplay out/s05")..{
	OnCommand=cmd(x,SCREEN_CENTER_X+134;y,SCREEN_CENTER_Y-102;diffusealpha,0;sleep,0;sleep,.966;diffusealpha,1;sleep,4.1;linear,.05;diffusealpha,0);
};
LoadActor("failed.png")..{
	OnCommand=cmd(x,SCREEN_CENTER_X+7;y,SCREEN_CENTER_Y-59;vertalign,top;diffusealpha,0;rotationz,-35.5;sleep,0;sleep,.233;accelerate,.316;rotationz,0;diffusealpha,1;accelerate,.05;zoom,1.6;decelerate,.083;zoom,.95;decelerate,.016;zoom,1;sleep,4.402;linear,.166;addy,30;diffusealpha,0);
};
}
return Def.ActorFrame{
  InitCommand=cmd(CenterX;y,_screen.cy+185);
  Def.Actor{
    OnCommand=function(s) 
      SOUND:PlayAnnouncer("Title intro")
    end,
  };
  LoadActor("frame")..{
    InitCommand=function(s) s:animate(false):setstate(0) end,
    OnCommand=cmd(diffusealpha,0;rotationz,90;zoom,1.5;sleep,0.833;accelerate,0.15;rotationz,0;zoom,1;diffusealpha,1);
  };
  LoadActor("press_start1a")..{
    InitCommand=cmd(y,-2);
    OnCommand=cmd(diffusealpha,0;rotationz,90;zoom,1.5;sleep,0.833;accelerate,0.15;rotationz,0;zoom,1;diffusealpha,1);
  };
  LoadActor("press_start1b")..{
    InitCommand=cmd(y,-2);
    OnCommand=cmd(addy,999;sleep,1.316;addy,-999;diffuseshift;effectcolor1,1,1,1,0;effectcolor2,1,1,1,1;effectperiod,0.666);
  };
}

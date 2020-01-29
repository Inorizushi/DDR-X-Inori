return Def.ActorFrame{
  LoadActor("footer_shadow")..{
    InitCommand=cmd(xy,_screen.cx,SCREEN_BOTTOM;valign,1);
    OnCommand=cmd(addy,23;sleep,0.2;linear,0.133;addy,-23);
    OffCommand=cmd(linear,0.133;addy,33);
  };
};

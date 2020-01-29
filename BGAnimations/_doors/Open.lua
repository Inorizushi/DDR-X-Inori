return Def.ActorFrame{
  InitCommand=cmd(CenterY);
  LoadActor("doorlw")..{
    InitCommand=cmd(halign,1;x,_screen.cx);
    AnOnCommand=cmd(x,_screen.cx;linear,0.2;x,SCREEN_LEFT);
  };
  LoadActor("doorrw")..{
    InitCommand=cmd(halign,0;x,_screen.cx);
    AnOnCommand=cmd(x,_screen.cx;linear,0.2;x,SCREEN_RIGHT);
  };
};

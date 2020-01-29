return Def.ActorFrame{
  InitCommand=cmd(CenterY);
  LoadActor("doorlw")..{
    InitCommand=cmd(halign,1;x,SCREEN_LEFT);
    AnOnCommand=cmd(x,SCREEN_LEFT;linear,0.2;x,_screen.cx);
    GameOutCommand=cmd(x,SCREEN_LEFT;linear,0.8;x,_screen.cx;sleep,1.75;sleep,3.4;linear,0.2;x,SCREEN_LEFT;);
  };
  LoadActor("doorrw")..{
    InitCommand=cmd(halign,0;x,SCREEN_RIGHT);
    AnOnCommand=cmd(x,SCREEN_RIGHT;linear,0.2;x,_screen.cx);
    GameOutCommand=cmd(x,SCREEN_RIGHT;linear,0.8;x,_screen.cx;sleep,1.75;sleep,3.4;linear,0.2;x,SCREEN_RIGHT;);
  };
};

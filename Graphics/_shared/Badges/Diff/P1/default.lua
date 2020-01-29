return Def.ActorFrame{
  LoadActor("p1_light")..{
    OnCommand=cmd(zoomy,0;sleep,0.283;linear,0.116;zoomy,1;spin;effectmagnitude,0,0,50);
    OffCommand=cmd(zoomy,1;linear,0.116;zoomy,0);
  };
  LoadActor("p1_light")..{
    OnCommand=cmd(zoomy,0;sleep,0.283;linear,0.116;zoomy,1;blend,Blend.Add;diffusealpha,0.5;spin;effectmagnitude,0,0,-200);
    OffCommand=cmd(zoomy,1;linear,0.116;zoomy,0);
  };
  LoadActor("p1_cursor")..{
    OnCommand=cmd(zoomy,0;sleep,0.283;linear,0.116;zoomy,1);
    OffCommand=cmd(zoomy,1;linear,0.116;zoomy,0);
  };
}

return Def.ActorFrame {

LoadActor("intro")..{
OnCommand=cmd(FullScreen);
};

Def.Quad{
OnCommand=cmd(diffuse,Color.Black;FullScreen;diffusealpha,0;sleep,11.3;diffusealpha,1);
};

}

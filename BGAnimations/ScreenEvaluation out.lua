return Def.ActorFrame {

Def.Actor{
OnCommand=cmd(diffusealpha,0;sleep,1.435;);
};

Def.Quad{
OnCommand=cmd(diffuse,Color.Black;FullScreen;diffusealpha,0;sleep,1.433;linear,0.2;diffusealpha,1);
Condition= GAMESTATE:GetPlayMode() == 'PlayMode_Nonstop' or GAMESTATE:GetPlayMode() == 'PlayMode_Oni' or GAMESTATE:GetPlayMode() == 'PlayMode_Endless'
};

Def.Quad{
OnCommand=cmd(diffuse,Color.Black;FullScreen;diffusealpha,0;sleep,1.433;linear,0.2;diffusealpha,1);
Condition= GAMESTATE:GetPlayMode() == 'PlayMode_Rave' and GAMESTATE:GetCurrentStage() == 'Stage_Final'
};

}

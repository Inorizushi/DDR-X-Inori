local t = LoadFallbackB()

t[#t+1] = Def.Sprite{
    Texture="../../bases/style single",
    InitCommand=function(s) s:FullScreen():diffusealpha(0) end,
}

t[#t+1] = Def.ActorFrame{
    InitCommand=function(s) s:Center() end,
    Def.ActorFrame{
        Name="Player 1",
        InitCommand=function(s) s:xy(164,114):diffusealpha(1) end,
        Def.Sprite{
            Name="P1",
            Texture="PBacker 1x4",
            InitCommand=function(s) s:animate(false):setstate(1) end,
        },
        Def.Sprite{
            Name="PText",
            Texture="PText 1x8",
            InitCommand=function(s) s:animate(false):setstate(5):xy(-14,4) end,
        }
    }
}

t[#t+1] = LoadActor("footer");

return t;
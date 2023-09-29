local t = LoadFallbackB()

t[#t+1] = Def.Sprite{
    Texture="../../bases/style single",
    InitCommand=function(s) s:FullScreen():diffusealpha(1) end,
}

t[#t+1] = LoadActor("footer");

return t;
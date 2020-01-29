-- gameplay life frame
return Def.Sprite{
    InitCommand=function(s)
        if IsUsingWideScreen() then
            s:Load(THEME:GetPathG("ScreenGameplay","StageFrame/normal 16_9"))
        else
            s:Load(THEME:GetPathG("ScreenGameplay","StageFrame/normal 4_3"))
        end
    end,
};

return Def.ActorFrame {
    InitCommand=function(s)
        s:xy(_screen.cx+204,_screen.cy+233)
    end,
    OnCommand=function(s)
        s:addx(SCREEN_WIDTH/2.2):sleep(0.516):sleep(0.033):decelerate(0.233):addx(-SCREEN_WIDTH/2.2)
    end,
    OffCommand=cmd(linear,0.4;addx,SCREEN_WIDTH/2.2;linear,0;diffusealpha,0);
    LoadActor(THEME:GetPathB("","_command/command_bg"));
    LoadActor(THEME:GetPathB("","_command/select0"))..{
        InitCommand=function(s) s:xy(-65,-35) end,
        OnCommand=cmd(sleep,0.516000;sleep,0.033;sleep,0.283;linear,0.033;zoomx,1.086;linear,0.033;zoomx,1);
        OffCommand=cmd(sleep,0.4;linear,0;diffusealpha,0);
    };
    LoadActor(THEME:GetPathB("","_command/confirm0"))..{
        InitCommand=function(s) s:xy(67,-35) end,
        OnCommand=cmd(sleep,0.516000;sleep,0.033;sleep,0.283;linear,0.033;zoomx,1.086;linear,0.033;zoomx,1);
        OffCommand=cmd(sleep,0.4;linear,0;diffusealpha,0);
    };
}
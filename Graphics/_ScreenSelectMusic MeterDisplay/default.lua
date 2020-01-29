local args = ({...})[1]
local tickPos = args.PositionX
local diff = args.Difficulty

local trackPN = args.TrackPN
local FindSteps = function(song) return song:GetOneSteps(GAMESTATE:GetCurrentStyle():GetStepsType(), diff) end
if trackPN then
    FindSteps = function()
        local steps = GetCurrentStepsPossiblyCPU(trackPN)
        if steps and steps:GetDifficulty() == diff then
            return steps
        end
        return nil
    end
end

local diffColor
local hardXColor = DDRDiffList.HardXColor
local lightXColor = DDRDiffList.LightXColor
local darkXColor = DDRDiffList.DarkXColor

--[[TICKS UNDERLAY]]
local ticksUnder = Def.Sprite{
    Name="TicksUnder",
    Texture="grey",
    InitCommand = function(self) self:halign(0):zoom(1.05) end,
}
DDRDiffList.MessageHandlers(ticksUnder, function(self, _, XMode)
    self:x(tickPos-62)

    local diffColor = darkXColor
    local song = GAMESTATE:GetCurrentSong()
    if song then
        local steps = FindSteps(song)
        if steps then
            local meter = steps:GetMeter()
            if meter > 10 then
                --this only happens in X mode so no need to pick an alternative
                self:Load(THEME:GetPathG("","_ScreenSelectMusic MeterDisplay/yellow")):cropleft(math.min(1,(meter-10)/10))
            else
                self:Load(THEME:GetPathG("","_ScreenSelectMusic MeterDisplay/grey")):cropleft(math.min(1,meter/10))
            end
        else
            self:Load(THEME:GetPathG("","_ScreenSelectMusic MeterDisplay/grey")):cropleft(0)
        end
    else
        self:Load(THEME:GetPathG("","_ScreenSelectMusic MeterDisplay/grey")):cropleft(0)
    end
end)
--[[END TICKS UNDERLAY]]

--[[TICKS OVERLAY]]
local ticksOver = Def.Sprite{
    Name = "TicksOver",
    Texture = "yellow",
    InitCommand = function(self) self:halign(0):cropright(1):zoom(1.05) end,
}
DDRDiffList.MessageHandlers(ticksOver, function(self, songChanged, XMode)
    self:x(tickPos-62)
    local song = GAMESTATE:GetCurrentSong()
    if song then
        if songChanged then self:stopeffect() end
        local steps = FindSteps(song)
        if steps then
            local meter = steps:GetMeter()
            if meter > 10 then
                self:diffuse(hardXColor):cropright(math.max(0,1-(meter-10)/10))
            else
                self:stopeffect():diffuse(Color.White):cropright(1-meter/10)
            end
        else
            self:stopeffect():cropright(1)
        end
    else
        self:stopeffect():cropright(1)
    end
end)
--[[END TICKS OVERLAY]]

--[[METER NUMBER]]
local meter = Def.BitmapText{
    Font="_helvetica Bold 14px";
    InitCommand=function(self) self:x(tickPos-64):diffuse{1,1,1,1}:zoomy(0.9):halign(1) end
}
DDRDiffList.MessageHandlers(meter, function(self, _, XMode)
    self:visible(true)
    local song = GAMESTATE:GetCurrentSong()
    if song then
        local steps = FindSteps(song)
        if steps then
            local meter = steps:GetMeter()
            if DiffHelpers.AnyPlayerSelected(diff) then
                if meter > 10 then
                    self:diffuse(hardXColor)
                else
                    self:diffuse(Color.White)
                end
                self:settext(tostring(meter))
            else
                self:diffuse{1,1,1,1}
                self:settext(tostring(meter))
            end
        else
            self:settext ""
        end
    else
        self:settext ""
    end
end)

return Def.ActorFrame{ticksUnder,ticksOver,meter}

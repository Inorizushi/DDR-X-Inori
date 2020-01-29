local Icon = Def.ActorFrame{
  LoadActor("back")..{
     GainFocusCommand=cmd(glowshift;effectperiod,0.25;effectcolor1,color("#d07c0000");effectcolor2,color("#fe990188"));
     LoseFocusCommand=cmd(stopeffect);
  };
  LoadActor("text");
};

return Def.ActorFrame{
  GainFocusCommand=cmd(stoptweening;sleep,1;queuecommand,"Play");
  LoseFocusCommand=cmd(stoptweening);
	PlayCommand=function(self)
		if self:GetVisible() then
		SOUND:PlayAnnouncer( "Menu/records" )
		end;
	end;
  InitCommand=cmd(addy,62;rotationz,3.06);
  LoadActor("off.png")..{
    GainFocusCommand=cmd(visible,false);
    LoseFocusCommand=cmd(visible,true);
  };
  Icon..{
    GainFocusCommand=cmd(visible,true);
    LoseFocusCommand=cmd(visible,false);
  };
};

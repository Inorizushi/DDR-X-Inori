local function Radar()
	local function set(self,player)
		local Selection = GAMESTATE:GetCurrentSteps(player) or GAMESTATE:GetCurrentTrail(player)
		local Song = GAMESTATE:GetCurrentSong();
		if not Selection or not Song then
			self:SetEmpty( player );
			return
		end
		self:SetFromRadarValues( player, Selection:GetRadarValues(player) );
	end

	local t = Def.GrooveRadar {
		OnCommand=cmd(zoom,0;sleep,0.8;linear,0.2;zoom,1);
		OffCommand=cmd(linear,0.2;zoom,0);
		CurrentStepsP1ChangedMessageCommand=function(self) set(self, PLAYER_1); end;
		CurrentStepsP2ChangedMessageCommand=function(self) set(self, PLAYER_2); end;
		CurrentTrailP1ChangedMessageCommand=function(self) set(self, PLAYER_1); end;
		CurrentTrailP2ChangedMessageCommand=function(self) set(self, PLAYER_2); end;
	};

	return t;
end

local t = Def.ActorFrame {
	InitCommand=cmd(xy,WideScale(_screen.cx-162,_screen.cx-192),_screen.cy);
	LoadActor( "difficulty_bg" )..{
		InitCommand=cmd(y,135);
		OnCommand=cmd(zoomy,0;sleep,0.466;zoomy,0.136;linear,0.133;zoomy,1.036;linear,0.066;zoomy,0.88;linear,0.033;zoomy,1);
		OffCommand=cmd(sleep,0.266;accelerate,0.133;addx,-SCREEN_WIDTH/2);
	};
	Def.ActorFrame{
		InitCommand=cmd(xy,-2,19;);
		OffCommand=cmd(sleep,0.233;linear,0.05;diffusealpha,0);
		LoadActor("Radar/stream")..{
			InitCommand=cmd(y,-62);
			OnCommand=cmd(diffusealpha,0;rotationz,360;sleep,0.632;sleep,0.2;linear,0.166;rotationz,0;diffusealpha,1);

		};
		LoadActor("Radar/voltage")..{
			InitCommand=cmd(xy,-82,-24);
			OnCommand=cmd(diffusealpha,0;rotationz,360;sleep,0.632;sleep,0.1;linear,0.166;rotationz,0;diffusealpha,1);
		};
		LoadActor("Radar/air")..{
			InitCommand=cmd(xy,-58,44);
			OnCommand=cmd(diffusealpha,0;rotationz,360;sleep,0.632;linear,0.166;rotationz,0;diffusealpha,1);
		};
		LoadActor("Radar/freeze")..{
			InitCommand=cmd(xy,70,40);
			OnCommand=cmd(diffusealpha,0;rotationz,360;sleep,0.632;sleep,0.4;linear,0.166;rotationz,0;diffusealpha,1);
		};
		LoadActor("Radar/chaos")..{
			InitCommand=cmd(xy,80,-30);
			OnCommand=cmd(diffusealpha,0;rotationz,360;sleep,0.632;sleep,0.3;linear,0.166;rotationz,0;diffusealpha,1);
		};
		LoadActor("Radar/radar_bg")..{
			OnCommand=cmd(zoomy,0;sleep,0.466;accelerate,0.05;zoomy,1.30;linear,0.033;zoomy,1;accelerate,0.05;zoomx,1.30;linear,0.033;zoomx,1);
		},
		LoadActor("Radar/radar_glow")..{
			OnCommand=cmd(diffuseshift;effectcolor1,1,1,1,1;effectcolor2,1,1,1,0.4;effectperiod,1.33;addx,-SCREEN_WIDTH;sleep,1.283;addx,SCREEN_WIDTH);
		};
		Radar() .. {
			BeginCommand=cmd(x,-1;y,1);
		};
		LoadActor("DDRDifficultyList.lua");
	},


};

return t;

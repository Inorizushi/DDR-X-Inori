local t = Def.ActorFrame {
	LoadActor(THEME:GetPathS("","_swooshInstructions"))..{
		OnCommand=cmd(sleep,0.5;queuecommand,"Play");
		PlayCommand=cmd(play);
	};
};

local index = 0;
local row = "";
local name = "";
local choice = 0;

function setting(self,screen,pn)
	index = screen:GetCurrentRowIndex(pn);
	row = screen:GetOptionRow(index);
	name = row:GetName();
	choice = row:GetChoiceInRowWithFocus(pn);
	self:settext(THEME:GetString("OptionExplanations",name));
	if name ~= "Exit" then
		if THEME:GetMetric( "ScreenOptionsMaster",name.."Explanation" ) then
			self:settext(THEME:GetString("OptionItemExplanations",THEME:GetMetric( "ScreenOptionsMaster",name.."Explanation" )..""..choice));
		else self:settext("");
		end;
	end;
	return self;
end;

t[#t+1] = Def.ActorFrame{
	LoadActor(THEME:GetPathG("","ScreenWithMenuElements header/headbg"))..{
		InitCommand=cmd(x,_screen.cx-180;y,30);
		OnCommand=cmd(diffusealpha,0;sleep,0.5;diffusealpha,1);
		OffCommand=cmd(diffusealpha,0);
	};
	LoadActor(THEME:GetPathG("","ScreenWithMenuElements header/text/sel_opt"))..{
		InitCommand=cmd(x,_screen.cx-171;y,_screen.cy-208;rotationz,-4);
		OnCommand=cmd(diffusealpha,0;sleep,0.5;diffusealpha,1);
		OffCommand=cmd(diffusealpha,0);
	};
};

t[#t+1] = Def.Quad{
	InitCommand=function(self)
		self:diffuse(Color.Black):diffusealpha(0.5):xy(_screen.cx,_screen.cy)
		self:setsize(SCREEN_WIDTH/1.3,380);
	end;
	OnCommand=cmd(diffusealpha,0;sleep,0.5;linear,0.2;diffusealpha,0.75);
	OffCommand=cmd(linear,0.5;diffusealpha,0);
};

for i=1,13 do
	local ri = (i==14) and 13 or i
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(xy,_screen.cx,_screen.cy-180);
		OnCommand=cmd(addx,-SCREEN_WIDTH;sleep,0.5;accelerate,0.5;addx,SCREEN_WIDTH);
		OffCommand=cmd(sleep,0.2;accelerate,0.5;addx,SCREEN_WIDTH);
		Def.Quad{
			InitCommand=function(self)
				self:y(ri*20);
				self:setsize(SCREEN_WIDTH/1.3,20);
				if i%2 == 1 then
					self:diffuse(Color.Black)
				else
					self:diffuse(color("#191919"))
				end;
			end;
		};
	};
end;

t[#t+1] = Def.ActorFrame{
	--p1
	LoadActor( "Explanation" )..{
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_1);x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+140;halign,1);
		OnCommand=cmd(addx,-SCREEN_WIDTH;sleep,0.5;accelerate,0.5;addx,SCREEN_WIDTH);
		OffCommand=cmd(sleep,0.2;accelerate,0.5;addx,SCREEN_WIDTH);
	};
	--p2
	LoadActor( "Explanation" )..{
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_2);x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+140;halign,0;zoomx,-1);
		OnCommand=cmd(addx,-SCREEN_WIDTH;sleep,0.5;accelerate,0.5;addx,SCREEN_WIDTH);
		OffCommand=cmd(sleep,0.2;accelerate,0.5;addx,SCREEN_WIDTH);
	};
};

if GAMESTATE:IsHumanPlayer(PLAYER_1) then
  t[#t+1] = LoadFont("Common Normal")..{
    InitCommand=cmd(x,SCREEN_CENTER_X-280;y,SCREEN_CENTER_Y+120;zoom,0.5;wrapwidthpixels,494;horizalign,left;valign,0;strokecolor,Color("Black"));
    OnCommand=cmd(queuecommand,"SetP1";addx,-SCREEN_WIDTH;sleep,0.5;accelerate,0.5;addx,SCREEN_WIDTH);
		OffCommand=cmd(sleep,0.2;accelerate,0.5;addx,SCREEN_WIDTH);
    SetP1Command=function(self)
      local screen = SCREENMAN:GetTopScreen();
      if screen then
        setting(self,screen,PLAYER_1);
      end;
    end;
    MenuLeftP1MessageCommand=cmd(playcommand,"SetP1");
    MenuRightP1MessageCommand=cmd(playcommand,"SetP1");
    MenuUpP1MessageCommand=cmd(playcommand,"SetP1");
    MenuDownP1MessageCommand=cmd(playcommand,"SetP1");
  };
end;

if GAMESTATE:IsHumanPlayer(PLAYER_2) then
  t[#t+1] = LoadFont("Common Normal")..{
    InitCommand=cmd(x,SCREEN_CENTER_X+70;y,SCREEN_CENTER_Y+120;zoom,0.5;wrapwidthpixels,494;horizalign,left;valign,0;strokecolor,Color("Black"));
    OnCommand=cmd(queuecommand,"SetP2";addx,-SCREEN_WIDTH;sleep,0.5;accelerate,0.5;addx,SCREEN_WIDTH);
		OffCommand=cmd(sleep,0.2;accelerate,0.5;addx,SCREEN_WIDTH);
    SetP2Command=function(self)
      local screen = SCREENMAN:GetTopScreen();
      if screen then
        setting(self,screen,PLAYER_2);
      end;
    end;
    MenuLeftP2MessageCommand=cmd(playcommand,"SetP2");
    MenuRightP2MessageCommand=cmd(playcommand,"SetP2");
    MenuUpP2MessageCommand=cmd(playcommand,"SetP2");
    MenuDownP2MessageCommand=cmd(playcommand,"SetP2");
  };
end;

return t;

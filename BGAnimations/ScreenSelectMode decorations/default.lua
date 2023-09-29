local t = LoadFallbackB()

local t = Def.ActorFrame {
	Def.Actor{
		OnCommand=function(s) 
			SOUND:PlayAnnouncer("Mode intro")
		end,
	};
};

if GAMESTATE:GetCoinMode() == 'CoinMode_Home' then
	--Home decorations
	t[#t+1] = Def.ActorFrame {
		Def.Quad{
			InitCommand=cmd(FullScreen;diffuse,Color.Black);
			OnCommand=cmd(diffusealpha,0;decelerate,0.266;diffusealpha,0.8);
		};
		LoadActor("left_tab")..{
		OnCommand=cmd(x,SCREEN_LEFT+39;y,SCREEN_CENTER_Y;addx,-78;sleep,0.283;decelerate,0.066;addx,78);
		OffCommand=cmd(sleep,0.2;decelerate,0.066;addx,-78);
		};

		LoadActor("left_panel")..{
		OnCommand=cmd(x,SCREEN_LEFT+112;y,SCREEN_CENTER_Y-28;addx,-224;rotationz,-45;sleep,0.233;decelerate,0.166;addx,224;rotationz,0);
		OffCommand=cmd(sleep,0.2;decelerate,0.166;addx,-224);
		};

		LoadActor("dialog_frame")..{
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+170;diffusealpha,0;zoomx,0.1;sleep,0.333;linear,0.083;zoomx,1.1;diffusealpha,1;linear,0.016;zoomx,1);
		OffCommand=cmd(sleep,0.3;linear,0.083;zoomx,0);
		};
	};
elseif GAMESTATE:GetCoinMode() == 'CoinMode_Pay' then

	t[#t+1] = Def.ActorFrame {
		LoadActor("../_Arcade decorations")..{};
	};

end

if GAMESTATE:GetCoinMode() == 'CoinMode_Home' then
local heardBefore = false

t[#t+1] = Def.ActorFrame {
	Def.ActorFrame{
		InitCommand=cmd(xy,_screen.cx-142,_screen.cy-46);
		OnCommand=cmd(zoomy,0;sleep,0.3;decelerate,0.05;zoomy,1.05;decelerate,0.05;zoomy,1);
		OffCommand=cmd(sleep,0.2;decelerate,0.05;zoomy,0);
		LoadActor("01.png")..{
			InitCommand=cmd(x,-144;y,-2);
			OnCommand=cmd(x,-120;sleep,0.25;linear,0.05;x,-144);
			OffCommand=cmd(sleep,0.2;linear,0.05;x,-120);
			TitleSelectionMessageCommand=function(self, params)
				self:finishtweening()
				if heardBefore then
					self:linear(0.05)
				else heardBefore = true end
				self:x(-134)
				self:linear(0.05)
				self:x(-144)
			end;
		};
		LoadActor("02.png")..{
			InitCommand=cmd(x,144;y,-2);
			OnCommand=cmd(x,120;sleep,0.25;linear,0.05;x,144);
			OffCommand=cmd(sleep,0.2;linear,0.05;x,120);
			TitleSelectionMessageCommand=function(self, params)
				self:finishtweening()
				if heardBefore then
					self:linear(0.05)
				else heardBefore = true end
				self:x(134)
				self:linear(0.05)
				self:x(144)
			end;
		};
		Def.Sprite{
			Name="ImageLoader";
			TitleSelectionMessageCommand=function(self, params)
				choice = string.lower(params.Choice)
				self:finishtweening()
				if heardBefore then
					self:linear(0.05)
				else heardBefore = true end
				self:zoomy(1.05):queuecommand("TitleSelectionPart2")
			end;
			TitleSelectionPart2Command=function(self)
				self:Load(THEME:GetPathG("","_MenuArt/us/"..choice))
				self:linear(0.05)
				self:zoomy(1)
			end;
		};
	};
};

local titleText = {}
for _, filetext in
	pairs(FILEMAN:GetDirListing("/Themes/"..THEME:GetCurThemeName().."/Graphics/_MenuArt/us/text/", false, true))
do
	if ActorUtil.GetFileType(filetext) == 'FileType_Bitmap' then
		--this clustercuss extracts the part of the filename that is actually the filename
		--first it takes the last part of the file name and extracts the part that isn't the extension
		--then it trims whitespace, and finally removes tags (such as doubleres)
		local nametext = string.lower(string.match(filetext, "/([^/]-)%.%w+"):gsub("^%s*",""):gsub("%s*$", ""):gsub("% (.-%)", ""))
		if nametext then
			titleText[nametext] = filetext
			print(nametext)
		end
	end
end

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y+161);
	OnCommand=cmd(diffusealpha,0;zoomx,0.1;sleep,0.333;linear,0.083;zoomx,1.1;diffusealpha,1;linear,0.016;zoomx,1);
	OffCommand=cmd(sleep,0.3;linear,0.083;zoomx,0);
	Def.Sprite{
		Name="ImageLoader";
		TitleSelectionMessageCommand=function(self, params)
			choice = string.lower(params.Choice)
			self:finishtweening()
			if heardBefore then
				self:linear(0.05)
			else heardBefore = true end
			self:diffusealpha(0):queuecommand("TitleSelectionPart2")
		end;
		TitleSelectionPart2Command=function(self)
			self:Load(THEME:GetPathG("","_MenuArt/us/text/"..choice))
			self:linear(0.05)
			self:diffusealpha(1)
		end;
	};
}
end

return t;


local function CreditsText()
	local text = LoadFont("_sys1") .. {
		InitCommand=cmd(x,SCREEN_LEFT+10;y,SCREEN_BOTTOM-8;zoom,0.75;playcommand,"Refresh");
		RefreshCommand=function(self)
		--Normal pay
			local coins=GAMESTATE:GetCoins()
			local coinsPerCredit=PREFSMAN:GetPreference('CoinsPerCredit')
			local credits=math.floor(coins/coinsPerCredit)
			local remainder=math.mod(coins,coinsPerCredit)
			local s='CREDIT: '
			if credits > 1 then
				s='CREDITS: '..credits
			elseif credits == 1 then
				s=s..credits
			else
				s=s..0
			end
			self:horizalign(left)
			self:settext(s)
			if GAMESTATE:GetCoinMode() == 'CoinMode_Pay' then
				self:visible(true);
			else
				self:visible(false);
			end
		end;
		UpdateVisibleCommand=function(self)
			local screen = SCREENMAN:GetTopScreen();
			local bShow = true;
			if screen then
				local sClass = screen:GetName();
				bShow = THEME:GetMetric( sClass, "ShowCreditDisplay" );
			end;

			self:visible( bShow );
		end;
		CoinInsertedMessageCommand=cmd(stoptweening;playcommand,"Refresh");
		RefreshCreditTextMessageCommand=cmd(stoptweening;playcommand,"Refresh");
		PlayerJoinedMessageCommand=cmd(stoptweening;playcommand,"Refresh");
		ScreenChangedMessageCommand=cmd(stoptweening;playcommand,"Refresh");
	};
	return text;
end;

local function CoinsText()
	local text = LoadFont("_sys1") .. {
		InitCommand=cmd(x,SCREEN_RIGHT-20;y,SCREEN_BOTTOM-8;zoom,0.75;horizalign,right;playcommand,"Refresh");
		RefreshCommand=function(self)
			if GAMESTATE:IsEventMode() then self:settext('EVENT MODE') return end
			if GAMESTATE:GetCoinMode()=='CoinMode_Free' then self:settext('FREE PLAY') return end
			if GAMESTATE:GetCoinMode()=='CoinMode_Home' then self:settext('HOME MODE') return end
			local coins=GAMESTATE:GetCoins()
			local coinsPerCredit=PREFSMAN:GetPreference('CoinsPerCredit')
			local remainder=math.mod(coins,coinsPerCredit)
			local s='COIN(S): '
			if coinsPerCredit > 1 then
				s=s..remainder..' / '..coinsPerCredit
			else
				s=''
			end

			if GAMESTATE:GetCoinMode() == 'CoinMode_Pay' then
				self:visible(true);
			else
				self:visible(false);
			end

			self:settext(s)
		end;
		UpdateVisibleCommand=function(self)
			local screen = SCREENMAN:GetTopScreen();
			local bShow = true;
			if screen then
				local sClass = screen:GetName();
				bShow = THEME:GetMetric( sClass, "ShowCreditDisplay" );
			end;

			self:visible( bShow );
		end;
		CoinInsertedMessageCommand=cmd(stoptweening;playcommand,"Refresh");
		RefreshCreditTextMessageCommand=cmd(stoptweening;playcommand,"Refresh");
		PlayerJoinedMessageCommand=cmd(stoptweening;playcommand,"Refresh");
		ScreenChangedMessageCommand=cmd(stoptweening;playcommand,"Refresh");
	};
	return text;
end;

local function NetworkText()
	local text = LoadFont("_sys1") .. {
		InitCommand=function (self)
			self:name("NetworkStatus");
			self:settext("-----");
			self:x(SCREEN_CENTER_X);
			self:y(SCREEN_BOTTOM-8);
			self:zoom(0.75);
		end;
		RefreshCommand=function (self)
		local netConnected = IsNetConnected();
		local loggedOnSMO = IsNetSMOnline();
			if netConnected then
				self:diffuse(color("#00FFFF"));
				self:settext("ONLINE");
			else
				self:diffuse(color("#999999"));
				self:settext("LOCAL MODE");
			end;
		end;
		UpdateVisibleCommand=function(self)
			local screen = SCREENMAN:GetTopScreen();
			local bShow = true;
			if screen then
				local sClass = screen:GetName();
				bShow = THEME:GetMetric( sClass, "ShowCreditDisplay" );
			end

			self:visible( bShow );
		end;
		CoinInsertedMessageCommand=cmd(stoptweening;playcommand,"Refresh");
		RefreshCreditTextMessageCommand=cmd(stoptweening;playcommand,"Refresh");
		PlayerJoinedMessageCommand=cmd(stoptweening;playcommand,"Refresh");
		ScreenChangedMessageCommand=cmd(stoptweening;playcommand,"Refresh");
	};
	return text;
end;

local t = Def.ActorFrame{}

t[#t+1] = Def.ActorFrame {
 	--CreditsText( PLAYER_1 );
	--CreditsText( PLAYER_2 );
	NetworkText();
	CreditsText();
	CoinsText();
};

return t;

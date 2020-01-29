local DiffTab = {
	["Difficulty_Beginner"] = 1,
	["Difficulty_Easy"] = 2,
	["Difficulty_Medium"] = 3,
	["Difficulty_Hard"] = 4,
	["Difficulty_Challenge"] = 5,
	["Difficulty_Edit"] = 6,
}

local function LoadSongs(Style)

	local AllCompSongs = {}

	for _, CurSong in pairs(SONGMAN:GetAllSongs()) do
		local DiffCon = {}
		local CurSongCon = {CurSong}
		for i, CurStep in ipairs(CurSong:GetAllSteps()) do
			if string.find(CurStep:GetStepsType():lower(), Style) then
				DiffCon[tonumber(DiffTab[CurStep:GetDifficulty()])] = CurStep
			end
		end

		local Keys = {}
		for k in pairs(DiffCon) do table.insert(Keys, k) end
		table.sort(Keys)

		for _, k in pairs(Keys) do
			if DiffCon[k] then
				CurSongCon[#CurSongCon+1] = DiffCon[k]
			end
		end

		if CurSongCon[2] then
			AllCompSongs[#AllCompSongs+1] = CurSongCon
		end
	end

	return AllCompSongs
end

local SongPos = 1
if not CurSong then CurSong = 1 end
if not Joined then Joined = {} end
local CurRow = 1
local DiffPos = {1,1}
local UnlockedInput = true
local DiffSelection = false

local function ChangeSelection(self,offset,Songs)
	local OldRow = CurRow
	CurRow = CurRow + offset
	if CurRow > 2 then CurRow = 1 end
	if CurRow < 1 then CurRow = 2 end

	for i = 1,7 do
		local sleep = i
		local pos = CurSong+i
		local i2 = i

		if offset < 0 then
			sleep = (i - 7)*offset
			pos = pos - 8
			i2 = i2 - 8
		end


		if pos > #Songs then pos = (CurSong+i2)-#Songs end
		if pos < 1 then pos = #Songs+(CurSong+i2) end

		self:GetChild(CurRow..i):GetChild("BannerCon"):GetChild("Banner"):Load(Songs[pos][1]:GetBannerPath())
		self:GetChild(CurRow..i):GetChild("BannerCon"):GetChild("Banner"):zoom(DDR.Resize(self:GetChild(CurRow..i):GetChild("BannerCon"):GetChild("Banner"):GetWidth(),self:GetChild(CurRow..i):GetChild("BannerCon"):GetChild("Banner"):GetHeight(),128,40))
		if Songs[pos][1]:HasBanner() then
			self:GetChild(CurRow..i):GetChild("BannerCon"):GetChild("FallbackBanner"):diffusealpha(0):zoom(0)
			self:GetChild(CurRow..i):GetChild("BannerCon"):GetChild("BannerText"):diffusealpha(0):zoom(0)
		else
			self:GetChild(CurRow..i):GetChild("BannerCon"):GetChild("FallbackBanner"):diffusealpha(1):zoomto(128,40)
			self:GetChild(CurRow..i):GetChild("BannerCon"):GetChild("BannerText"):diffusealpha(1):zoom(.5)
			self:GetChild(CurRow..i):GetChild("BannerCon"):GetChild("BannerText"):settext(Songs[pos][1]:GetDisplayMainTitle())
		end
		self:GetChild(CurRow..i):GetChild("BannerCon"):sleep(sleep/8):linear(.5):x(0)
		self:GetChild(OldRow..i):GetChild("BannerCon"):sleep((sleep/8)+.4):x(1280)
	end

	self:sleep((7/8)+.5):queuecommand("UnlockInput")
end

local function MoveSelection(self,offset,Songs)
	UnlockedInput = false
	for i = 1,7 do
		self:GetChild(CurRow..i):GetChild("BannerCon"):linear(0.1):x(0):stopeffect()
	end

	SongPos = SongPos + offset
	if SongPos < -2 then SongPos = 4 ChangeSelection(self,-1,Songs) end
	if SongPos > 4 then SongPos = -2 ChangeSelection(self,1,Songs) end
	CurSong = CurSong + offset
	if CurSong > #Songs then CurSong = 1 end
	if CurSong < 1 then CurSong = #Songs end

	self:GetChild(CurRow..SongPos+3):GetChild("BannerCon"):linear(.1):x(32):effectclock("Beat"):glowshift()
	self:GetChild("Title"):settext(Songs[CurSong][1]:GetDisplayMainTitle())
	SOUND:StopMusic()
	SOUND:PlayMusicPart(Songs[CurSong][1]:GetMusicPath(),Songs[CurSong][1]:GetSampleStart(),Songs[CurSong][1]:GetSampleLength(),0,0,true)
	self:sleep(.2):queuecommand("UnlockInput")
end

local function StartSelection(self,Songs)
	UnlockedInput = false
	local DiffColors={color("#88ffff"), color("#ffff88"), color("#ff8888"), color("#88ff88"), color("#8888ff"), color("#888888")}
	local DiffNames={"Practice", "Basic", "Trick", "Maniac", "Extra", "Edit"}
	local offset = 0
	for i = SongPos+3,7 do
		self:GetChild(CurRow..i):GetChild("BannerCon"):sleep(offset/8):linear(.5):x(-1280)
		offset = offset + 1
	end
	offset = SongPos+3
	for i = 1,SongPos+3 do
		self:GetChild(CurRow..i):GetChild("BannerCon"):sleep(offset/8):linear(.5):x(-1280)
		offset = offset - 1
	end
	for i = 1,#Songs[CurSong]-1 do
		if i > 5 then break end
		for i2 = 1,9 do
			self:GetChild("Feet"..i..i2):sleep(.5):linear(.5):diffuse(DiffColors[DiffTab[Songs[CurSong][i+1]:GetDifficulty()]]):diffusealpha(.5)
		end
		for i2 = 1,Songs[CurSong][i+1]:GetMeter() do
			if i2 > 9 then break end
			self:GetChild("Feet"..i..i2):diffusealpha(1)
		end
		if Joined[PLAYER_1] then
			self:GetChild("DiffSelector"..i.."1"):GetChild("DiffCon"):sleep(.5):linear(.5):diffuse(DiffColors[DiffTab[Songs[CurSong][i+1]:GetDifficulty()]])
			self:GetChild("DiffSelector"..i.."1"):GetChild("DiffName"):sleep(.5):linear(.5):diffuse(DiffColors[DiffTab[Songs[CurSong][i+1]:GetDifficulty()]]):settext(DiffNames[DiffTab[Songs[CurSong][i+1]:GetDifficulty()]])
		end
		if Joined[PLAYER_2] then
			self:GetChild("DiffSelector"..i.."2"):GetChild("DiffCon"):sleep(.5):linear(.5):diffuse(DiffColors[DiffTab[Songs[CurSong][i+1]:GetDifficulty()]])
			self:GetChild("DiffSelector"..i.."2"):GetChild("DiffName"):sleep(.5):linear(.5):diffuse(DiffColors[DiffTab[Songs[CurSong][i+1]:GetDifficulty()]]):settext(DiffNames[DiffTab[Songs[CurSong][i+1]:GetDifficulty()]])
		end
	end
	self:sleep(1):queuecommand("DiffSelection")
end

local function MoveDifficulty(self,offset,Songs)
	local pn = 1
	if self.pn == PLAYER_2 then pn = 2 end
	if Joined[self.pn] then
		for i = 1,6 do
			self:GetChild("DiffSelector"..i..pn):stopeffect()
		end
		DiffPos[pn] = DiffPos[pn] + offset
		if DiffPos[pn] > #Songs[CurSong]-1 then DiffPos[pn] = 1 end
		if DiffPos[pn] < 1 then DiffPos[pn] = #Songs[CurSong]-1 end
		self:GetChild("DiffSelector"..DiffPos[pn]..pn):effectclock("Beat"):glowshift()
	end
end

local function MusicWheel()

	local Songs = LoadSongs("dance_single")
	local StartOptions = false

	local t = Def.ActorFrame{
		OnCommand=function(self)
			SCREENMAN:GetTopScreen():AddInputCallback(DDR.Input(self))
			self:sleep(0.2):queuecommand("PlayCurrentSong")
		end,
		PlayCurrentSongCommand=function(self)
			SOUND:PlayMusicPart(Songs[CurSong][1]:GetMusicPath(),Songs[CurSong][1]:GetSampleStart(),Songs[CurSong][1]:GetSampleLength(),0,0,true)
		end,
		MenuLeftCommand=function(self) if UnlockedInput then MoveSelection(self,-1,Songs) end if DiffSelection then MoveDifficulty(self,-1,Songs) end end,
		MenuRightCommand=function(self) if UnlockedInput then MoveSelection(self,1,Songs) end if DiffSelection then MoveDifficulty(self,1,Songs) end end,
		BackCommand=function(self)
			if DiffSelection then
				GAMESTATE:UnjoinPlayer(PLAYER_1)
				GAMESTATE:UnjoinPlayer(PLAYER_2)
				Joined[PLAYER_1] = false
				Joined[PLAYER_2] = false
				SCREENMAN:GetTopScreen():SetNextScreenName(SCREENMAN:GetTopScreen():GetPrevScreenName()):StartTransitioningScreen("SM_GoToNextScreen")
			else
				if Joined[self.pn] then
					if Joined[PLAYER_1] and Joined[PLAYER_2] then
						GAMESTATE:UnjoinPlayer(self.pn)
						Joined[self.pn] = false
					else
						GAMESTATE:UnjoinPlayer(self.pn)
						Joined[self.pn] = false
						SCREENMAN:GetTopScreen():SetNextScreenName(SCREENMAN:GetTopScreen():GetPrevScreenName()):StartTransitioningScreen("SM_GoToNextScreen")
					end
				end
			end

		end,
		StartCommand=function(self)
			if DiffSelection then
				if StartOptions then
					SCREENMAN:GetTopScreen():SetNextScreenName("ScreenPlayerOptions"):StartTransitioningScreen("SM_GoToNextScreen")
				end
				if Joined[PLAYER_1] and Joined[PLAYER_2] then
					GAMESTATE:SetCurrentStyle('versus')
					GAMESTATE:SetCurrentSteps(PLAYER_1,Songs[CurSong][DiffPos[1]+1])
					GAMESTATE:SetCurrentSteps(PLAYER_2,Songs[CurSong][DiffPos[2]+1])
				else
					GAMESTATE:SetCurrentStyle('single')
					if Joined[PLAYER_1] then
						GAMESTATE:SetCurrentSteps(self.pn,Songs[CurSong][DiffPos[1]+1])
					else
						GAMESTATE:SetCurrentSteps(self.pn,Songs[CurSong][DiffPos[2]+1])
					end
				end
				StartOptions = true
				self:sleep(0.5):queuecommand("StartSong")
			else
				if UnlockedInput then
					if Joined[self.pn] then
						PROFILEMAN:SaveProfile(self.pn)
						GAMESTATE:SetCurrentPlayMode("PlayMode_Regular")
						GAMESTATE:SetCurrentSong(Songs[CurSong][1])
						StartSelection(self,Songs)
					else
						GAMESTATE:JoinPlayer(self.pn)
						GAMESTATE:LoadProfiles()
						Joined[self.pn] = true
					end
				end
			end
		end,
		StartSongCommand=function(self)
			SCREENMAN:GetTopScreen():SetNextScreenName("ScreenGameplay"):StartTransitioningScreen("SM_GoToNextScreen")
		end,
		UnlockInputCommand=function() UnlockedInput = true end,
		DiffSelectionCommand=function(self)
			DiffSelection = true
			if Joined[PLAYER_1] then self:GetChild("DiffSelector11"):effectclock("Beat"):glowshift() end
			if Joined[PLAYER_2] then self:GetChild("DiffSelector12"):effectclock("Beat"):glowshift() end
		end,
		Def.BitmapText {
			Font="Common Normal",
			Name="Title",
			Text=Songs[CurSong][1]:GetDisplayMainTitle(),
			OnCommand=function(self)
				self:Center()
			end
		}
	}

	local nOffset = 0

	for i = -3,3 do
		nOffset = nOffset + 1
		local pos = CurSong+i
		if pos > #Songs then pos = (CurSong+i)-#Songs end
		if pos < 1 then pos = #Songs+(CurSong+i) end
		for i2 = 1,2 do
			t[#t+1] = Def.ActorFrame{
				Name=i2..nOffset,
				InitCommand=function(self) self:rotationz(-45):xy(SCREEN_CENTER_X+(64*i),SCREEN_CENTER_Y+96) end,
				Def.ActorFrame{
					Name="BannerCon",
					OnCommand=function(self)
						local offset = i-1
						if i < 1 then offset = offset*-1 end
						self:x(1280)
						if i2 == 1 then
							self:sleep(offset/8):linear(.5):x(0)

							if i == 0 then
								self:effectclock("Beat"):glowshift():x(32)
							end
						end
					end,
					Def.Sprite{
						Name="Banner",
						OnCommand=function(self)
							self:Load(Songs[pos][1]:GetBannerPath())
							self:zoom(DDR.Resize(self:GetWidth(),self:GetHeight(),128,40))
						end
					},
					Def.Quad{
						Name="FallbackBanner",
						OnCommand=function(self)
							self:zoomto(128,40):diffuse(.5,.5,.5,1)
							if Songs[pos][1]:HasBanner() then
								self:diffusealpha(0):zoom(0)
							end
						end
					},
					Def.BitmapText{
						Font="Common Normal",
						Name="BannerText",
						Text=Songs[pos][1]:GetDisplayMainTitle(),
						OnCommand=function(self)
							self:maxwidth(250):strokecolor(0,0,0,1):zoom(.5)
							if Songs[pos][1]:HasBanner() then
								self:diffusealpha(0):zoom(0)
							end
						end
					}
				}
			}
		end
	end

	for i = 1,6 do
		for i2 = 1,2 do
			t[#t+1] = Def.ActorFrame{
				Name="DiffSelector"..i..i2,
				Def.Sprite{
					Name="DiffCon",
					Texture=THEME:GetPathG("","DiffCon.png"),
					OnCommand=function(self)
						self:zoom(.5):y(SCREEN_CENTER_Y+(i*32)):x(SCREEN_CENTER_X+((i2-1.5)*224)):diffusealpha(0)
					end
				},
				Def.BitmapText{
					Font="Common Normal",
					Name="DiffName",
					Text="Practice",
					OnCommand=function(self)
						self:maxwidth(60):zoomy(.5):y(SCREEN_CENTER_Y+(i*32)):x(SCREEN_CENTER_X+((i2-1.5)*224)):diffusealpha(0)
					end
				}
			}
		end
		for i2 = 1,9 do
			t[#t+1] = Def.Sprite{
				Name="Feet"..i..i2,
				Texture=THEME:GetPathG("","Feet.png"),
				OnCommand=function(self)
					self:zoom(.125):y(SCREEN_CENTER_Y+(i*32)):x(SCREEN_CENTER_X+((i2-5)*16)):diffusealpha(0)
				end
			}
		end
	end

	return t
end

return MusicWheel()

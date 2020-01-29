-- SSC Color Module and Library
ColorGR = {
	PLAYER_1 = color("0,0.9,1,0.5"),
	PLAYER_2 = color("1,0,0.9,0.5"),
}
-- O
-- Original Color Module.
Color = {
-- Color Library
-- These colors are pure swatch colors and are here purely to be used
-- on demand without having to type color("stuff") or dig through
-- a palette to get the color you want.
	Black		=	color("0,0,0,1"),
	White		=	color("1,1,1,1"),
	Red		=	color("#ed1c24"),
	Blue		=	color("0,0,1,1"),
	Green		=	color("#12ff00"),
	Yellow		=	color("#fff200"),
	Orange		=	color("#f7941d"),
	Purple		=	color("#92278f"),
	Pink		=	color("#ff43e7"),
	Outline		=	color("0,0,0,1"),
	Invisible	=	color("1,1,1,0"),
	Stealth		=	color("0,0,0,0"),
-- Color Functions
-- These functions alter colors in a certain way so that you can make
-- new ones without having to copy a color or find a new one.
--[[     Brightness(fInput)
    Hue(hInput)
    Saturation(hInput)
    Alpha(hInput)
    HSV(iHue,fSaturation,fValue or any other overload) --]]
	Alpha = function(c, fAlpha)
		return { c[1],c[2],c[3], fAlpha }
	end
}

setmetatable(Color, { __call = function(self, c) return self[c] end })

group_colors = {
	["1-Licenses"]= color("#FFFFFF"),
	["2-KONAMI Originals"]= color("#00CC00"),
	["3-Requests"]= color("#FFFF00"),
	["4-Revivials"]= color("#33CCFF"),
	["5-NOVAmix"]= color("#FF00FF"),
	["6a-ENCORE EXTRA STAGE"]= color("#FF9933"),
	["6b-EXTRA STAGE"]= color("#FF0000"),
	["7-DLC"]= color("#FF9933"),
};

-- Remapped Color Module, since some themes are crazy
-- Colors = Color;

GameColor = {
	PlayerColors = {
		PLAYER_1 = color("#00dcff"),
		PLAYER_2 = color("#ff00cf"),
	},
	Difficulty = {
		--[[ These are for 'Custom' Difficulty Ranks. It can be very  useful
		in some cases, especially to apply new colors for stuff you
		couldn't before. (huh? -aj) ]]
		Beginner	= color("0.37,0.74,0.88,1"),			-- light blue
		Easy		= color("1,0.996,0,1"),			-- yellow
		Medium		= color("0.95,0.42,0.48,1"),			-- red
		Hard		= color("0,0.996,0,1"),			-- green
		Challenge	= color("0.78,0.4,1,1"),			-- light cyan
		Edit		= color("0.8,0.8,0.8,1"),		-- gray
		Couple		= color("#ed0972"),			-- hot pink
		Routine		= color("#ff9a00"),			-- orange
		--[[ These are for courses, so let's slap them here in case someone
		wanted to use Difficulty in Course and Step regions. ]]
		Difficulty_Beginner	= color("0.37,0.74,0.88,1"),	-- light blue
		Difficulty_Easy		= color("1,0.996,0,1"),		-- yellow
		Difficulty_Medium	= color("0.95,0.42,0.48,1"),		-- red
		Difficulty_Hard		= color("0,0.996,0,1"),		-- green
		Difficulty_Challenge	= color("0.78,0.4,1,1"),		-- purple
		Difficulty_Edit 	= color("0.8,0.8,0.8,1"),		-- gray
		Difficulty_Couple	= color("#ed0972"),				-- hot pink
		Difficulty_Routine	= color("#ff9a00")				-- orange
	},
	Stage = {
		Stage_1st	= color("#00ffc7"),
		Stage_2nd	= color("#58ff00"),
		Stage_3rd	= color("#f400ff"),
		Stage_4th	= color("#00ffda"),
		Stage_5th	= color("#ed00ff"),
		Stage_6th	= color("#73ff00"),
		Stage_Next	= color("#73ff00"),
		Stage_Final	= color("#ff0707"),
		Stage_Extra1	= color("#fafa00"),
		Stage_Extra2	= color("#ff0707"),
		Stage_Nonstop	= color("#FFFFFF"),
		Stage_Oni	= color("#FFFFFF"),
		Stage_Endless	= color("#FFFFFF"),
		Stage_Event	= color("#FFFFFF"),
		Stage_Demo	= color("#FFFFFF")
	},
	Judgment = {
		JudgmentLine_W1		= color("#bfeaff"),
		JudgmentLine_W2		= color("#fff568"),
		JudgmentLine_W3		= color("#48ff1d"),
		JudgmentLine_W4		= color("#34bfff"),
		JudgmentLine_W5		= color("#e44dff"),
		JudgmentLine_Held	= color("#FFFFFF"),
		JudgmentLine_Miss	= color("#ff3c3c"),
		JudgmentLine_MaxCombo	= color("#ffc600")
	},
}

GameColor.Difficulty["Crazy"] = GameColor.Difficulty["Hard"]
GameColor.Difficulty["Freestyle"] = GameColor.Difficulty["Easy"]
GameColor.Difficulty["Nightmare"] = GameColor.Difficulty["Challenge"]
GameColor.Difficulty["HalfDouble"] = GameColor.Difficulty["Medium"]

--[[ Fallbacks ]]
function BoostColor( cColor, fBoost )
	local c = cColor
	return { c[1]*fBoost, c[2]*fBoost, c[3]*fBoost, c[4] }
end

function ColorLightTone(c)
	return { c[1]+(c[1]/2), c[2]+(c[2]/2), c[3]+(c[3]/2), c[4] }
end

function ColorMidTone(c)
	return { c[1]/1.5, c[2]/1.5, c[3]/1.5, c[4] }
end

function ColorDarkTone(c)
	return { c[1]/2, c[2]/2, c[3]/2, c[4] }
end

function PlayerColor( pn )
	if pn == PLAYER_1 then return color("#0089cf") end -- sea-blue
	if pn == PLAYER_2 then return color("#f253ed") end -- pink-red
	return color("1,1,1,1")
end
function PlayerScoreColor( pn )
	if pn == PLAYER_1 then return color("#0089cf") end -- sea-blue
	if pn == PLAYER_2 then return color("#ef403d") end -- pink-red
	return color("1,1,1,1")
end

function CustomDifficultyToColor( sCustomDifficulty )
	return GameColor.Difficulty[sCustomDifficulty]
end

function CustomDifficultyToDarkColor( sCustomDifficulty )
	local c = GameColor.Difficulty[sCustomDifficulty]
	return { c[1]/2, c[2]/2, c[3]/2, c[4] }
end

function CustomDifficultyToLightColor( sCustomDifficulty )
	local c = GameColor.Difficulty[sCustomDifficulty]
	return { scale(c[1],0,1,0.5,1), scale(c[2],0,1,0.5,1), scale(c[3],0,1,0.5,1), c[4] }
end

function StepsOrTrailToColor(StepsOrTrail)
	return CustomDifficultyToColor( StepsOrTrailToCustomDifficulty(stepsOrTrail) )
end

function StageToColor( stage )
	return GameColor.Stage[stage] or color("#000000")
end

function StageToStrokeColor( stage )
	local c = GameColor.Stage[stage]
	return { c[1]/2, c[2]/2, c[3]/2, c[4] }
end

function JudgmentLineToColor( i )
	return GameColor.Judgment[i] or color("#000000")
end

function JudgmentLineToStrokeColor( i )
	local c = GameColor.Judgment[i]
	return { c[1]/2, c[2]/2, c[3]/2, c[4] }
end

function color_grp(params)
	return group_colors[params.Song:GetGroupName()] or color("#FFFFFF")
end;

--this is for replicating the leading zeros functionality of RollingNumbers
--without RollingNumbers
function GetLeadingAttribute(number, baselength, color)
	local len = baselength - #(tostring(math.floor(number)))
	if len > 0 then
		return {Length = len, Diffuse = color}
	end
end


FullComboEffectColor = {
	TapNoteScore_W1=color("#fefed0");
	TapNoteScore_W2=color("#f8fd6d");
	TapNoteScore_W3=color("#01e603");
	TapNoteScore_W4=color("#10e0f1");
};
--various functions that help us work with chaquetes.........


function GetJacketPath(item, fallback)
	--i.e. 
	if item.HasJacket and item:HasJacket() then
		return item:GetJacketPath()
	elseif item:HasBackground() then
		return item:GetBackgroundPath()
	elseif item:HasBanner() then
		return item:GetBannerPath()
	else
		return fallback or THEME:GetPathG("MusicWheelItem", "fallback")
	end
end

function Sprite:_LoadSCJacket(...)
	return self:Load(GetJacketPath(...))
end

function GetGroupJacketPath(groupName, fallback)
	local paths = {
		"/Songs/"..groupName.."/jacket.png",
		"/Songs/"..groupName.."/jacket.jpg",
		"/AdditionalSongs/"..groupName.."/jacket.png",
		"/AdditionalSongs/"..groupName.."/jacket.jpg"
	}
	for path in ivalues(paths) do
		if FILEMAN:DoesFileExist(path) then
			return path
		end
	end
	return fallback or THEME:GetPathG("MusicWheelItem", "fallback")
end

function GetGroupBannerPath(groupName, fallback)
	local paths = {
		"/Songs/"..groupName.."/banner.png",
		"/Songs/"..groupName.."/banner.jpg",
		"/AdditionalSongs/"..groupName.."/banner.png",
		"/AdditionalSongs/"..groupName.."/banner.jpg"
	}
	for path in ivalues(paths) do
		if FILEMAN:DoesFileExist(path) then
			return path
		end
	end
	return fallback or THEME:GetPathG("", "Common fallback banner")
end

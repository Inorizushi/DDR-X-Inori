local screen = Var("LoadingScreen")

local t = Def.ActorFrame{}

if THEME:GetMetric(screen, "ShowHeader") then
	t[#t+1] = LoadActor(THEME:GetPathG(screen, "Header")) .. {
		Name = "Header",
	}
end

if THEME:GetMetric(screen, "ShowFooter") then
	t[#t+1] = LoadActor(THEME:GetPathG(screen, "Footer")) .. {
		Name = "Footer",
	}
end

return t

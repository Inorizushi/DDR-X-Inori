function curved_wheel_transform(self,offsetFromCenter,_fake1,_fake2)

	local numItems = THEME:GetMetric("MusicWheel","NumWheelItems")
	local curve3D = THEME:GetMetric("MusicWheel", "CirclePercent")*4*math.pi
	local fRotX = scale(offsetFromCenter, -numItems/2,numItems/2, -curve3D/2,curve3D/2)
	local radius = THEME:GetMetric("MusicWheel","Wheel3DRadius")
	local curveX = THEME:GetMetric("MusicWheel","ItemCurveX")
	local spacingY = THEME:GetMetric("MusicWheel","ItemSpacingY")
	self:x( (1-math.cos(offsetFromCenter/math.pi))*curveX )
	self:z( -15*math.abs(offsetFromCenter*2.5) )
	self:rotationx((offsetFromCenter*20) * math.sin(180/math.pi))
	self:y( (offsetFromCenter*scale(math.abs(offsetFromCenter), 0,numItems/2, spacingY,spacingY*math.sin(0.6))) )
	if offsetFromCenter < -0.5 then
		self:addy( -2 );
	elseif offsetFromCenter > 0.5 then
		self:addy( 2 );
	elseif offsetFromCenter >= -0.5 and offsetFromCenter <= 0.5 then
		self:addy( 0 );
	end
end

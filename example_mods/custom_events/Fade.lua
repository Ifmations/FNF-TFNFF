function onEvent(name, value1, value2)
	if name == 'Fade' then

		makeLuaSprite('cover', '', 0, 0);
		makeGraphic('cover',1280,720,'000000')
		addLuaSprite('cover', true);
		setLuaSpriteScrollFactor('cover',0,0)
		setProperty('cover.scale.x',1.2)
		setProperty('cover.scale.y',1.2)
		setProperty('cover.alpha',0)
		
		state = tonumber(value1);

		if state == 0 then
			fadeTo = true
			fadeFrom = false
			doTweenAlpha('coverfadeto', 'cover', 1, value2)
		end

		if state == 1 then
			fadeTo = false
			fadeFrom = true
			fadeTimer = value2
			setProperty('cover.alpha', 1)
			doTweenAlpha('coverfadefrom', 'cover', 0, value2)
		end
	end
end

function update (elapsed)

end

fadeTo = false
fadeFrom = false
fadeTimer = 7

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'coverfadeto' then
		fadeTo = false
	end

	if tag == 'coverfadefrom' then
		fadeFrom = false
	end
end
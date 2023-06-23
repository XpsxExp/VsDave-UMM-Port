function onCreate()
   luaDebugMode = true;
end

function onEvent(name)
   if name == 'Tristan Flashbang' then
	  local tweenTime = (stepCrochet / 1000) * 20;
	  makeLuaSprite('whiteFake');
	  makeGraphic('whiteFake', screenWidth * 2, screenHeight * 2, 'FFFFFF');
	  screenCenter('whiteFake');
	  setProperty('whiteFake.alpha', 0);
	  setScrollFactor('whiteFake', 0, 0);
	  addLuaSprite('whiteFake', true);
	  doTweenAlpha('whiteFakeFade', 'whiteFake', 1, tweenTime);
      runHaxeCode([[
	    FlxTween.num(game.defaultCamZoom, game.defaultCamZoom + 0.4, ]] .. tweenTime .. [[, {}, function(nwVal:Float) {
		   game.defaultCamZoom = nwVal;
		});
	  ]]);
   end
end

function onTweenCompleted(tag)
   if tag == 'whiteFakeFade' then
      doTweenAlpha('whiteFake', 'whiteFake', 0, 0.5);
	  setProperty('defaultCamZoom', 0.7);
   end
end
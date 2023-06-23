local spotLightScaler = 1.3;
local spotLightPart = false;

function onCreate()
   luaDebugMode = true;
   makeLuaSprite('spotLight', 'spotLight');
   setGraphicSize('spotLight', math.floor(getProperty('spotLight.width') * (getProperty('dad.frameWidth') / getProperty('spotLight.width') * spotLightScaler)), 0, false);
   updateHitbox('spotLight');
   setProperty('spotLight.alpha', 0);
   setOrigin('spotLight', getProperty('spotLight.origin.x'), getProperty('spotLight.origin.y') - (getProperty('spotLight.frameHeight') / 2));
   addLuaSprite('spotLight', true);
   setBlendMode('spotLight', 'ADD');
   
   setPosition('spotLight', getGraphicMidpointX('dad') - (getProperty('spotLight.width') / 2), getGraphicMidpointY('dad') - (getProperty('spotLight.height') / 2));
end

function onCreatePost()
   setObjectOrder('spotLight', 10000);
   updateSpotlight(false);
end

function setOrigin(tag, x, y)
   runHaxeCode([[
     game.getLuaObject(']] .. tag .. [[').origin.set(]] .. x .. [[, ]] .. y .. [[);
   ]])
end

function setPosition(tag, x, y)
   runHaxeCode([[
     game.getLuaObject(']] .. tag .. [[').setPosition(]] .. x .. [[, ]] .. y .. [[);
   ]]);
end

function onEvent(name)
   if name == 'Spotlight' then
      spotLightPart = not spotLightPart;
   end
end

function onSectionHit()
   if spotLightPart then
      updateSpotlight(mustHitSection);
   end
end

function onBeatHit()
   if spotLightPart and curBeat % 3 == 0 then
      cancelTween('spotLightAngle');
	  if getProperty('spotLight.health') ~= 3 then
	     doTweenAngle('spotLightAngle', 'spotLight', 2, (crochet / 1000) * 3, 'expoInOut');
		 setProperty('spotLight.health', 3);
	  else
	     doTweenAngle('spotLightAngle', 'spotLight', -2, (crochet / 1000) * 3, 'expoInOut');
		 setProperty('spotLight.health', 1);
	  end
   end
end

function updateSpotlight(bfSinging)
   addHaxeLibrary('FlxBasePoint', 'flixel.math');
   local curSinger = 'dad';
   if bfSinging then
      curSinger = 'boyfriend';
   else
      curSinger = 'dad';
   end
   runHaxeCode([[
       var positionOffset = new FlxBasePoint();
   
       switch (game.]] .. curSinger .. [[.curCharacter) {
	      case 'bambi':
	          positionOffset.x = -35;
	          positionOffset.y = -90;
		  case 'bambi-angey':
		      positionOffset.y = 100;
	   }
   
       var targetPosition = new FlxBasePoint(game.]] .. curSinger .. [[.getGraphicMidpoint().x - (game.getLuaObject('spotLight').width / 2) - positionOffset.x, game.]] .. curSinger .. [[.getGraphicMidpoint().y - (game.getLuaObject('spotLight').height / 2) - positionOffset.y);
	 
	   game.modchartTweens.set('spotLightMove', FlxTween.tween(game.getLuaObject('spotLight'), {x: targetPosition.x, y: targetPosition.y}, 0.66, {ease: FlxEase.circOut, onComplete: function(tween:FlxTween) {
	         game.callOnLuas('onTweenCompleted', ['spotLightMove']);
		     game.modchartTweens.remove('spotLightMove');
		  }
	   }));
	 ]])
end
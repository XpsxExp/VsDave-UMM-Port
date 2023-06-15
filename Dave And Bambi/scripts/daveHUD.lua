local theThingy = 0.88;
local theFunny = 0;

function onCreatePost()
   addHaxeLibrary('FlxMath', 'flixel.math');

   setObjectOrder('healthBar', getObjectOrder('healthBarBG') - 1);
   setObjectOrder('timeBar', getObjectOrder('timeBarBG') - 1); setTimeBarColors('39FF14', '808080'); screenCenter('timeBar', 'x'); screenCenter('timeBarBG', 'x');
   setProperty('timeTxt.y', getProperty('timeTxt.y') - 7);
   
   makeIcon('fakeP1', 0, getProperty('iconP1.y'), getProperty('boyfriend.healthIcon'), true);
   makeIcon('fakeP2', 0, getProperty('iconP2.y'), getProperty('dad.healthIcon'), false);
   setProperty('iconP1.visible', false); setProperty('iconP2.visible', false);
end

function onUpdate()
   setGraphicSize('fakeP1', math.lerp(150, getProperty('fakeP1.width'), theThingy), math.lerp(150, getProperty('fakeP1.height'), theThingy));
   setGraphicSize('fakeP2', math.lerp(150, getProperty('fakeP2.width'), theThingy), math.lerp(150, getProperty('fakeP2.height'), theThingy));
   
   runHaxeCode([[
     game.getLuaObject('fakeP1').x = game.healthBar.x + (game.healthBar.width * (FlxMath.remapToRange(game.healthBar.percent, 0, 100, 100, 0) * 0.01) - 26);
	 game.getLuaObject('fakeP2').x = game.healthBar.x + (game.healthBar.width * (FlxMath.remapToRange(game.healthBar.percent, 0, 100, 100, 0) * 0.01)) - (game.getLuaObject('fakeP2').width - 26);
   ]])
   
   if getProperty('healthBar.percent') < 20 then changeState('fakeP1', 'losing'); else changeState('fakeP1', 'normal'); end
   if getProperty('healthBar.percent') > 80 then changeState('fakeP2', 'losing'); else changeState('fakeP2', 'normal'); end
end

function onBeatHit()
   theFunny = math.max(math.min(getProperty('healthBar.value'), 1.9), 0.1);
   --Normal bounce.
   setGraphicSize('fakeP1', getProperty('fakeP1.width') + (50 * (theFunny + 0.1)), getProperty('fakeP1.height') - (25 * theFunny));
   setGraphicSize('fakeP2', getProperty('fakeP2.width') + (50 * (2 - theFunny) + 0.1), getProperty('fakeP2.height') - (25 * ((2 - theFunny) + 0.1)));
   --Five Nights icon bounce.
   -- setGraphicSize('fakeP1', getProperty('fakeP1.width') + (50 * ((2 - theFunny) + 0.1))), getProperty('fakeP1.height') - (25 * ((2 - theFunny) + 0.1))), false);
   -- setGraphicSize('fakeP2', getProperty('fakeP2.width') + (50 * theFunny)), getProperty('fakeP2.height') - (25 * theFunny)), false);
end

function changeState(icon, state)
   local animFrame = {['normal'] = 0, ['losing'] = 1};
   setProperty(icon .. '.animation.curAnim.curFrame', animFrame[state]);
end

function makeIcon(tag, x, y, image, isPlayer)
   local charTag = {[true] = 'boyfriend', [false] = 'dad'};
   makeLuaSprite(tag, nil, x, y);
   loadGraphic(tag, 'icons/icon-' .. image, 150, 150);
   addAnimation(tag, image, {0, 1}, 0, false);
   setProperty(tag .. '.antialiasing', getProperty(charTag[isPlayer] .. '.antialiasing'));
   setObjectCamera(tag, 'camHUD');
   setObjectOrder(tag, getObjectOrder('healthBarBG') + 1);
   addLuaSprite(tag, true);
   
   if isPlayer then setProperty(tag .. '.flipX', true); end
end

function onEvent(name, value1)
   if name == 'Change Character' then
      local iconToChange = {['dad'] = {'dad', 'fakeP2', false}, ['bf'] = {'boyfriend', 'fakeP1', true}};
	  makeIcon(iconToChange[value1][2], getProperty(iconToChange[value1][2] .. '.x'), getProperty('iconP1.y'), getProperty(iconToChange[value1][1] .. '.healthIcon'), iconToChange[value1][3]);
   end
end

function math.lerp(a, b, t)
	return a + t * (b - a);
end
local darkSkyStartPos = 1280;
local resetPos = -2560;
local scrollSpeed = 150;
local lerpVal = 0.97;
--Freeplay BGs.
local daveBG = '';
local tristanBG = '';
local bambiBG = '';
--Variables for the work around since FlxBackdrop doesn't work.
local originalPositions = {};
local groupTags = {};
--Bambi: -16769276
--Tristan: -13893632

function onCreate()
   luaDebugMode = true;
   local bgZoom = 0.4;
   
   makeBackgroundSprite('darkSky', 'recursed/darkSky', darkSkyStartPos, 0, 1, 1);
   scaleObject('darkSky', (1 / bgZoom) * 2, 1 / bgZoom);
   setProperty('darkSky.y', (screenHeight - getProperty('darkSky.height') / 2));
   
   makeBackgroundSprite('darkSky2', 'recursed/darkSky', getProperty('darkSky.x') - getProperty('darkSky.width'), 0, 1, 1);
   scaleObject('darkSky2', (1 / bgZoom) * 2, 1 / bgZoom);
   setProperty('darkSky2.x', getProperty('darkSky.x') - getProperty('darkSky.width'));
   setProperty('darkSky2.y', getProperty('darkSky.y'));
   
   makeBackgroundSprite('freeplayBG', 'freeplayBackgrounds/' .. getRandomBackground(), 0, 0, 0, 0);
   setGraphicSize('freeplayBG', math.floor(getProperty('freeplayBG.width') * 2));
   setProperty('freeplayBG.alpha', 0);
   setProperty('freeplayBG.color', -15920852);
   screenCenter('freeplayBG');
   
   local theRow = 1;
   local theCount = 1;
   for i = 1, 24 do
      local curTag = 'charScroll' .. i .. theRow;
      makeLuaSprite(curTag, 'recursed/daveScroll');
	  scaleObject(curTag, 2, 2);
	  setProperty(curTag .. '.x', getProperty(curTag .. '.x') + getProperty(curTag .. '.width') * theCount); 
	  setProperty(curTag .. '.y', getProperty(curTag .. '.y') + getProperty(curTag .. '.height') * theRow); 
	  setProperty(curTag .. '.alpha', 0);
	  addLuaSprite(curTag, false);
	  setProperty(curTag .. '.offset.x', 300);
	  setProperty(curTag .. '.offset.y', 400);
	  setScrollFactor(curTag, 0, 0);
	  theCount = theCount + 1;
	  if theCount > 6 then
	     theCount = 1;
		 theRow = theRow + 1;
	  end
	  table.insert(originalPositions, {getProperty(curTag .. '.x'), getProperty(curTag .. '.y')});
	  table.insert(groupTags, curTag);
	  setProperty(curTag .. '.color', -13882324);
   end
   
   runHaxeCode([[
     songList = ['House', 'Insanity', 'Polygonized', 'Bonus Song'];
   ]])
   
   createLetters();
end

function onBeatHit()
   if curBeat % 4 == 0 then
	  for i = 1, #groupTags do
	     setProperty(groupTags[i] .. '.alpha', 0.8);
		 setProperty(groupTags[i] .. '.x', originalPositions[i][1]);
		 setProperty(groupTags[i] .. '.y', originalPositions[i][2]);
	  end
   
      setProperty('freeplayBG.alpha', 0.8);
	  
      runHaxeCode([[
        for (daChar in theAlphaCharacters) {
	      for (daLetter in daChar.letters) {
	        daLetter.alpha = 0.4;
	      }
	    }
      ]])
   end
end

function makeBackgroundSprite(tag, path, x, y, xScroll, yScroll)
   makeLuaSprite(tag, path, x, y);
   setScrollFactor(tag, xScroll, yScroll);
   addLuaSprite(tag);
end

function getRandomBackground()
   local bgFiles = directoryFileList('mods/' .. currentModDirectory .. '/images/freeplayBackgrounds');
   return string.gsub(bgFiles[getRandomInt(1, #bgFiles)], '.png', '');
end

function onUpdate(elapsed)
   setProperty('darkSky.x', getProperty('darkSky.x') + 40 * scrollSpeed * elapsed);
   if getProperty('darkSky.x') >= (darkSkyStartPos * 4) - 1280 then
      setProperty('darkSky.x', resetPos);
   end
   setProperty('darkSky2.x', getProperty('darkSky.x') - getProperty('darkSky.width'));
   
   for i = 1, #groupTags do
      setProperty(groupTags[i] .. '.x', getProperty(groupTags[i] .. '.x') - scrollSpeed * elapsed);
	  setProperty(groupTags[i] .. '.y', getProperty(groupTags[i] .. '.y') + scrollSpeed * elapsed);
	  
	  setProperty(groupTags[i] .. '.alpha', math.lerp(0, getProperty(groupTags[i] .. '.alpha'), lerpVal - elapsed)); --Now the lerp should be consistent I guess? 
   end
   
   setProperty('freeplayBG.alpha', math.lerp(0, getProperty('freeplayBG.alpha'), lerpVal - elapsed));
   
   runHaxeCode([[
     for (daChar in theAlphaCharacters) {
	   for (daLetter in daChar.letters) {
	     daLetter.alpha = FlxMath.lerp(0, daLetter.alpha, 0.97 - ]] .. elapsed .. [[);
	   }
	 }
   ]])
end

function math.lerp(a, b, ratio)
   return a + ratio * (b - a);
end

function createLetters()
   addHaxeLibrary('FlxG', 'flixel'); addHaxeLibrary('FlxTypedGroup', 'flixel.group'); addHaxeLibrary('FlxMath', 'flixel.math');

   runHaxeCode([[
     var alphaCharacters:FlxTypedGroup<Alphabet> = new FlxTypedGroup();
	 
	 for (daLetter in alphaCharacters) {
	   alphaCharacters.remove(daLetter);
	   remove(daLetter);
	 }
	 
	 startWidth = 640;
	 width = startWidth;
	 row = 0;
	 
	 while (row < FlxG.height) {
	   while (width < FlxG.width * 2.5) {
	     for (i in 0...songList.length) {
		   curSong = songList[i];
		   theSong = new Alphabet(0, 0, curSong, true);
		   theSong.x = width;
		   theSong.y = row;
		   
		   width += theSong.width + 20;
		   alphaCharacters.add(theSong);
		   game.addBehindGF(theSong);
		   
		   if (width > FlxG.width * 2.5) {
		     break;
		   }
		 }
	   }
	   row += 120;
	   width = startWidth;
	 }
	 
	 for (daChar in alphaCharacters) {
	   for (daLetter in daChar.letters) {
	     daLetter.alpha = 0;
	   }
	 }
	
	 for (daChar in alphaCharacters) {
	   for (alphaChar in daChar.letters) {
	     alphaChar.velocity.set(FlxG.random.float(-50, 50), FlxG.random.float(-50, 50));
		 alphaChar.angularVelocity = FlxG.random.int(30, 50);
		 
		 alphaChar.setPosition(FlxG.random.float(-FlxG.width / 2, FlxG.width * 2.5), FlxG.random.float(0, FlxG.height * 2.5));
	   }
	 }
	 theAlphaCharacters = alphaCharacters;
   ]])
end

function onEvent(name, value1)
   if name == 'Update Freeplay' then
      if string.lower(value1) == 'dave' then
	     for i = 1, #groupTags do
		    loadGraphic(groupTags[i], 'recursed/daveScroll');
		 end
		 loadGraphic('freeplayBG', 'freeplayBackgrounds/' .. getRandomBackground());
		 setProperty('freeplayBG.color', -15920852);
		 runHaxeCode([[ songList = ['House', 'Insanity', 'Polygonized', 'Bonus Song']; ]]);
		 createLetters();
      elseif string.lower(value1) == 'bambi' then
	     for i = 1, #groupTags do
		    loadGraphic(groupTags[i], 'recursed/bambiScroll');
		 end
		 loadGraphic('freeplayBG', 'freeplayBackgrounds/' .. getRandomBackground());
		 setProperty('freeplayBG.color', -16769276);
		 runHaxeCode([[ songList = ['Blocked', 'Corn Theft', 'Maze', 'Mealie']; ]]);
		 createLetters();
	  elseif string.lower(value1) == 'tristan' then
	     for i = 1, #groupTags do
		    loadGraphic(groupTags[i], 'recursed/tristanScroll');
		 end
		 loadGraphic('freeplayBG', 'freeplayBackgrounds/' .. getRandomBackground());
		 setProperty('freeplayBG.color', -13893632);
		 runHaxeCode([[ songList = ['Adventure', 'Vs Tristan']; ]]);
		 createLetters();
	  end
   end
end
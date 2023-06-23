local inGuitarHero = false;
local middleStrumValues = {
   [0] = 412, [1] = 524, [2] = 636, [3] = 748
};
local allTheStuff = {
   'theDarkness',
   'bambiSpot',
   'bfSpot',
   'highWay',
   'frontBlack'
};
local dadStrumsBasePosition = {};
local bfStrumsBasePosition = {};
local firstTime = false;

function onCreatePost()
   addHaxeLibrary('Std'); addHaxeLibrary('Math'); addHaxeLibrary('FlxG', 'flixel'); addHaxeLibrary('Character');
   precacheImage('NOTE_gh');
   
   for i = 0, getProperty('opponentStrums.length') - 1 do
      table.insert(dadStrumsBasePosition, getPropertyFromGroup('opponentStrums', i, 'x'));
   end
   
   for i = 0, getProperty('playerStrums.length') - 1 do
      table.insert(bfStrumsBasePosition, getPropertyFromGroup('playerStrums', i, 'x'));
   end
end

function onEvent(name, value1)
   if name == 'Guitar Hero Section' then
      if value1 == 'true' then
		 makeLuaSprite('theDarkness');
		 makeGraphic('theDarkness', screenWidth, screenHeight, '000000');
		 setObjectCamera('theDarkness', 'camHUD');
		 setProperty('theDarkness.alpha', 0.9);
		 screenCenter('theDarkness');
		 addLuaSprite('theDarkness');
	  
	     makeLuaSprite('bambiSpot', 'festival/shredder/bambi_spot', 34, 151);
		 setObjectCamera('bambiSpot', 'camHUD');
		 setBlendMode('bambiSpot', 'ADD');
		 addLuaSprite('bambiSpot');
	  
	     makeLuaSprite('bfSpot', 'festival/shredder/boyfriend_spot', 995, 381); 
		 setObjectCamera('bfSpot', 'camHUD');
		 setProperty('bfSpot.alpha', 0);
		 setBlendMode('bfSpot', 'ADD');
		 addLuaSprite('bfSpot');
		 
		 makeLuaSprite('highWay', 'festival/shredder/ch_highway');
		 setGraphicSize('highWay', math.floor(getProperty('highWay.width') * (640 / getProperty('highWay.width'))), math.floor(getProperty('highWay.height') * (1280 / getProperty('highWay.height'))));
		 setObjectCamera('highWay', 'camHUD');
		 setProperty('highWay.antialiasing', false);
		 screenCenter('highWay');
		 addLuaSprite('highWay');
	     
	     runHaxeCode([[
		   //Fuck you i'm not doing custom character support.
		   fakeDad = new Character(1, 2, 'bambi-shredder', false);
		   fakeDad.cameras = [game.camHUD];
		   fakeDad.scale.set(fakeDad.scale.x * 0.55, fakeDad.scale.y * 0.55);
		   game.add(fakeDad);
		   
		   fakeBf = new Character(921, 189, 'bf', true);
		   fakeBf.cameras = [game.camHUD];
		   fakeBf.scale.set(fakeBf.scale.x * 0.45, fakeBf.scale.y * 0.45); 
		   game.add(fakeBf);
		   
		   for (i in fakeDad.animOffsets.keys()) {
		     fakeDad.animOffsets[i] = [fakeDad.animOffsets[i][0] * fakeDad.scale.x, fakeDad.animOffsets[i][1] * fakeDad.scale.y];
		   }
		   
		   for (i in fakeBf.animOffsets.keys()) {
		     fakeBf.animOffsets[i] = [fakeBf.animOffsets[i][0] * fakeBf.scale.x, fakeBf.animOffsets[i][1] * fakeBf.scale.y];
		   }
		 ]])
		 
		 for i = 0, getProperty('opponentStrums.length') - 1 do
		    setPropertyFromGroup('opponentStrums', i, 'texture', 'NOTE_gh');
			setPropertyFromGroup('opponentStrums', i, 'x', middleStrumValues[i]);
			setPropertyFromGroup('opponentStrums', i, 'alpha', 1);
		 end
		 
		 for i = 0, getProperty('playerStrums.length') - 1 do
		    setPropertyFromGroup('playerStrums', i, 'x', middleStrumValues[i]);
			setPropertyFromGroup('playerStrums', i, 'alpha', 0);
		 end
		 
		 for i = 0, getProperty('notes.length') - 1 do
		    setPropertyFromGroup('notes', i, 'noAnimation', true);
			setPropertyFromGroup('notes', i, 'noMissAnimation', true);
			
			if not getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'noteType') == ''  then
			   setPropertyFromGroup('notes', i, 'texture', 'NOTE_gh');
			end
		 end
		 
		 for i = 0, getProperty('unspawnNotes.length') - 1 do
		    setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true);
			setPropertyFromGroup('unspawnNotes', i, 'noMissAnimation', true);
			
			if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') and getPropertyFromGroup('unspawnNotes', i, 'noteType') == '' then
			   setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_gh');
			end
		 end
		 
		 inGuitarHero = true;
	  elseif value1 == 'false' then
	     makeLuaSprite('frontBlack');
		 makeGraphic('frontBlack', screenWidth, screenHeight, '000000');
		 setObjectCamera('frontBlack', 'camHUD');
		 setProperty('frontBlack.alpha', 0);
		 screenCenter('frontBlack');
		 addLuaSprite('frontBlack', true);
		 
		 doTweenAlpha('frontBlackFadeIn', 'frontBlack', 1, 0.5);
	  end
   end
   
   if name == 'Boyfriend Spot' then
	  doTweenAlpha('bfSpotFadeIn', 'bfSpot', 1, 1);
   end
   
   if name == 'Switch Strums' then
      if not inGuitarHero and not leftSide then
         for i = 0, 3 do
	        noteTweenAlpha('dadStrum' .. i, i, 0, (stepCrochet / 1000) * 2);
	     end
	  elseif inGuitarHero then
         for i = 0, 3 do
	        noteTweenAlpha('dadStrum' .. i, i, 0, (stepCrochet / 1000) * 2);
	     end
	  end
	  
      for i = 4, 7 do
	     noteTweenAlpha('bfStrum' .. i, i, 1, (stepCrochet / 1000) * 2);
	  end
   end
end

function onTweenCompleted(tag)
   if tag == 'frontBlackFadeIn' then
	  runHaxeCode([[
	    fakeBf.destroy();
	    fakeDad.destroy();
	  ]])
		 
	  for i = 1, #allTheStuff do
         removeLuaSprite(allTheStuff[i], true);
	  end
	  
	  for i = 0, getProperty('opponentStrums.length') - 1 do
		 setPropertyFromGroup('opponentStrums', i, 'texture', 'NOTE_assets');
	     setPropertyFromGroup('opponentStrums', i, 'x', dadStrumsBasePosition[i + 1]);
		 setPropertyFromGroup('opponentStrums', i, 'alpha', 1);
	  end
		 
	  for i = 0, getProperty('playerStrums.length') - 1 do
		 setPropertyFromGroup('playerStrums', i, 'x', bfStrumsBasePosition[i + 1]);
	     setPropertyFromGroup('playerStrums', i, 'alpha', 1);
	  end
	  
	  for i = 0, getProperty('notes.length') - 1 do
	     setPropertyFromGroup('notes', i, 'noAnimation', false);
		 setPropertyFromGroup('notes', i, 'noMissAnimation', false);
			
		 if not getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'noteType') == '' then
		    setPropertyFromGroup('notes', i, 'texture', 'NOTE_assets');
	     end
	  end
		 
	  for i = 0, getProperty('unspawnNotes.length') - 1 do
		 setPropertyFromGroup('unspawnNotes', i, 'noAnimation', false);
		 setPropertyFromGroup('unspawnNotes', i, 'noMissAnimation', false);
			
		 if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') and getPropertyFromGroup('unspawnNotes', i, 'noteType') == '' then
		    setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_assets');
	     end
      end
	  
	  triggerEvent('Change Character', 'dad', 'bambi');
		 
	  inGuitarHero = false;
   end
end

function onUpdate()
   if inGuitarHero then
      runHaxeCode([[
	    //Object doesn't have property 'alpha'.
	    fakeBf.alpha = game.getLuaObject('bfSpot').alpha;
	  ]])
   end
end

function onBeatHit()
   if inGuitarHero then
      runHaxeCode([[
	    if (]] .. curBeat .. [[ % fakeDad.danceEveryNumBeats == 0 && fakeDad.animation.curAnim != null && !StringTools.startsWith(fakeDad.animation.curAnim.name, 'sing') && !fakeDad.stunned) {
		  fakeDad.dance();
		}
	  
	    if (]] .. curBeat .. [[ % fakeBf.danceEveryNumBeats == 0 && fakeBf.animation.curAnim != null && !StringTools.startsWith(fakeBf.animation.curAnim.name, 'sing') && !fakeBf.stunned) {
		  fakeBf.dance();
		}
	  ]])
   end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
   if inGuitarHero then
      runHaxeCode([[
        fakeBf.playAnim(game.singAnimations[Std.int(Math.abs(]] .. noteData .. [[))], true);
	    fakeBf.holdTimer = 0;
      ]])
   end
end

function noteMiss(id, noteData, noteType, isSustainNote)
   if inGuitarHero then
      runHaxeCode([[
        fakeBf.playAnim(game.singAnimations[Std.int(Math.abs(]] .. noteData .. [[))] + 'miss', true);
	    fakeBf.holdTimer = 0;
      ]])
   end
end

function noteMissPress(noteData)
   if inGuitarHero then
      runHaxeCode([[
        fakeBf.playAnim(game.singAnimations[Std.int(Math.abs(]] .. noteData .. [[))] + 'miss', true);
	    fakeBf.holdTimer = 0;
      ]])
   end
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
   if inGuitarHero then
      runHaxeCode([[
        fakeDad.playAnim(game.singAnimations[Std.int(Math.abs(]] .. noteData .. [[))], true);
	    fakeDad.holdTimer = 0;
      ]])
   end
end

function setPosition(tag, x, y)
   runHaxeCode([[
     game.]] .. tag .. [[.setPosition(]] .. x .. [[, ]] .. y .. [[);
   ]]);
end

function resizeOffsets(char)
   runHaxeCode([[
     for (i in game.]] .. char .. [[.animOffsets.keys()) {
	     game.]] .. char .. [[.animOffsets[i] = [game.]] .. char .. [[.animOffsets[i][0] * game.]] .. char .. [[.scale.x, game.]] .. char .. [[.animOffsets[i][1] * game.]] .. char .. [[.scale.y]; }
   ]])
end
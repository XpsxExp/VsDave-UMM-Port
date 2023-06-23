function onCreate()
   addHaxeLibrary('FlxG', 'flixel');
   addHaxeLibrary('Std');
   addHaxeLibrary('FlxMath', 'flixel.math');
   addHaxeLibrary('StringTools');
   addHaxeLibrary('FlxStringUtil', 'flixel.util');
end

function onCreatePost()
   if string.lower(songName) == 'recursed' then
      runHaxeCode([[
        for (daNote in game.unspawnNotes) {
	      if ((daNote.strumTime / 50) % 20 > 12 && daNote.mustPress && !daNote.isSustainNote) {
	        daNote.frames = Paths.getSparrowAtlas('DNBalphabet');
			//Just for the other scripts.
			daNote.noteType = 'Letter Note';
	   
	        noteColors = ['purple', 'blue', 'green', 'red'];
	        boldLetters = [];
	   
	        for (frameName in daNote.frames.frames) {
	          if (FlxStringUtil.contains(frameName.name, 'bold')) {
		        boldLetters.push(frameName.name);
		      }
	        }
	   
	        randomFrame = boldLetters[FlxG.random.int(0, boldLetters.length - 1)];
	        daPrefix = randomFrame.substr(0, randomFrame.length - 4);
	        for (note in noteColors) {
	          daNote.animation.addByPrefix('${note}Scroll', daPrefix, 24, true);
		      daNote.animation.play('${note}Scroll', true);
	        }
	   
	        daNote.setGraphicSize(Std.int(daNote.width * 1.2));
	        daNote.updateHitbox();
	        daNote.offsetX = -(daNote.width - 78);
		    }
	     }
      ]])
	  
	  for i = 0, getProperty('unspawnNotes.length') - 1 do
	     if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
		    setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_recursed');
			
			if getPropertyFromGroup('unspawnNotes', i, 'isSustainNote') then
			   setPropertyFromGroup('unspawnNotes', i, 'offsetX', 54);
			end
		 end
	  end
   end
end
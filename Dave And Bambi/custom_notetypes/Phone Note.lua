local animToPlay = {[0] = 'singLEFT-alt', [1] = 'phone', [2] = 'phone', [3] = 'singRIGHT-alt'};
local noteDataToStrum = {[0] = 4, [1] = 5, [2] = 6, [3] = 7};

function onCreatePost()
   luaDebugMode = true;
   for i = 0, getProperty('unspawnNotes.length') - 1 do
      if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Phone Note' or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Phone Slam' then
	     setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_phone');
		 setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true);
		 if not getPropertyFromGroup('unspawnNotes', i, 'isSustainNote') then
		    setPropertyFromGroup('unspawnNotes', i, 'offsetX', 20);
	     end
	  end
   end
end

function goodNoteHit(noteIndex, noteData, noteType, isSustainNote)
   if noteType == 'Phone Note' then
      if animationExists('boyfriend', 'dodge') then
	     playAnim('boyfriend', 'dodge', true);
		 setProperty('boyfriend.holdTimer', 0);
	  end
	  
	  if animationExists('dad', 'throw') then
	     playAnim('dad', 'throw', true);
		 setProperty('dad.holdTimer', 0);
	  elseif animationExists('dad', 'attack') then
	     playAnim('dad', 'attack', true);
		 setProperty('dad.holdTimer', 0);
	  end
   end
end

function opponentNoteHit(noteIndex, noteData, noteType, isSustainNote)
   if noteType == 'Phone Note' then
      playAnim('dad', animToPlay[noteData], true);
	  setProperty('dad.holdTimer', 0);
   elseif noteType == 'Phone Slam' then
      playAnim('dad', 'phone', true);
	  setProperty('dad.holdTimer', 0);
   end
end

function noteMiss(noteIndex, noteData, noteType, isSustainNote)
   if noteType == 'Phone Note' then
      if animationExists('boyfriend', 'hurt') then
	     playAnim('boyfriend', 'hurt', true);
		 setProperty('boyfriend.holdTimer', 0);
	  else
	     playAnim('boyfriend', 'singRIGHTmiss', true);
		 setProperty('boyfriend.holdTimer', 0);
	  end
	  
	  if animationExists('dad', 'throw') then
	     playAnim('dad', 'throw', true);
		 setProperty('dad.holdTimer', 0);
	  elseif animationExists('dad', 'attack') then
	     playAnim('dad', 'attack', true);
		 setProperty('dad.holdTimer', 0);
	  end
	  setProperty('vocals.volume', 1);
	  setPropertyFromGroup('playerStrums', noteData, 'alpha', 0.01);
	  cancelTween('strum' .. noteDataToStrum[noteData]);
	  noteTweenAlpha('strum' .. noteDataToStrum[noteData], noteDataToStrum[noteData], 1, 7, 'expoIn');
   end
end

function animationExists(char, anim)
   return runHaxeCode([[
     game.]] .. char .. [[.animOffsets.exists(']] .. anim .. [[');
   ]])
end
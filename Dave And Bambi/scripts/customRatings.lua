local imageFile = 'sick';
local aliveRatings = {};

function onCreate()
   setProperty('showRating', false);
   setProperty('showComboNum', false);
end

function goodNoteHit(noteIndex, noteData, noteType, isSustainNote)
   if not leftSide and not isSustainNote then
      if getPropertyFromGroup('notes', noteIndex, 'texture') == '3DNOTE_assets' or getPropertyFromGroup('notes', noteIndex, 'noteType') == 'NOTE_assets_Shape' then
         createPopUp(0, 0, getPropertyFromGroup('notes', noteIndex, 'rating'), getProperty('combo'), '3D/')
	  else
	     createPopUp(0, 0, getPropertyFromGroup('notes', noteIndex, 'rating'), getProperty('combo'), '');
      end
   end
end

function opponentNoteHit(noteIndex, noteData, noteType, isSustainNote)
   if leftSide and not isSustainNote then
      if getPropertyFromGroup('notes', noteIndex, 'texture') == '3DNOTE_assets' or getPropertyFromGroup('notes', noteIndex, 'noteType') == 'NOTE_assets_Shape' then
         createPopUp(0, 0, getPropertyFromGroup('notes', noteIndex, 'rating'), getProperty('combo'), '3D/')
	  else
	     createPopUp(0, 0, getPropertyFromGroup('notes', noteIndex, 'rating'), getProperty('combo'), '');
      end
   end
end

function createPopUp(x, y, rating, combo, style)
   makeLuaText('awesomeText', combo, 0, x, y);
   screenCenter('awesomeText');
   setTextSize('awesomeText', 32);
   setProperty('awesomeText.x', screenWidth * 0.55);
   
   table.insert(aliveRatings, 'rating' .. #aliveRatings); 
   local curRating = rating .. #aliveRatings;
   
   makeLuaSprite(curRating, style .. rating);
   screenCenter(curRating);
   setProperty(curRating .. '.x', getProperty('awesomeText.x') - 40);
   setProperty(curRating .. '.y', getProperty(curRating .. '.y') - 60);
   setProperty(curRating .. '.acceleration.y', 550);
   setProperty(curRating .. '.velocity.y', getProperty(curRating .. '.velocity.y') - getRandomInt(140, 175));
   setProperty(curRating .. '.velocity.x', getProperty(curRating .. '.velocity.x') - getRandomInt(0, 10));
   setGraphicSize(curRating, math.floor(getProperty(curRating .. '.width') * 0.5));
   addLuaSprite(curRating, true);
   
   runTimer(curRating .. 'timer', crochet * 0.001 / getProperty('playbackRate'));
   
   local separatedCombo = {};
   table.insert(separatedCombo, math.floor(combo / 100) % 10);
   table.insert(separatedCombo, math.floor(combo / 10) % 10);
   table.insert(separatedCombo, combo % 10);
   local daLoop = 0;
   for i = 1, #separatedCombo do
      local curCombo = style .. 'num' .. separatedCombo[i];
      makeLuaSprite(curCombo .. #aliveRatings .. i, curCombo);
	  screenCenter(curCombo .. #aliveRatings .. i);
	  setProperty(curCombo .. #aliveRatings .. i .. '.x', getProperty('awesomeText.x') + (43 * daLoop) - 90)
	  setProperty(curCombo .. #aliveRatings .. i .. '.y', getProperty(curCombo .. #aliveRatings .. i .. '.y') + 20);
	  
	  setProperty(curCombo .. #aliveRatings .. i .. '.acceleration.y', getRandomInt(200, 300));
	  setProperty(curCombo .. #aliveRatings .. i .. '.velocity.y', getProperty(curCombo .. #aliveRatings .. i .. '.velocity.y') - getRandomInt(140, 160));
	  setProperty(curCombo .. #aliveRatings .. i .. '.velocity.x', getRandomInt(-5, 5));
	  setGraphicSize(curCombo .. #aliveRatings .. i, math.floor(getProperty(curCombo .. #aliveRatings .. i .. '.width') * 0.5), 0, false);
	  addLuaSprite(curCombo .. #aliveRatings .. i, true);
	  
	  runTimer(curCombo .. #aliveRatings .. i .. 'timer', crochet * 0.002 / getProperty('playbackRate'));
	  daLoop = daLoop + 1;
   end
end

function onTimerCompleted(tag)
   if stringEndsWith(tag, 'timer') then
      doTweenAlpha(string.gsub(tag, 'timer', '') .. 'fade', string.gsub(tag, 'timer', ''), 0, 0.2 / getProperty('playbackRate'));
   end
end

function onTweenCompleted(tag)
   if stringEndsWith(tag, 'fade') then
      removeLuaSprite(string.gsub(tag, 'timer', ''), true);
   end
end
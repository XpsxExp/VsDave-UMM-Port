local expression = '';
local fakeDadCreated = false;
local nightColour = '0xFF878787';
local dadX = 0;
local dadY = 0;
local bambiX = 0;
local bambiY = 0;

function onCreatePost()
   dadX = getProperty('dad.x'); --char positions break for some reason when this event gets triggered
   dadY = getProperty('dad.y');
end

function onEvent(name, value1, value2)
   if name == 'Switch Splitathon Character' and not getProperty('dad.Custom') then
      expression = string.lower(value2);
	  runHaxeCode([[
	    if (fakeDad != null) {
	      fakeDad.destroy();
		}
	  ]])
	  
      if string.lower(value1) == 'dave' then
         runHaxeCode([[
	       fakeDad = new Character(0, 225, 'dave-splitathon', false);
		   fakeDad.playAnim(']] .. expression .. [[', true);
		   fakeDad.color = ]] .. getColorFromHex('0xFF878787') .. [[;
		   game.addBehindDad(fakeDad);
	     ]])
	  elseif string.lower(value1) == 'bambi' then
         runHaxeCode([[
	       fakeDad = new Character(0, 580, 'bambi-splitathon', false);
		   fakeDad.playAnim(']] .. expression .. [[', true);
		   fakeDad.color = ]] .. getColorFromHex('0xFF878787') .. [[;
		   game.add(fakeDad);
	     ]])
	  end 
	  fakeDadCreated = true;
   end
   
   if name == 'Change Character' and not getProperty('dad.Custom') then
      if value2 == 'dave-splitathon' then
	     setProperty('dad.x', dadX); setProperty('dad.y', dadY); --idk
	  elseif value2 == 'bambi-splitathon' then
	     if bambiX == 0 or bambiY == 0 then
            bambiX = getProperty('dad.x');
            bambiY = getProperty('dad.y');
	     else
		    setProperty('dad.x', bambiX);
			setProperty('dad.y', bambiY);
		 end
	  end
   end
end

function onBeatHit()
   if fakeDadCreated and curBeat % getProperty('dad.danceEveryNumBeats') == 0 then
      runHaxeCode([[ 
		fakeDad.playAnim(']] .. expression .. [[', true); 
	  ]]);
   end
end
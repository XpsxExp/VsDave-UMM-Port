local tweensTable = {
   ['x'] = function(tag, var, value, duration, ease)
      doTweenX(tostring(tag), tostring(var), tonumber(value), tonumber(duration), tostring(ease));
   end,
   ['y'] = function(tag, var, value, duration, ease)
      doTweenY(tostring(tag), tostring(var), tonumber(value), tonumber(duration), tostring(ease));
   end,
   ['angle'] = function(tag, var, value, duration, ease)
      doTweenAngle(tostring(tag), tostring(var), tonumber(value), tonumber(duration), tostring(ease));
   end,
   ['alpha'] = function(tag, var, value, duration, ease)
      doTweenAlpha(tostring(tag), tostring(var), tonumber(value), tonumber(duration), tostring(ease));
   end,
   ['zoom'] = function(tag, var, value, duration, ease)
      doTweenZoom(tostring(tag), tostring(var), tonumber(value), tonumber(duration), tostring(ease));
   end,
   ['color'] = function(tag, var, value, duration, ease)
      doTweenColor(tostring(tag), tostring(var), tostring(value), tonumber(duration), tostring(ease));
   end,
   ['number'] = function(tag, var, value, duration, ease)
      runHaxeCode([[
	    FlxTween.num(]] .. var .. [[, ]] .. value .. [[, ]] .. duration .. [[, {}, function(nwVal:Float) {
		   ]] .. var .. [[ = nwVal;
		});
	  ]]);
   end
}

function onEvent(name, value1, value2)
   if name == 'Do Tween' then
      local twnArgs = stringSplit(value2, ',');
	  local twnType = string.lower(value1);
	  tweensTable[twnType](twnArgs[1], twnArgs[2], twnArgs[3], twnArgs[4], twnArgs[5]);
   end
end
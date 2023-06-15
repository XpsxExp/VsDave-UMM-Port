function onEvent(name, value1, value2)
   if name == 'Set Shader Float' then
      local arg1 = value1;
	  local eventstr = value2;
	  
	  local arg2 = eventstr:match("%((%a+)%)");
	  local arg3 = eventstr:match("%[(%a+)%]");
	  local arg4 = eventstr:match("{.*}");
	  
	  setShaderFloat(arg1, arg2, arg3);
   end
end
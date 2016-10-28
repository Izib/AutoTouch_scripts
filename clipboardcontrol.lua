adaptResolution(640, 1136);
adaptOrientation(ORIENTATION_TYPE.PORTRAIT);

-- default debug print true
g_debug = 1;


function dprint(data)
  if g_debug == 1 then
    log(data);
  end
end

function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function text(data)
  dprint(string.format("text: %s", data));
  inputText(data);
end

function click(data)
  dprint(string.format("click: %s", data));
  x,y = string.match(data, "(.+),(.+)");
  if nil == x or nil == y or nil == string.match(trim(x),"^%d+%.*%d*$") or nil == string.match(trim(y),"^%d+%.*%d*$") then
    alert(string.format("Wrong input:%s", data));    
    return;
  end

  x = tonumber(x);
  y = tonumber(y);
  touchDown(0, x, y);
  usleep(83215.88);
  touchUp(0, x, y);
end

function run(data)
  dprint(string.format("run: %s", data));
  appRun(data);
end

function kill(data)
  dprint(string.format("kill: %s", data));
  appKill(data);
end

function debug(data)
  dprint(string.format("debug: %s", data));
  g_debug = 1;
end


dprint("clipboardcontrol.lua started");

while true do
  cb = clipText();  
  if cb ~= nil then
    cmd,data = string.match(cb, "(.+):(.+)")
    if cmd == "---text" then
      text(data);
      copyText("---");
    elseif cmd == "---click" then
      click(data);
      copyText("---");
    elseif cmd == "---run" then
      run(data);
      copyText("---");
    elseif cmd == "---kill" then
      kill(data);
      copyText("---");
    elseif cmd == "---debug" then
      debug(data);
      copyText("---");      
    end
  end
  usleep(1000000);
end




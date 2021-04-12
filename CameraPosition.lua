--Made by Xeavin
local scriptState = false
local cameraOffsets = {0x020984C0, 0x020984C4, 0x020984C8}
local cameraCoordinates = {"0.0", "0.0", "0.0"}

local function showPosition()
  if(scriptState) then
    for i = 1, #cameraOffsets do
      cameraCoordinates[i] = string.format("%09.5f", memory.float[cameraOffsets[i]])
    end

    local text = message.convert("{instant}X: " .. cameraCoordinates[1] .. "\nY: " .. cameraCoordinates[2] .. "\nZ: " .. cameraCoordinates[3])
    message.print(text)
  end
  event.executeAfterMs(100, showPosition)
end

local function checkKeys()
  if (input.getKeyPressed(input.key.KEY_RCONTROL) and input.getKeyPressed(input.key.KEY_END)) then
    scriptState = not scriptState
  end
  event.executeAfterMs(150, checkKeys)
end

local function onExit()
  collectgarbage()
end

print("Camera Position (CP): Applying patch.")
event.registerEventAsync("onInitDone", checkKeys)
event.registerEventAsync("onInitDone", showPosition)
event.registerEventAsync("exit", onExit)

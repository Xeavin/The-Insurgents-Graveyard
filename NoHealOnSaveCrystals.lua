--Made by Xeavin
local codePointer = 0x00356500
local originalBytes = {0x48, 0x83, 0xEC, 0x28}
local code =
[[
  ret
  nop 0x03
]]

print("No Heal On Save Crystals (NHOSC): Applying patch.")
local readBytes = memory.readArray(codePointer, #originalBytes)
if (#readBytes ~= #originalBytes) then
  print("NHOSC: Couldn't read from memory.")
  return
elseif (table.concat(readBytes) ~= table.concat(originalBytes)) then
  print("NHOSC: Unexpected values, aborting.")
  return
end

if not (memory.assemble(code, codePointer)) then
  print("NHOSC: Couldn't write to memory.")
  return
end

local function onExit()
  collectgarbage()
end

event.registerEventAsync("exit", onExit)

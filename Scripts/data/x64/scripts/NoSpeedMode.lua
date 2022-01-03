--Made by Xeavin
local codePointer = 0x0022AA3A
local originalBytes = {0x85, 0xC0}
local code =
[[
  cmp eax,eax
]]

print("No Speed-Mode (NSM): Applying patch.")
local readBytes = memory.readArray(codePointer, #originalBytes)
if (#readBytes ~= #originalBytes) then
  print("NSM: Couldn't read from memory.")
  return
elseif (table.concat(readBytes) ~= table.concat(originalBytes)) then
  print("NSM: Unexpected values, aborting.")
  return
end

if not (memory.assemble(code, codePointer)) then
  print("NSM: Couldn't write to memory.")
  return
end

local function onExit()
  collectgarbage()
end

event.registerEventAsync("exit", onExit)

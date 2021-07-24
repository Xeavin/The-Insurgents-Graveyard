--Made by Xeavin
local codePointer = 0x0022AD02
local originalBytes = {0xE8, 0x49, 0xD8, 0x12, 0x00}
local code =
[[
  xor eax,eax
  nop 0x03
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

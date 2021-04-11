--Made by Xeavin
local codePointer = 0x00253E2F
local originalBytes = {0x80, 0x3D, 0x1A, 0xE9, 0xE3, 0x01, 0x03}
local code =
[[
  cmp eax,eax
  nop 0x05
]]

print("No Overlay Map (NOM): Applying patch.")
local readBytes = memory.readArray(codePointer, #originalBytes)
if (#readBytes ~= #originalBytes) then
  print("NOM: Couldn't read from memory.")
  return
elseif (table.concat(readBytes) ~= table.concat(originalBytes)) then
  print("NOM: Unexpected values, aborting.")
  return
end

if not (memory.assemble(code, codePointer)) then
  print("NOM: Couldn't write to memory.")
  return
end

local function onExit()
  collectgarbage()
end

event.registerEventAsync("exit", onExit)

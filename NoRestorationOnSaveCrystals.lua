--Made by Xeavin
local codePointer = 0x00359C8F
local originalBytes = {0xB8, 0x07, 0x00, 0x00, 0x00}
local code =
[[
  xor eax,eax
  nop 0x03
]]

print("No Restoration On Save Crystals (NROSC): Applying patch.")
local readBytes = memory.readArray(codePointer, #originalBytes)
if (#readBytes ~= #originalBytes) then
  print("NROSC: Couldn't read from memory.")
  return
elseif (table.concat(readBytes) ~= table.concat(originalBytes)) then
  print("NROSC: Unexpected values, aborting.")
  return
end

if not (memory.assemble(code, codePointer)) then
  print("NROSC: Couldn't write to memory.")
  return
end

local function onExit()
  collectgarbage()
end

event.registerEventAsync("exit", onExit)

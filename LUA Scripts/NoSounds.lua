--Made by Xeavin
local codePointer = 0x007E0E7C
local originalBytes = {0xF3, 0x44, 0x0F, 0x10, 0xA3, 0x00, 0x01, 0x00, 0x00}
local code =
[[
  xorps xmm12,xmm12
  nop 0x05
]]

print("No Sounds (NS): Applying patch.")
local readBytes = memory.readArray(codePointer, #originalBytes)
if (#readBytes ~= #originalBytes) then
  print("NS: Couldn't read from memory.")
  return
elseif (table.concat(readBytes) ~= table.concat(originalBytes)) then
  print("NS: Unexpected values, aborting.")
  return
end

if not (memory.assemble(code, codePointer)) then
  print("NS: Couldn't write to memory.")
  return
end

local function onExit()
  collectgarbage()
end
event.registerEventAsync("exit", onExit)

--Made by Xeavin
local codePointer = 0x002AEC1F
local originalBytes = {0x83, 0xF8, 0x02}
local code =
[[
  cmp eax,eax
  nop
]]

print("Forced PS Button Prompts (FPSBP): Applying patch.")
local readBytes = memory.readArray(codePointer, #originalBytes)
if (#readBytes ~= #originalBytes) then
  print("FPSBP: Couldn't read from memory.")
  return
elseif (table.concat(readBytes) ~= table.concat(originalBytes)) then
  print("FPSBP: Unexpected values, aborting.")
  return
end

if not (memory.assemble(code, codePointer)) then
  print("FPSBP: Couldn't write to memory.")
  return
end

local function onExit()
  collectgarbage()
end

event.registerEventAsync("exit", onExit)

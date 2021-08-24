--Made by Xeavin
local codePointer = 0x00197780
local originalBytes = {0x0F, 0xB6, 0x41, 0x38}
local code =
[[
  xor eax,eax
  nop 0x02
]]

print("Forced Keyboard Button Prompts (FKBP): Applying patch.")
local readBytes = memory.readArray(codePointer, #originalBytes)
if (#readBytes ~= #originalBytes) then
  print("FKBP: Couldn't read from memory.")
  return
elseif (table.concat(readBytes) ~= table.concat(originalBytes)) then
  print("FKBP: Unexpected values, aborting.")
  return
end

if not (memory.assemble(code, codePointer)) then
  print("FKBP: Couldn't write to memory.")
  return
end

local function onExit()
  collectgarbage()
end
event.registerEventAsync("exit", onExit)

--Made by Xeavin
local codePointer = 0x00323E33
local originalBytes = {0x85, 0xC0}
local code =
[[
  cmp eax,eax
]]

print("Summons For All (SFA): Applying patch.")
local readBytes = memory.readArray(codePointer, #originalBytes)
if (#readBytes ~= #originalBytes) then
  print("SFA: Couldn't read from memory.")
  return
elseif (table.concat(readBytes) ~= table.concat(originalBytes)) then
  print("SFA: Unexpected values, aborting.")
  return
end

if not (memory.assemble(code, codePointer)) then
  print("SFA: Couldn't write to memory.")
  return
end

local function onExit()
  collectgarbage()
end
event.registerEventAsync("exit", onExit)

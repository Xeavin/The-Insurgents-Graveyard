--Made by Xeavin
local codePointer = 0x0032A866
local originalBytes = {0xE8, 0x45, 0xF7, 0xFD, 0xFF}
local code =
[[
  jmp %ntr_code%
]]

memory.assemble(
[[
ntr_code:
  cmp ecx,0x00002000
  jne short ntr_oc

  mov eax,0x00000063
  jmp short ntr_return

ntr_oc:
  call 0x00309FB0

ntr_return:
  jmp 0x0032A86B

]], {"ntr_code"})

print("No Teleport Requirement (NTR): Applying patch.")
local readBytes = memory.readArray(codePointer, #originalBytes)
if (#readBytes ~= #originalBytes) then
  print("NTR: Couldn't read from memory.")
  return
elseif (table.concat(readBytes) ~= table.concat(originalBytes)) then
  print("NTR: Unexpected values, aborting.")
  return
end

if not (memory.assemble(code, codePointer)) then
  print("NTR: Couldn't write to memory.")
  return
end

local function onExit()
  memory.unregisterAllSymbols()
  collectgarbage()
end

event.registerEventAsync("exit", onExit)

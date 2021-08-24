--Made by Xeavin
local codePointer = 0x0032A860
local originalBytes = {0x48, 0x83, 0xEC, 0x28, 0x33, 0xD2}
local code =
[[
  jmp %ntr_code%
  nop
]]

local ntr_newmem = memory.assemble(
[[
ntr_code:
  cmp ecx,0x00002000
  jne short ntr_originalcode
  mov eax,0x00000063
  ret

ntr_originalcode:
  sub rsp,0x28
  xor edx,edx

  jmp 0x0032A866

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

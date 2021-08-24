--Made by Xeavin
local codePointer = 0x002F9563
local originalBytes = {0x66, 0x0F, 0x6E, 0x30, 0x0F, 0x5B, 0xF6}
local code =
[[
  jmp %fmpr_code%
  nop 0x02
]]

local fmpr_newmem = memory.assemble(
[[
fmpr_code:
  movd xmm6,[rax]
  cvtdq2ps xmm6,xmm6

  mulss xmm6,[0x02064AC4]
  jmp 0x002F956A

]], {"fmpr_code"})

print("Fixed MP Regeneration (FMPR): Applying patch.")
local readBytes = memory.readArray(codePointer, #originalBytes)
if (#readBytes ~= #originalBytes) then
  print("FMPR: Couldn't read from memory.")
  return
elseif (table.concat(readBytes) ~= table.concat(originalBytes)) then
  print("FMPR: Unexpected values, aborting.")
  return
end

if not (memory.assemble(code, codePointer)) then
  print("FMPR: Couldn't write to memory.")
  return
end

local function onExit()
  memory.unregisterAllSymbols()
  collectgarbage()
end
event.registerEventAsync("exit", onExit)

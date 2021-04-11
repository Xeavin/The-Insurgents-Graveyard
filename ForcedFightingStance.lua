--Made by Xeavin
local codePointer = 0x00307F07
local originalBytes = {0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4B, 0x8B, 0x04, 0xC7, 0xF7, 0x40, 0x04, 0x00, 0x00, 0x01, 0x00, 0x74, 0x15, 0x48, 0x8B, 0x80, 0x98, 0x06, 0x00, 0x00}
local code =
[[
  mov edi,edx
  call 0x00377700
  mov edx,edi

  test eax,eax
  je short 0x00307F45
  jmp short 0x00307F3C
  nop 0x05
]]

print("Forced Fighting Stance (FFS): Applying patch.")
local readBytes = memory.readArray(codePointer, #originalBytes)
if (#readBytes ~= #originalBytes) then
  print("FFS: Couldn't read from memory.")
  return
elseif (table.concat(readBytes) ~= table.concat(originalBytes)) then
  print("FFS: Unexpected values, aborting.")
  return
end

if not (memory.assemble(code, codePointer)) then
  print("FFS: Couldn't write to memory.")
  return
end

local function onExit()
  collectgarbage()
end

event.registerEventAsync("exit", onExit)

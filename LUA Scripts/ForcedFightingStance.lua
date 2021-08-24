--Made by Xeavin
local codePointer = 0x00307F07
local originalBytes = {0x66, 0x0F, 0x1F, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00}
local code =
[[
  jmp %ffs_code%
]]

local ffs_newmem = memory.assemble(
[[
ffs_code:
  mov edi,edx
  call 0x00377700
  mov edx,edi

  test eax,eax
  je 0x00307F45
  jmp 0x00307F3C

]], {"ffs_code"})

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

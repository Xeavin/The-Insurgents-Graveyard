--Made by Xeavin
local codePointer = 0x003904A9
local originalBytes = {0x0F, 0x84, 0xF0, 0x00, 0x00, 0x00}
local code =
[[
  jmp %ase_code%
  nop
]]

local ase_newmem = memory.assemble(
[[
ase_code:
  lea rcx,[0x02AEE04C]
  mov eax,0x00000001

  cmp [rdi+0x32],bp
  je short ase_uncommon
  mov [rcx],al

ase_uncommon:
  cmp [rdi+0x34],bp
  je short ase_rare
  mov [rcx+0x01],al

ase_rare:
  cmp [rdi+0x36],bp
  je short ase_return
  mov [rcx+0x02],al

ase_return:
  jmp 0x0039058A

]], {"ase_code"})

print("Always Steal Everything (ASE): Applying patch.")
local readBytes = memory.readArray(codePointer, #originalBytes)
if (#readBytes ~= #originalBytes) then
  print("ASE: Couldn't read from memory.")
  return
elseif (table.concat(readBytes) ~= table.concat(originalBytes)) then
  print("ASE: Unexpected values, aborting.")
  return
end

if not (memory.assemble(code, codePointer)) then
  print("ASE: Couldn't write to memory.")
  return
end

local function onExit()
  memory.unregisterAllSymbols()
  collectgarbage()
end
event.registerEventAsync("exit", onExit)

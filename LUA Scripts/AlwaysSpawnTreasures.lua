--Made by Xeavin
local codePointer = 0x00354454
local originalBytes = {0xE8, 0x57, 0x38, 0xF1, 0xFF}
local code =
[[
  call %ast_code%
]]

local ast_newmem = memory.assemble(
[[
ast_code:
  sub rsp,0x18

  mov r9d,0x00000001
  movzx r8d,byte ptr [rcx]
  mov edx,[0x021654C4]
  lea rcx,[0x02EC3E60]
  call 0x002FB430
  mov eax,0x00000001

  add rsp,0x18
  ret

]], {"ast_code"})

print("Always Spawn Treasures (AST): Applying patch.")
local readBytes = memory.readArray(codePointer, #originalBytes)
if (#readBytes ~= #originalBytes) then
  print("AST: Couldn't read from memory.")
  return
elseif (table.concat(readBytes) ~= table.concat(originalBytes)) then
  print("AST: Unexpected values, aborting.")
  return
end

if not (memory.assemble(code, codePointer)) then
  print("AST: Couldn't write to memory.")
  return
end

local function onExit()
  memory.unregisterAllSymbols()
  collectgarbage()
end
event.registerEventAsync("exit", onExit)

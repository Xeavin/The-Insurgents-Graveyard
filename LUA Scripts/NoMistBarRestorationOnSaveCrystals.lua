--Made by Xeavin
local codePointer = 0x0030F483
local originalBytes = {0xE8, 0x18, 0x01, 0x00, 0x00}
local code =
[[
  jmp %nmbrosc_code%
]]

local nmbrosc_newmem = memory.assemble(
[[
nmbrosc_code:
  test rdi,rdi
  je short nmbrosc_return

  push rbx
  push rsi
  movzx ebx,word ptr [rdi+0x06]
  movzx esi,byte ptr [rdi+0x4E]
  sub rsp,0x18
  call 0x0030F5A0
  add rsp,0x18
  mov [rdi+0x4E],sil
  mov [rdi+0x06],bx
  pop rsi
  pop rbx

nmbrosc_return:
  jmp 0x0030F488

]], {"nmbrosc_code"})

print("No Mist Bar Restoration On Save Crystals (NMBROSC): Applying patch.")
local readBytes = memory.readArray(codePointer, #originalBytes)
if (#readBytes ~= #originalBytes) then
  print("NMBROSC: Couldn't read from memory.")
  return
elseif (table.concat(readBytes) ~= table.concat(originalBytes)) then
  print("NMBROSC: Unexpected values, aborting.")
  return
end

if not (memory.assemble(code, codePointer)) then
  print("NMBROSC: Couldn't write to memory.")
  return
end

local function onExit()
  memory.unregisterAllSymbols()
  collectgarbage()
end
event.registerEventAsync("exit", onExit)

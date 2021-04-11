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
  je short nmbrotc_ret

  push rbx
  push rsi
  movzx ebx,word ptr [rdi+0x06]
  movzx esi,byte ptr [rdi+0x4E]
  sub rsp,0x18
  call 0x0030F5A0
  add rsp,0x18
  mov byte ptr [rdi+0x4E],sil
  mov word ptr [rdi+0x06],bx
  pop rsi
  pop rbx

nmbrotc_ret:
  jmp 0x0030F488

]], {"nmbrosc_code"})

print("No Mist Bar Restore On Save Crystals (NMBROSC): Applying patch.")
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

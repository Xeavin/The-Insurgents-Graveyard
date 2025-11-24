--Made by Xeavin
local codePointer = 0x0030F483
local originalBytes = {0xE8, 0x18, 0x01, 0x00, 0x00}
local code =
[[
  jmp %nmbrosc_code%
]]

local assemblies =
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
]]

local symbols = {
  "nmbrosc_code"
}

local function applyPatch()
  local readBytes = memory.readArray(codePointer, #originalBytes)
  if table.concat(readBytes) ~= table.concat(originalBytes) then
    print("NMBROSC: Couldn't apply patch, executable is unexpectedly modified.")
    return
  end

  memory.assemble(assemblies, symbols)
  memory.assemble(code, codePointer)
end

print("No Mist Bar Restoration On Save Crystals (NMBROSC): Applying patch.")
local minVer = {1, 7, 1}
if not (checkMinVersion and checkMinVersion(minVer[1], minVer[2], minVer[3])) then
  print("NMBROSC: Couldn't apply patch, LUA Loader v" .. minVer[1] .. "." .. minVer[2] .. "." .. minVer[3] .. " or higher required.")
  return
end

applyPatch()

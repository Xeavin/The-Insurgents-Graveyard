--Made by Xeavin
local codePointer = 0x0030F483
local originalBytes = {0xE8, 0x18, 0x01, 0x00, 0x00}
local code =
[[
  call %nmbrosc_code%
]]

local assemblies =
[[
nmbrosc_code:
  push rbx
  push rdi
  push rsi
  sub rsp,0x20

  test rcx,rcx
  je short nmbrosc_return

  mov rdi,rcx
  movzx ebx,word ptr [rdi+0x06]
  movzx esi,byte ptr [rdi+0x4E]

  call 0x0030F5A0

  mov [rdi+0x4E],sil
  mov [rdi+0x06],bx

nmbrosc_return:
  add rsp,0x20
  pop rsi
  pop rdi
  pop rbx
  ret
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

--Made by Xeavin
local patches = {
  {
    target = 0x0030F483,
    originalBytes = {0xE8, 0x18, 0x01, 0x00, 0x00},
    patchCode = [[
      call %nmbrosc_code%
    ]],
    blockCode = [[
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
    ]],
    symbols = {"nmbrosc_code"}
  }
}

local function checkOriginalBytes(target, originalBytes)
  local currentBytes = memory.readArray(target, #originalBytes)
  for i = 1, #originalBytes do
    if currentBytes[i] ~= originalBytes[i] then
      return false
    end
  end

  return true
end

local function applyPatch()
  for _, entry in ipairs(patches) do
    if entry.target and entry.originalBytes and
       not checkOriginalBytes(entry.target, entry.originalBytes) then
      print("NMBROSC: Couldn't apply patch, executable is unexpectedly modified.")
      return
    end
  end

  for _, entry in ipairs(patches) do
    if entry.blockCode and entry.symbols then
      memory.assemble(entry.blockCode, entry.symbols)
    end

    if entry.target and entry.patchCode then
      memory.assemble(entry.patchCode, entry.target)
    end
  end
end

print("No Mist Bar Restoration On Save Crystals (NMBROSC): Applying patch.")
local minVer = {1, 7, 2}
if not (checkMinVersion and checkMinVersion(minVer[1], minVer[2], minVer[3])) then
  print("NMBROSC: Couldn't apply patch, LUA Loader v" .. minVer[1] .. "." .. minVer[2] .. "." .. minVer[3] .. " or higher required.")
  return
end

applyPatch()

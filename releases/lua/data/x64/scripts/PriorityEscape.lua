--Made by Xeavin
local patches = {
  {
    target = 0x00305B66,
    originalBytes = {0x48, 0x8B, 0x83, 0x98, 0x06, 0x00, 0x00},
    patchCode = [[
      jmp %pe_code%
      nop 0x02
    ]],
    blockCode = [[
    pe_code:
      mov rax,[rbx+0x00000698]
      xor ecx,ecx

      cmp byte ptr [rax+0x05],cl
      jne short pe_return

      cmp [0x01E0C2B8],ecx
      je 0x00305C61

    pe_return:
      jmp 0x00305B6D
    ]],
    symbols = {"pe_code"}
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
      print("PE: Couldn't apply patch, executable is unexpectedly modified.")
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

print("Priority Escape (PE): Applying patch.")
local minVer = {2, 0, 1}
if not (checkMinVersion and checkMinVersion(minVer[1], minVer[2], minVer[3])) then
  print("PE: Couldn't apply patch, LUA Loader v" .. minVer[1] .. "." .. minVer[2] .. "." .. minVer[3] .. " or higher required.")
  return
end

applyPatch()

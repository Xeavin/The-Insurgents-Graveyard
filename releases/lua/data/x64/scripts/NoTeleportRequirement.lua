--Made by Xeavin
local patches = {
  {
    target = 0x0032A866,
    originalBytes = {0xE8, 0x45, 0xF7, 0xFD, 0xFF},
    patchCode = [[
      jmp %ntr_code%
    ]],
    blockCode = [[
    ntr_code:
      cmp ecx,0x00002000
      jne short ntr_oc

      mov eax,0x00000063
      jmp short ntr_return

    ntr_oc:
      call 0x00309FB0

    ntr_return:
      jmp 0x0032A86B
    ]],
    symbols = {"ntr_code"}
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
      print("NTR: Couldn't apply patch, executable is unexpectedly modified.")
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

print("No Teleport Requirement (NTR): Applying patch.")
local minVer = {2, 0, 1}
if not (checkMinVersion and checkMinVersion(minVer[1], minVer[2], minVer[3])) then
  print("NTR: Couldn't apply patch, LUA Loader v" .. minVer[1] .. "." .. minVer[2] .. "." .. minVer[3] .. " or higher required.")
  return
end

applyPatch()

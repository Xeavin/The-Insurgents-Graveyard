--Made by Xeavin
local patches = {
  {
    target = 0x002C60DA,
    originalBytes = {0x8B, 0x05, 0x34, 0x6E, 0xB4, 0x01, 0x2B, 0x05, 0x1E, 0x6E, 0xB4, 0x01},
    patchCode = [[
      xor eax,eax
      nop 0x0A
    ]]
  },
  {
    target = 0x002C610C,
    originalBytes = {0x03, 0x15, 0xF2, 0x6D, 0xB4, 0x01},
    patchCode = [[
      nop 0x06
    ]]
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
      print("NOPHPB: Couldn't apply patch, executable is unexpectedly modified.")
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

print("No Overhead Party HP Bars (NOPHPB): Applying patch.")
local minVer = {1, 7, 2}
if not (checkMinVersion and checkMinVersion(minVer[1], minVer[2], minVer[3])) then
  print("NOPHPB: Couldn't apply patch, LUA Loader v" .. minVer[1] .. "." .. minVer[2] .. "." .. minVer[3] .. " or higher required.")
  return
end

applyPatch()

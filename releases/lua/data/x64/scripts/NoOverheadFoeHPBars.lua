--Made by Xeavin
local patches = {
  {
    target = 0x002C5FB6,
    originalBytes = {0x8B, 0x05, 0x78, 0x6F, 0xB4, 0x01, 0x2B, 0x05, 0x62, 0x6F, 0xB4, 0x01},
    patchCode = [[
      xor eax,eax
      nop 0x0A
    ]]
  },
  {
    target = 0x002C5FE8,
    originalBytes = {0x03, 0x15, 0x36, 0x6F, 0xB4, 0x01},
    patchCode = [[
      nop 0x06
    ]]
  },
  {
    target = 0x002C6048,
    originalBytes = {0x8B, 0x05, 0xA6, 0x6E, 0xB4, 0x01, 0x2B, 0x05, 0x90, 0x6E, 0xB4, 0x01},
    patchCode = [[
      xor eax,eax
      nop 0x0A
    ]]
  },
  {
    target = 0x002C607A,
    originalBytes = {0x03, 0x15, 0x64, 0x6E, 0xB4, 0x01},
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
      print("NOFHPB: Couldn't apply patch, executable is unexpectedly modified.")
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

print("No Overhead Foe HP Bars (NOFHPB): Applying patch.")
local minVer = {1, 7, 2}
if not (checkMinVersion and checkMinVersion(minVer[1], minVer[2], minVer[3])) then
  print("NOFHPB: Couldn't apply patch, LUA Loader v" .. minVer[1] .. "." .. minVer[2] .. "." .. minVer[3] .. " or higher required.")
  return
end

applyPatch()

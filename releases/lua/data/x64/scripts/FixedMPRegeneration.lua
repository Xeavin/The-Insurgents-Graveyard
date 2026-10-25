--Made by Xeavin
local patches = {
  {
    target = 0x002F9563,
    originalBytes = {0x66, 0x0F, 0x6E, 0x30, 0x0F, 0x5B, 0xF6},
    patchCode = [[
      jmp %fmpr_code%
      nop 0x02
    ]],
    blockCode = [[
    fmpr_code:
      movd xmm6,[rax]
      cvtdq2ps xmm6,xmm6

      mulss xmm6,[0x02064AC4]
      jmp 0x002F956A
    ]],
    symbols = {"fmpr_code"}
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
      print("FMPR: Couldn't apply patch, executable is unexpectedly modified.")
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

print("Fixed MP Regeneration (FMPR): Applying patch.")
local minVer = {2, 0, 1}
if not (checkMinVersion and checkMinVersion(minVer[1], minVer[2], minVer[3])) then
  print("FMPR: Couldn't apply patch, LUA Loader v" .. minVer[1] .. "." .. minVer[2] .. "." .. minVer[3] .. " or higher required.")
  return
end

applyPatch()

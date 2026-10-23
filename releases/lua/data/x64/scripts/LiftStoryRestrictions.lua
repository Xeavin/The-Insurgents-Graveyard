--Made by Xeavin
local patches = {
  {
    blockCode = [[
    lsr_fgl:
      .dd 0x08

      .dd 0x04
      .dd 0x06
      .dd 0x07
      .dd 0x08
      .dd 0x09
      .dd 0x0B
      .dd 0x10
      .dd 0x11
    ]],
    symbols = {"lsr_fgl"}
  },
  {
    target = 0x00253DD6,
    originalBytes = {0x66, 0x83, 0xF8, 0x10},
    patchCode = [[
      cmp eax,eax
      nop 0x02
    ]]
  },
  {
    target = 0x0032A8BB,
    originalBytes = {0xE9, 0xB0, 0xD0, 0x04, 0x00},
    patchCode = [[
      jmp %lsr2_code%
    ]],
    blockCode = [[
    lsr2_code:
      lea r8,[%lsr_fgl%]

      mov eax,[r8]
      test eax,eax
      je short lsr2_check

    lsr2_loop:
      cmp ecx,[r8+rax*4]
      je short lsr2_ignore

      dec eax
      jne short lsr2_loop

    lsr2_check:
      jmp 0x00377970

    lsr2_ignore:
      mov eax,0x00000001
      ret
    ]],
    symbols = {"lsr2_code"}
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
      print("LSR: Couldn't apply patch, executable is unexpectedly modified.")
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

print("Lift Story Restrictions (LSR): Applying patch.")
local minVer = {1, 7, 2}
if not (checkMinVersion and checkMinVersion(minVer[1], minVer[2], minVer[3])) then
  print("LSR: Couldn't apply patch, LUA Loader v" .. minVer[1] .. "." .. minVer[2] .. "." .. minVer[3] .. " or higher required.")
  return
end

applyPatch()

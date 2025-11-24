--Made by Xeavin
local codePointer = 0x0032A866
local originalBytes = {0xE8, 0x45, 0xF7, 0xFD, 0xFF}
local code =
[[
  jmp %ntr_code%
]]

local assemblies =
[[
ntr_code:
  cmp ecx,0x00002000
  jne short ntr_oc

  mov eax,0x00000063
  jmp short ntr_return

ntr_oc:
  call 0x00309FB0

ntr_return:
  jmp 0x0032A86B
]]

local symbols = {
  "ntr_code"
}

local function applyPatch()
  local readBytes = memory.readArray(codePointer, #originalBytes)
  if table.concat(readBytes) ~= table.concat(originalBytes) then
    print("NTR: Couldn't apply patch, executable is unexpectedly modified.")
    return
  end

  memory.assemble(assemblies, symbols)
  memory.assemble(code, codePointer)
end

print("No Teleport Requirement (NTR): Applying patch.")
local minVer = {1, 7, 1}
if not (checkMinVersion and checkMinVersion(minVer[1], minVer[2], minVer[3])) then
  print("NTR: Couldn't apply patch, LUA Loader v" .. minVer[1] .. "." .. minVer[2] .. "." .. minVer[3] .. " or higher required.")
  return
end

applyPatch()

--Made by Xeavin
local codePointers = {
0x00253DD6,
0x0032A8BB}

local originalBytes = {
{0x66, 0x83, 0xF8, 0x10},
{0xE9, 0xB0, 0xD0, 0x04, 0x00}}

local codes = {
[[
  cmp eax,eax
  nop 0x02
]],
[[
  jmp %lsr2_code%
]]}

local assemblies =
[[
lsr2_code:
  lea r8,[lsr_fgl]

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


  .align 0x10
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
]]

local symbols = {
  "lsr2_code"
}

local function applyPatch()
  for i = 1, #codePointers do
    local readBytes = memory.readArray(codePointers[i], #originalBytes[i])
    if table.concat(readBytes) ~= table.concat(originalBytes[i]) then
      print("LSR: Couldn't apply patch, executable is unexpectedly modified.")
      return
    end
  end

  memory.assemble(assemblies, symbols)
  for i = 1, #codePointers do
    memory.assemble(codes[i], codePointers[i])
  end
end

print("Lift Story Restrictions (LSR): Applying patch.")
local minVer = {1, 7, 1}
if not (checkMinVersion and checkMinVersion(minVer[1], minVer[2], minVer[3])) then
  print("LSR: Couldn't apply patch, LUA Loader v" .. minVer[1] .. "." .. minVer[2] .. "." .. minVer[3] .. " or higher required.")
  return
end

applyPatch()

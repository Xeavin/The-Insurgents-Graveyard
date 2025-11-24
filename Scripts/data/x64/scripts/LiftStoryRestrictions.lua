--Made by Xeavin
local codePointers = {
0x00281B85,
0x00281BB8,
0x00281BDC,
0x00281C00,
0x00281C2D,
0x00281C69,
0x00253DD6,
0x002540B4}

local originalBytes = {
{0x85, 0xC9},
{0x85, 0xC9},
{0x85, 0xC9},
{0x85, 0xC9},
{0x85, 0xD2},
{0x85, 0xD2},
{0x66, 0x83, 0xF8, 0x10},
{0x85, 0xC0}}

local codes = {
[[
  test esp,esp
]],
[[
  test esp,esp
]],
[[
  test esp,esp
]],
[[
  test esp,esp
]],
[[
  test esp,esp
]],
[[
  test esp,esp
]],
[[
  cmp eax,eax
  nop 0x02
]],
[[
  test esp,esp
]]}

local function applyPatch()
  for i = 1, #codePointers do
    local readBytes = memory.readArray(codePointers[i], #originalBytes[i])
    if table.concat(readBytes) ~= table.concat(originalBytes[i]) then
      print("LSR: Couldn't apply patch, executable is unexpectedly modified.")
      return
    end
  end

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

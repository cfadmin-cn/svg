# svg
svg+xml graphics library implemented using Lua.

## Usage

```lua
-- SVG 根节点
local root = require "svg.root"
-- SVG 基本元素
local  element = require "svg.element"

-- 线段
local l = element:new("line")
do
  l:set("x1", 0)
  l:set("y1", 0)
  l:set("x2", 100)
  l:set("y2", 100)
  l:set("style", { {"stroke", "blue"}, {"stroke-width", 5} })
end

-- 矩形
local r = element:new("rect")
do
  r:set("x", 300)
  r:set("y", 20)
  r:set("width", 100)
  r:set("height", 100)
  r:set("stroke", "green")
  r:set("stroke-width", "2")
end

-- 圆形
local c = element:new("circle")
do
  c:set("cx", 200)
  c:set("cy", 60)
  c:set("r",  50)

  c:set("fill",  "red")
  c:set("style", { {"stroke", "block"}, {"stroke-width", 2} })
end

local svg = root:new()
do
  svg:add(c)
  svg:add(r)
  svg:add(l)
  print(svg:tostring())
end
```

output:

```bash
<svg>
  <circle cx="200" cy="60" r="50" fill="red" style="stroke:block;stroke-width:2" />
  <rect x="300" y="20" width="100" height="100" stroke="green" stroke-width="2" />
  <line x1="0" y1="0" x2="100" y2="100" style="stroke:blue;stroke-width:5" />
</svg>
```

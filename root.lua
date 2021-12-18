local class = require "class"

local type, ipairs, assert = type, ipairs, assert

local Root = class("Root")

function Root:ctor(...)
  self.name = "svg"
  self.nodes = {}
  self.attrs = {}
  if self.init then
    self:init(...)
  end
end

---comment 添加子节点
---@param node table @子节点对象
function Root:add(node)
  assert(getmetatable(node) ~= Root, "Can not add SVG Root.")
  self.nodes[#self.nodes+1] = assert(type(node) == 'table' and node, "Invalide SVG Node.")
end

---comment 设置节点属性
---@param key string                @属性值
---@param value string|number|table @属性名
function Root:set(key, value)
  if type(value) == 'table' then
    local list = {}
    for _, item in ipairs(value) do
      list[#list+1] = table.concat(item, ":")
    end
    value = table.concat(list, ";")
  end
  self.attrs[#self.attrs+1] = assert(type(key) == 'string' and value and {key, value}, "Invalid SVG Attr." )
end

---comment 序列化属性与子节点
function Root:topack(n)
  local attrs = {}
  for _, obj in ipairs(self.attrs) do
    attrs[#attrs+1] = string.format(' %s="%s"', obj[1], obj[2])
  end
  local nodes = {}
  for index, node in ipairs(self.nodes) do
    nodes[index] = ' ' .. node:tostring(n + 2)
  end
  if self.val and #nodes == 0 then
    nodes[1] = ""
  end
  return nodes, attrs
end

---comment 转换为XML格式的SVG内容
---@return string
function Root:tostring(n)
  local tree, attrs = self:topack(n or 0)
  local fmt = #tree == 0 and ((self.name == "svg" and "" or '\n') .. (" "):rep(n or 0) .. '<%s%s />') or ((self.name == "svg" and "" or '\n') .. (" "):rep(n or 0) .. '<%s%s>%s\n'.. (" "):rep(n or 0) .. '</%s>')
  return string.format(fmt, self.name, table.concat(attrs), table.concat(tree, " ") .. (self.val or ""), self.name)
end

---comment 保存到文件
---@param filename string @文件名
function Root:save(filename)
  local data = self:tostring(0)
  local f = assert(io.open(filename, "w+"))
  f:write(data)
  f:flush()
  f:close()
end

return Root

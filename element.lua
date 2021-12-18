local class = require "class"
local Root = require "svg.root"

local Element = class("Element", Root)

function Element:init(name)
  self.head = ""
  self.name = assert(name, "Invalid element name.")
end

function Root:text(text)
  self.val = assert(type(text) == 'string' and text, "Invalid SVG text.")
end

return Element

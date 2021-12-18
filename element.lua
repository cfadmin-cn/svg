local class = require "class"
local Root = require "svg.root"

local Element = class("Element", Root)

function Element:init(name)
  self.name = assert(name and name ~= "svg" and name, "Invalid element name.")
end

function Element:text(text)
  self.val = assert(type(text) == 'string' and text, "Invalid element text.")
end

return Element

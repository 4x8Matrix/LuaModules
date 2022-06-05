-- // Variables
local Color = { __type = "Color" }

-- // Meta 
Color.__index = Color
function Color:__tostring()
	return string.format("<Color> [%d, %d, %d]", self.R, self.G, self.B)
end

function Color:__div(Value)
	local typeValue = type(Value)

	if typeValue == "number" then
		return Color.new(self.R / Value, self.B / Value,  self.G / Value)
	elseif typeValue == "table" and Value.__type == "Color" then
		return Color.new(self.R / Value.R, self.B / Value.B, self.G / Value.G)
	end
end

function Color:__mul(Value)
	local typeValue = type(Value)

	if typeValue == "number" then
		return Color.new(self.R * Value, self.B * Value,  self.G * Value)
	elseif typeValue == "table" and Value.__type == "Color" then
		return Color.new(self.R * Value.R, self.B * Value.B, self.G * Value.G)
	end
end

function Color:__sub(Value)
	local typeValue = type(Value)

	if typeValue == "number" then
		return Color.new(self.R - Value, self.B - Value,  self.G - Value)
	elseif typeValue == "table" and Value.__type == "Color" then
		return Color.new(self.R - Value.R, self.B - Value.B, self.G - Value.G)
	end
end

function Color:__add(Value)
	local typeValue = type(Value)

	if typeValue == "number" then
		return Color.new(self.R + Value, self.B + Value,  self.G + Value)
	elseif typeValue == "table" and Value.__type == "Color" then
		return Color.new(self.R + Value.R, self.B + Value.B,  self.G + Value.G)
	end
end

-- // Functions
function Color:Unpack()
	return self.R / 255, self.G / 255, self.B / 255
end

function Color.new(R, G, B)
	local self = setmetatable({ R = R, G = G, B = B }, Color)

	return self
end

return Color

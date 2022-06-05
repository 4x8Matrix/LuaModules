-- // Variables
local UDim = { __type = "UDim" }

-- // Meta 
UDim.__index = UDim
function UDim:__tostring()
	return string.format("<UDim> [%d, %d]", self.Scale, self.Offset)
end

function UDim:__div(Value)
	local typeValue = type(Value)

	if typeValue == "number" then
		return UDim.new(self.Scale / Value, self.Offset / Value)
	elseif typeValue == "table" and Value.__type == "UDim" then
		return UDim.new(self.Scale / Value.Scale, self.Offset / Value.Offset)
	end
end

function UDim:__mul(Value)
	local typeValue = type(Value)

	if typeValue == "number" then
		return UDim.new(self.Scale * Value, self.Offset * Value)
	elseif typeValue == "table" and Value.__type == "UDim" then
		return UDim.new(self.Scale * Value.Scale, self.Offset * Value.Offset)
	end
end

function UDim:__sub(Value)
	local typeValue = type(Value)

	if typeValue == "table" and Value.__type == "UDim" then
		return UDim.new(self.Scale - Value.Scale, self.Offset - Value.Offset)
	end
end

function UDim:__add(Value)
	local typeValue = type(Value)

	if typeValue == "table" and Value.__type == "UDim" then
		return UDim.new(self.Scale + Value.Scale, self.Offset + Value.Offset)
	end
end

-- // Functions
function UDim:Translate(AxisSize)
	return (AxisSize * self.Scale) + self.Offset
end

function UDim.new(Scale, Offset)
	local self = setmetatable({ Scale = Scale or 0, Offset = Offset or 0 }, UDim)

	return self
end

return UDim

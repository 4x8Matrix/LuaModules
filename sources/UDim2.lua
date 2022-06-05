-- // Modules
local UDim = require("UDim")

-- // Variables
local UDim2 = { __type = "UDim2" }

-- // Meta 
UDim2.__index = UDim2

function UDim2:__tostring()
	return string.format("<UDim2> [%s, %s]", tostring(self.X), tostring(self.Y))
end

function UDim2:__div(Value)
	local typeValue = type(Value)

	if typeValue == "number" then
		return UDim2.new(self.X / Value, self.Y / Value)
	elseif typeValue == "table" and Value.__type == "UDim2" then
		return UDim2.new(self.X / Value.X, self.Y / Value.Y)
	end
end

function UDim2:__mul(Value)
	local typeValue = type(Value)

	if typeValue == "number" then
		return UDim2.new(self.X * Value, self.Y * Value)
	elseif typeValue == "table" and Value.__type == "UDim2" then
		return UDim2.new(self.X * Value.X, self.Y * Value.Y)
	end
end

function UDim2:__sub(Value)
	local typeValue = type(Value)

	if typeValue == "table" and Value.__type == "UDim2" then
		return UDim2.new(self.X - Value.X, self.Y - Value.Y)
	end
end

function UDim2:__add(Value)
	local typeValue = type(Value)

	if typeValue == "table" and Value.__type == "UDim2" then
		return UDim2.new(self.X + Value.X, self.Y + Value.Y)
	end
end

-- // Functions
function UDim2:Lerp(UDim2, Alpha)
	return self + (UDim2 - self) * Alpha
end

function UDim2:Translate(ScreenSize)
	print(self.X, self.Y)
	return self.X:Translate(ScreenSize.X), self.Y:Translate(ScreenSize.Y)
end

function UDim2.new(...)
	local Components = { ... }
	local X, Y

	if type(Components[1]) == "number" then
		X = UDim.new(Components[1], Components[2])

		if type(Components[3]) == "number" then
			Y = UDim.new(Components[3], Components[4])
		else
			Y = Components[3]
		end
	else
		X = Components[1]
		Y = Components[2]
	end

	local self = setmetatable({ 
		X = X, 
		Y = Y
	}, UDim2)

	return self
end

return UDim2

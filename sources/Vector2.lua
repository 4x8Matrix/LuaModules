-- // Variables
local Vector2 = { __type = "Vector2" }

-- // Meta 
Vector2.__index = Vector2

function Vector2:__tostring()
	return string.format("Vector2: {%d, %d}", self.X, self.Y)
end

function Vector2:__mod(Value)
	local typeValue = type(Value)

	if typeValue == "number" then
		return Vector2.new(self.X % Value, self.Y % Value)
	elseif typeValue == "table" and Value.__type == "Vector2" then
		return Vector2.new(self.X % Value.X, self.Y % Value.Y)
	end
end

function Vector2:__div(Value)
	local typeValue = type(Value)

	if typeValue == "number" then
		return Vector2.new(self.X / Value, self.Y / Value)
	elseif typeValue == "table" and Value.__type == "Vector2" then
		return Vector2.new(self.X / Value.X, self.Y / Value.Y)
	end
end

function Vector2:__mul(Value)
	local typeValue = type(Value)

	if typeValue == "number" then
		return Vector2.new(self.X * Value, self.Y * Value)
	elseif typeValue == "table" and Value.__type == "Vector2" then
		return Vector2.new(self.X * Value.X, self.Y * Value.Y)
	end
end

function Vector2:__sub(Value)
	local typeValue = type(Value)

	if typeValue == "table" and Value.__type == "Vector2" then
		return Vector2.new(self.X - Value.X, self.Y - Value.Y)
	end
end

function Vector2:__add(Value)
	local typeValue = type(Value)

	if typeValue == "table" and Value.__type == "Vector2" then
		return Vector2.new(self.X + Value.X, self.Y + Value.Y)
	end
end

function Vector2:__unm()
	return Vector2.new(-self.X, -self.Y)
end

-- // Functions
function Vector2:Max(Vector)
	return Vector2.new(
		(Vector.X > self.X and Vector.X) or self.X,
		(Vector.Y > self.Y and Vector.Y) or self.Y
	)
end

function Vector2:Min(Vector)
	return Vector2.new(
		(Vector.X < self.X and Vector.X) or self.X,
		(Vector.Y < self.Y and Vector.Y) or self.Y
	)
end

function Vector2:Cross(Vector)
	return (Vector.Y * self.X) - (Vector.X * self.Y)
end

function Vector2:Angle(Vector)
	return math.deg(math.acos(self:Dot(Vector) / (Vector.Magnitude * self.Magnitude)))
end

function Vector2:Dot(Vector)
	return (Vector.X * self.X) + (Vector.Y * self.Y)
end

function Vector2:Lerp(Vector, Alpha)
	return self + (Vector - self) * Alpha
end

function Vector2:Normalise()
	return self / self.Magnitude
end

function Vector2:Unpack()
	return self.X, self.Y
end

function Vector2.new(X, Y)
	local self = setmetatable({ X = X or 0, Y = Y or 0 }, Vector2)

	self.Magnitude = math.sqrt((self.X ^ 2) + (self.Y ^ 2))

	return self
end

return Vector2

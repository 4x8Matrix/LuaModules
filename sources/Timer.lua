-- // Modules
local Signal = require(script.Parent.Signal)

-- // Variables
local Timer = { Name = "Timer" }

-- // Timer Methods
function Timer:Start() 
	self.Clock = os.clock() 
	self.Started:Fire() 
end

function Timer:Stop() 
	self.Cancelled:Fire() 
	
	return self.Time 
end

function Timer:Continue() 
	self.Started:Fire() 
end

function Timer:Reset() 
	self:Stop() 
	self:Start() 
end

function Timer:GetTime() 
	return os.clock() - self.Clock 
end

function Timer:GetTimeMS() 
	return math.round((os.clock() - self.Clock) * 1000) 
end

function Timer:GetTimeS() 
	return math.round(os.clock() - self.Clock) 
end

function Timer:GetTimeM() 
	return self:GetTimeS() / 60 
end

function Timer:GetTimeH() 
	return self:GetTimeS() / 60 / 60 
end

-- // Libary Methods
function Timer.new()
    local self = setmetatable({ }, { __index = Timer })

    self.Time = 0

    self.Cancelled = Signal.new()
    self.Started = Signal.new()

    self.Started:Connect(function()
        if self.Active then 
			return
		else 
			self.Active = true 
		end

        self.Cancelled:Wait()
        self.Active = false
        self.Time = os.clock() - self.Clock
    end)

    return self
end

-- // Initialization
return Timer
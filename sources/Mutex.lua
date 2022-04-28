--[[
    Mutex.lua

    @Author: AsynchronousMatrix
    @Licence: ...


]]--

-- // Variables
local MutexModule = { }
local MutexObject = { Name = "Mutex" }

MutexObject.__index = MutexObject

-- // MutexObject Functions
function MutexObject:Lock()
	self._Locked = true
	self._Thread = coroutine.running()

	if self.Callback then 
		self.Callback() 
	end
end

function MutexObject:Unlock()
	if self._Thread then
		assert(self._Thread == coroutine.running(), "Thread Exception: Attempted to call Mutex.Unlock")
	end
	
	self._Thread = nil
	self._Locked = false
end

function MutexObject:Timeout(Int)
	self._Locked = true
	self._Timeout = {
		T = os.time(), Int = Int
	}

	if self.Callback then 
		self.Callback(true, Int) 
	end
end

function MutexObject:IsLocked()
	if self._Timeout then
		if os.time() - self._Timeout.T >= self._Timeout.Int then
			self._Timeout = false
			self._Locked = false

			return false
		end
	end

	return self._Locked
end

-- // MutexModule Functions
function MutexModule.new(Callback)
	local Mutex = setmetatable({ Callback = Callback, _Locked = false }, MutexObject)

	return Mutex
end

-- // Module
return MutexModule

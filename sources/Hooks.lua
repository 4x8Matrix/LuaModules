--[[
    HooksModule.lua

    @Author: AsynchronousMatrix
    @Licence: ...


]]--

-- test

-- // Variables
local HooksModule = { }
local HookFunction = { }

HookFunction.__index = HookFunction
HookFunction.__call = function(Hook, ...)
    return Hook:Invoke(...)
end

-- // HookFunction Functions
function HookFunction:Prefix(Callback)
    assert(type(Callback) == "function", "Expected Argument #1 function")
    
    self._PrefixCallback = Callback
end

function HookFunction:Postfix(Callback)
    assert(type(Callback) == "function", "Expected Argument #1 function")

    self._PostfixCallback = Callback
end

function HookFunction:Patch(Callback)
    assert(type(Callback) == "function", "Expected Argument #1 function")
    
    self.Callback = Callback
end

function HookFunction:Invoke(...)
    if not self.Callback then return end

    if self._PrefixCallback then
        local Continue, Exception = self._PrefixCallback(...)

        if not Continue then return Exception end
    end
    
    if self._PostfixCallback then
        return self._PostfixCallback(
            self.Callback(...)
        )
    end

    return self.Callback(...)
end

-- // HooksModule Functions
function HooksModule.new(Callback)
    local Hook = setmetatable({ Callback = Callback }, HookFunction)

    return Hook
end

-- // Module
return HooksModule
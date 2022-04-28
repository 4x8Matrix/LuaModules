# Hook Module
A [Hooking](https://en.wikipedia.org/wiki/Hooking) Implementation written in lua, influenced by the `Harmony` patching C# system

# Hooks Module API Documentation
## HooksModule
### Methods
```
    HooksModule.new(Callback: Function) -> HookObject
```
Description: Initiate a HookObject used in handling the logic of hooking, patching a Lua Function

Return: HookObject

---
## HookObject
### Methods
```
    HookObject:Prefix(Callback: Function)
```
Description: The Callback reference in Argument #1 will be invoked when the Hook is fired.

The prefix is required to have a bool return value, if the value is falsey (nil or false) then execution of the Patch/Callback will not happen.

---
```
    HookObject:Postfix(Callback: Function)
```
Description: The Callback reference in Argument #1 will be invoked after the Hook is fired.

The Callback will recieve any arguments that the callback/patch will return, from here whatever this function returns will be what will be returned when the hook is invoked

---
```
    HookObject:Patch(Callback: Function)
```
Description: Initiates a new Callback for the hook, patching the old reference

---
## Example
The example below is a demonstration on how you might use the hook libary to your advantage
```
local HookModule = require(script.ModuleScript)
local AddFunction = HookModule.new(function(Int0, Int1)
	return Int0 + Int1
end)

AddFunction:Prefix(function(Int0, Int1)
	if type(Int0) ~= "number" then return false end
	if type(Int1) ~= "number" then return false end
	
	return true
end)

AddFunction:Postfix(function(Value)
	return Value, "Some Postfix Argument!"
end)

-- we can change the logic of `AddFunction` instead, we could multiply the given values!
-- AddFunction:Prefix(function(Int0, Int1)
--  	return Int0 * Int1
-- end)

local Number, PostFixArg = AddFunction(5, 5)

print(Number, PostFixArg)
```

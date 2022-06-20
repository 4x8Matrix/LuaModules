# Lua Mutex
This is essentially a [Mutex Lock](https://en.wikipedia.org/wiki/Lock_(computer_science)) implementation written in Lua; This is a sub-module developed for the Infinity ECS Framework; All Sub-Modules are built to be used inside of Infinity.

The purpose of this is to help simplify the logic of multi-threading through events and so on, Allowing you to have more control over your threads.

# Mutex API Documentation
## Mutex Module API
### Methods
```
    Mutex.new(Callback: Function) -> MutexObject
```
Description: The constructor for the MutexObject, this is how you'll create the MutexObject

Return: MutexObject (API Docs Below)

---
## Mutex Object API
### Properties
```
    Mutex.Callback
```
Description: The callback used when the mutex is initially locked, this callback is invoked in the hope of cleaning up your variables.

### Methods
```
    Mutex:Lock() -> Null
```
Description: Locks the mutex object

---
```
    Mutex:Unlock(Force: bool) -> Null
```
Description: Unlocks the mutex object

---
```
    Mutex:Timeout(Int: Number) -> Null
```
Description: Locks the mutex for the time given in Argument #1

---
```
    Mutex:IsLocked() -> Bool
```
Description: Updates the internal clock & returns a boolean to see if the mutex is currently locked or unlocked.

Return: Bool (true, false)

---

## Example
The example below is essentially just psuedo code used to explain how the Mutex Module works, and how you may be able to manipulate it!
```
local MutexModule = require("Mutex")
local MutexObject = MutexModule.new(function()
    print("Clean!")
end)

Mutex:Timeout(1)
-- -> "Clean!" (In locking our thread, it will invoke the cleaning callback!)
-- -> This will allow us to reset variables, clean variables etc when our thread is locked.

print(Mutex:IsLocked()) --> true
-- A second later..
print(Mutex:IsLocked()) --> false
```

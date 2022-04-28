# Janitor
The Janitor is a collection of object references that in the future you may need or want to clean up, this is often used within roblox to clean up roblox connections, avoiding memory leaks.

# Janitor API Documentation
## Janitor Module API
### Methods
```
    JanitorModule.new() -> JanitorObject
```
Description: The constructor for the JanitorObject, this is how you'll create the JanitorObject

Return: JanitorObject (API Docs Below)

---
## Janitor Object API
### Methods
```
    Janitor:Give(DynamicObject: Any)
```
Description: Adds the DynamicObject into the Janitor's trash allocation

---
```
    Janitor:Remove(DynamicObject: Any)
```
Description: Removes the DynamicObject into the Janitor's trash allocation

---
```
    Janitor:Deconstructor(Type: String, Callback: Function)
```
Description: Creates a deconstructor callback for a `DynamicObject` Type, when the type is being handled by the `.Clean` Method, the callbacks are the logic for handling these objects appropriately 

---
```
    Janitor:Clean()
```
Description: The process of calling each deconstructor callback on the various types registered within the Janitor's trash allocations

---

## Example
The example below
```
local JanitorModule = require(script.ModuleScript)
local Janitor = JanitorModule.new()

-- We're adding our custom deconstructor callback for `userdata`
Janitor:Deconstructor("userdata", function(userdataObject)
	print("Clean Up Userdata:", userdataObject)
end)

-- newproxy initiates a new userdata object
Janitor:Give(newproxy())

-- we call Clean, which invokes our userdata deconstructor callback
Janitor:Clean()
```

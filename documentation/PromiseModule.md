# Promise
Influenced from web development, a Promise is a piece of logic used to simplify the use of asynchronous functions and so on, with the use of a Promise, you have more control over requests and so on that you make within your code. 

Lua should also have an adaptation of this Promise, a Promise would be sufficient for Lua Networking, handling special Coroutines that may be unpredictable or usage in general code (If needed.)

# Promise API Documentation
## Promise Module API
### Methods
```
    PromiseModule.new(Function: Function, ...: Any) -> PromiseObject
```
Description: Constructor used to create a PromiseObject, the `Function` argument would be the asynchronous function

Return: PromiseObject (API Docs Below)

---
```
    PromiseModule.Wrap(Function: Function, ...: Any) -> PromiseObject
```
Description: Wraps a function within a PCall, calling Promise:Reject, Resolve when appropriate. This method essentially removes the Promise Argument used in `PromiseModule.new`, removing management of the `PromiseObject`

Return: PromiseObject

---
```
    PromiseModule.Settle(Promises: Array)
```
Description: Yields the current thread until each `PromiseObject` inside of `Promises` has finished their tasks.

---
```
    PromiseModule.AwaitSuccess(Promise: PromiseObject) -> PromiseObject-Result
```
Description: Yields the current thread until the `PromiseObject` has been resolved.

Return: PromiseObject-Result (The result of the promise, you may need to see if the promise object was resolved or rejected in order to handle the result correctly.)

---
## Promise Object API
### Properties
```
    PromiseObject.Rejected -> boolean | nil
```
Description: Set when PromiseObject:Reject is called, The promise was Failed, Rejected.

---

```
    PromiseObject.Resolved -> boolean | nil
```
Description: Set when PromiseObject:Resolve is called, The promise was a Success, Resolved.

---

### Methods
```
    PromiseObject:Get() -> PromiseObject-Result
```
Description: Gets the result of the PromiseObject

---
```
    PromiseObject:Finally(Callback: Function) -> PromiseObject
```
Description: Sets the `Finally` callback for the PromiseObject.

The `Finally` callback is the callback which is called at the end of either `PromiseObject:Reject` or `PromiseObject:Resolve`, as in the name. It is the `Final` callback fired

---
```
    PromiseObject:Catch(Callback: Function) -> PromiseObject
```
Description: Sets the `Catch` callback for the PromiseObject.

The `Catch` callback will be invoked if `PromiseObject:Reject` is called, a callback used to handle the rejection of a promise

If this is not set & `PromiseObject:Reject` is called, a message will be displayed in output with the arguments passed into `PromiseObject:Reject`

---
```
    PromiseObject:Then(Callback: Function) -> PromiseObject
```
Description: Adds the Callback into the Promises stack

The `Then` callback will be fired in a sequential order if `PromiseObject:Resolve` is called

---
```
    PromiseObject:Cancel() -> PromiseObject
```
Description: Cancel the `Then` sequential iteration

---
```
    PromiseObject:Retry() -> PromiseObject
```
Description: Attempt to re-invoke the PromiseObject, this method will re-use old arguments passed into the first invoke

---
```
    PromiseObject:Await() -> PromiseObject
```
Description: Yields the thread until either `PromiseObject:Reject` or `PromiseObject:Resolve` is called

---
```
    PromiseObject:Resolve(...)
```
Description: Will resolve the PromiseObjects, the results of the PromiseObject should be passed into :Resolve

---
```
    PromiseObject:Reject(...)
```
Description: Will reject the PromiseObjects, the exception of the PromiseObject should be passed into :Reject

---
```
    PromiseObject(...)
```
Description: The function used to Invoke/Start a PromiseObject.

---


## Example
The example below is how we would handle an asynchronous GET request from inside of Roblox
```
local HttpService = game:GetService("HttpService")
local HttpUrl = "https://pastebin.com/raw/uw01jY9k"

local PromiseModule = require(script.ModuleScript)

PromiseModule.Wrap(HttpService.GetAsync):Then(function(Promise, ServResponse)
	print(ServResponse)
end):Catch(function(Promise, Exception)
	warn(Exception)
	
	task.wait(1)
	Promise:Retry()
end)(HttpService, HttpUrl)
```

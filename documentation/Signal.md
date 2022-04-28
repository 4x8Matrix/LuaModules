# Signal
This is a lua [Signal](https://en.wikipedia.org/wiki/Signal_programming) implementation, attempting to create a signal object which can be binded to by lua functions. 

The SignalObject is influenced by Roblox's API's for RBXScriptSignals.

# Signal API Documentation
## Signal Module API
### Methods
```
    SignalModule.new() -> SignalObject
```
Description: Initiate a new anonymous signal object, anonymous meaning there is no unique identifier. 

Return: SignalObject (API Docs Below)

---
## Signal Object API
### Methods
```
    SignalObject:Connect(Callback: Function) -> ConnectionObject
```
Description: Connect to a signal, essentially bind a function, when the signal gets invoked/fired, this function will be fired.

Return: ConnectionObject (API Docs Below)

---
```
    SignalObject:Wait()
```
Description: Yield the current thread until this signal is fired

---
```
    SignalObject:Fire(...: Any)
```
Description: Fire the signal with any arguments you want to be passed into the connections

---
### Properties
```
    SignalObject.UseCoroutines -> Boolean
```
Description: Defines if the signal is single threaded or usese coroutines when invoking connections

---

## Connection Object API
### Methods
```
    ConnectionObject:Reconnect(...: Any)
```
Description: Reconnect to the signal

---
```
    ConnectionObject:Disconect(...: Any)
```
Description: Disconnect the signal

---

### properties
```
    ConnectionObject.Connected -> Boolean
```
Description: A boolean depicting weather or not the signal is connected

---

## Example
The example below shows how to utilise all objects from a Signal
```
local SignalModule = require("Signal")
local Signal = SignalModule.new()

local Connection

-- Connect to our signal
Connection = Signal:Connect(function(...)
    print("SignalGot:", ...)

    Connection:Disconnect() -- we disconnect our signal. We only want to print once.
end)

Signal:Fire(1, 2, 3) --> "SignalGot: 1 2 3"
Signal:Fire(1, 2, 3) --> nil
```

module Status exposing (Status, init, connect)
import Json.Decode as Decode
import Random
import Dict
import Bridge

type ClientId = ClientId String

type Status model = Disconnected | Connected ClientId model

init = Disconnected

connect : String -> a -> Status a
connect id initValue = Connected (ClientId id) initValue

type alias MsgsFromBackend = List Bridge.MsgFromBackend

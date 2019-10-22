module Bridge exposing
    ( MsgFromBackend
    , MsgFromFrontend
    , encodeMsgToBackend
    , encodeMsgToFrontend
    , encodeMsgFromBackend
    , encodeMsgFromFrontend
    , decodeMsgToBackend
    , decodeMsgToFrontend
    , decodeMsgFromBackend
    , decodeMsgFromFrontend
    )
import Json.Decode as Decode
import Json.Encode as Encode

-- [decgen-start]
type alias MsgToFrontend = String
type alias MsgToBackend = String


type alias MsgFromFrontend = MsgToBackend
type alias MsgFromBackend = MsgToBackend

-- [decgen-generated-start] -- DO NOT MODIFY or remove this line
decodeMsgFromBackend =
   decodeMsgToBackend

decodeMsgFromFrontend =
   decodeMsgToBackend

decodeMsgToBackend =
   Decode.string

decodeMsgToFrontend =
   Decode.string

decodeMsgsFromBackend =
   Decode.list decodeMsgFromBackend

decodeMsgsFromFrontend =
   Decode.list decodeMsgFromFrontend

encodeMsgFromBackend a =
   encodeMsgToBackend a

encodeMsgFromFrontend a =
   encodeMsgToBackend a

encodeMsgToBackend a =
   Encode.string a

encodeMsgToFrontend a =
   Encode.string a

encodeMsgsFromBackend a =
   (Encode.list encodeMsgFromBackend) a

encodeMsgsFromFrontend a =
   (Encode.list encodeMsgFromFrontend) a 
-- [decgen-end]




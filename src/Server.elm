port module Server exposing (..)

import Browser
import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src)
import Json.Encode as Encode
import Json.Decode as Decode
import Dict
import Bridge


---- MODEL ----

port respond : Encode.Value -> Cmd msg
port receive : ((FrontendId, String) -> msg) -> Sub msg
port connect : (FrontendId -> msg) -> Sub msg



type alias Model =
    Frontends


type alias Frontends =
    Dict.Dict FrontendId (List Bridge.MsgFromFrontend)

type alias Flags = ()

run : Flags -> ( Model, Cmd Msg )
run _ =
    ( Dict.empty, Cmd.none )



---- UPDATE ----

type alias FrontendId = String

type Msg
    = NoOp
    | Connected (FrontendId)
    | RequestReceived FrontendId Bridge.MsgFromFrontend


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        _ = Debug.log "log" (msg, model)
        frontends = model
    in
    case msg of
        Connected clientId ->
            (Dict.insert clientId [] frontends, Cmd.none)
        RequestReceived clientId msgFromFrontend ->
            (Dict.update clientId (record msgFromFrontend) frontends, Cmd.none)
        NoOp -> ( model, Cmd.none )

record msg msgs =
    case msgs of
        Nothing -> Just [msg]
        Just msgs_ -> Just (msg :: msgs_)

---- PROGRAM ----
main : Platform.Program Flags Model Msg
main = Platform.worker {
    init = run
  , update = update
  , subscriptions = subs
  }

subs model =
    Sub.batch [
      connect Connected
    , receive parseReceive
    ]
parseReceive : (String, String) -> Msg
parseReceive (id, msg) =
        Decode.decodeString Bridge.decodeMsgFromFrontend msg
        |> Result.toMaybe
        |> Maybe.map (RequestReceived id)
        |> Maybe.withDefault NoOp

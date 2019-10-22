port module Main exposing (..)

import Browser
import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src)
import Html.Events
import Json.Decode as Decode
import Json.Encode as Encode
import Random
import Dict
import Status
import Bridge


---- MODEL ----


type alias Model =
    { seed : Random.Seed
    , status : Status.Status (List Bridge.MsgFromBackend)
    }



init : Flags -> ( Model, Cmd Msg )
init {seed} =
    let
        initModel =
            { seed = Random.initialSeed seed
            , status = Status.init
            }
    in
    ( initModel, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp
    | ConnectButtonClicked
    | Connected String
    | SendButtonClicked
    | Received

port connect : () -> Cmd msg
port send : Encode.Value -> Cmd msg
port connected : (String -> msg) -> Sub msg

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
        ConnectButtonClicked ->
            ( model, connect ())
        Connected id ->
            ( {model | status = Status.connect id []}, Cmd.none)
        SendButtonClicked ->
            ( model, send (Bridge.encodeMsgToBackend "hello world") )
        Received ->
            Debug.todo "Received"


type alias Flags = {
      seed : Int
    , storage : Decode.Value
    }

---- VIEW ----
view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working!" ]
        -- , log model
        , Html.button [Html.Events.onClick ConnectButtonClicked] [Html.text "Connect"]
        , Html.button [Html.Events.onClick SendButtonClicked] [Html.text "Send"]
        ]

-- log = Dict.toList >> List.map (Debug.toString >> Html.text >> List.singleton >> Html.div [])


---- PROGRAM ----


main : Program Flags Model Msg
main =
    Browser.element
        { view = view
        , init = init
        , update = update
        , subscriptions = subs
        }

subs : Model -> Sub Msg
subs model = connected Connected

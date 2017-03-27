
module App exposing (..)

import Html exposing (Html, div, text, button, program)

import Components.Expandable as Expandable


-- MODEL


type alias Model =
    Bool


init : ( Model, Cmd Msg )
init =
    ( False, Cmd.none )



-- MESSAGES


type Msg = Expand 
         | Collaps



-- VIEW


view : Model -> Html Msg
view model =
    Expandable.render 
        { expandMsg = Expand, collapsMsg = Collaps, expanded = model }
        [ text "Widget 42" ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Expand  -> ( True, Cmd.none )
        Collaps -> ( False, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

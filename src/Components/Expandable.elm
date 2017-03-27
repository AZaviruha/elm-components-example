module Components.Expandable exposing (render, Model)

import VirtualDom exposing (Property(..))
import Html exposing (Html, div, text, button, program)
import Html.Events exposing (onClick)


type alias Attribute a = Property a


type alias Model a = 
    {
        expandMsg   : a,
        collapsMsg  : a,
        expanded    : Bool
    }

render : Model a -> List (Html a) -> Html a
render model childs = 
    if model.expanded then
        div []
            [
                button [ onClick model.collapsMsg ] [ text "Collaps" ],
                div [] childs
            ]
    else
        div []
            [
                button [ onClick model.expandMsg ] [ text "Expand" ]
            ]
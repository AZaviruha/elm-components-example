module Components.Expandable exposing (render, onExpand, onCollaps, expanded)

import VirtualDom exposing (Property(..))
import Html exposing (Html, div, text, button, program)
import Html.Events exposing (onClick)
import List exposing (foldl)


type alias Attribute a = Property a

type CustomAttribute a = ExpandedAttr (Attribute a) 
                       | CollapsedAttr (Attribute a)
                       | Switcher Bool

type alias ExpandedModel a = 
    {
        expandedAttrs : List (Attribute a),
        collapsedAttrs : List (Attribute a),
        expanded : Bool,
        expandedTitle : String,
        collapsedTitle : String
    }


render : List (CustomAttribute a) -> List (Html a) -> Html a
render attrs childs = 
    let collected = collect attrs
    in
        if collected.expanded then
            div []
                [
                    button collected.expandedAttrs [ text "Collaps" ],
                    div [] childs
                ]
        else
            div []
                [
                    button collected.collapsedAttrs [ text "Expand" ]
                ]


onExpand : a -> CustomAttribute a
onExpand msg = CollapsedAttr (onClick msg)

onCollaps : a -> CustomAttribute a
onCollaps msg = ExpandedAttr (onClick msg)


expanded : Bool -> CustomAttribute a
expanded x = Switcher x


collect : List (CustomAttribute a) -> ExpandedModel a
collect xs = 
    let initial = 
        { 
           expandedAttrs = [],
           collapsedAttrs = [],
           expanded = False,
           expandedTitle = "",
           collapsedTitle = ""
        }
    in 
        foldl collectStep initial xs


collectStep : CustomAttribute a -> ExpandedModel a -> ExpandedModel a
collectStep cAttr acc = case cAttr of
    ExpandedAttr attr  -> { acc | expandedAttrs = attr :: acc.expandedAttrs }
    CollapsedAttr attr -> { acc | collapsedAttrs = attr :: acc.collapsedAttrs }
    Switcher x         -> { acc | expanded = x }

module Pizzas.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Html.Events exposing (onClick)
import Models exposing (Pizza)
import Msgs exposing (Msg)
import Routing exposing (pizzasPath)


view : Pizza -> Html.Html Msg
view model =
    div []
        [ nav model
        , form model
        ]


nav : Pizza -> Html.Html Msg
nav model =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listBtn ]


form : Pizza -> Html.Html Msg
form pizza =
    div [ class "m3" ]
        [ h1 [] [ text pizza.name ]
        , formLevel pizza
        ]


formLevel : Pizza -> Html.Html Msg
formLevel pizza =
    div
        [ class "clearfix py1"
        ]
        [ div [ class "col col-5" ] [ text "Level" ]
        , div [ class "col col-7" ]
            [ span [ class "h2 bold" ] [ text (toString pizza.price) ]
            , btnLevelDecrease pizza
            , btnLevelIncrease pizza
            ]
        ]


btnLevelDecrease : Pizza -> Html.Html Msg
btnLevelDecrease pizza =
    let
        message =
            Msgs.ChangeLevel pizza -1
    in
        a [ class "btn ml1 h1", onClick message ]
            [ i [ class "fa fa-minus-circle" ] [] ]


btnLevelIncrease : Pizza -> Html.Html Msg
btnLevelIncrease pizza =
    let
        message =
            Msgs.ChangeLevel pizza 1
    in
        a [ class "btn ml1 h1", onClick message ]
            [ i [ class "fa fa-plus-circle" ] [] ]


listBtn : Html Msg
listBtn =
    a
        [ class "btn regular"
        , href pizzasPath
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]

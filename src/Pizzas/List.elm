module Pizzas.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href, attribute)
import Models exposing (Pizza)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)
import Routing exposing (pizzaPath)


view : WebData (List Pizza) -> Html Msg
view response =
    div []
        [ nav
        , maybeList response
        ]


nav : Html Msg
nav =
    div []
        [ div [ class "mdc-typography--headline" ] [ text "Pizzas" ] ]


maybeList : WebData (List Pizza) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            progressBar

        RemoteData.Success pizzas ->
            list pizzas

        RemoteData.Failure error ->
            text (toString error)


progressBar : Html msg
progressBar =
    div [ class "mdc-linear-progress mdc-linear-progress--indeterminate", attribute "role" "progressbar" ]
        [ div [ class "mdc-linear-progress__buffering-dots" ] []
        , div [ class "mdc-linear-progress__buffer" ] []
        , div [ class "mdc-linear-progress__bar mdc-linear-progress__primary-bar" ]
            [ span [ class "mdc-linear-progress__bar-inner" ] []
            ]
        , div
            [ class "mdc-linear-progress__bar mdc-linear-progress__secondary-bar" ]
            [ span [ class "mdc-linear-progress__bar-inner" ] []
            ]
        ]


list : List Pizza -> Html Msg
list pizzas =
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [ class "mdc-typography--subheading1" ] [ text "Id" ]
                    , th [ class "mdc-typography--subheading1" ] [ text "Name" ]
                    , th [ class "mdc-typography--subheading1" ] [ text "Price" ]
                    , th [ class "mdc-typography--subheading1" ] [ text "Actions" ]
                    ]
                ]
            , tbody [] (List.map pizzaRow pizzas)
            ]
        ]


pizzaRow : Pizza -> Html Msg
pizzaRow pizza =
    tr []
        [ td [ class "mdc-typography--body1" ] [ text pizza.id ]
        , td [ class "mdc-typography--body1" ] [ text pizza.name ]
        , td [ class "mdc-typography--body1" ] [ text (toString pizza.price) ]
        , td [ class "mdc-typography--body1" ]
            [ editBtn pizza ]
        ]


editBtn : Pizza -> Html.Html Msg
editBtn pizza =
    let
        path =
            pizzaPath pizza.id
    in
        a
            [ class "btn regular"
            , href path
            ]
            [ i [ class "fa fa-pencil mr1" ] [], text "Edit" ]

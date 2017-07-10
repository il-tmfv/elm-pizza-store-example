module Pizzas.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
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
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "Pizzas" ] ]


maybeList : WebData (List Pizza) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success pizzas ->
            list pizzas

        RemoteData.Failure error ->
            text (toString error)


list : List Pizza -> Html Msg
list pizzas =
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "Id" ]
                    , th [] [ text "Name" ]
                    , th [] [ text "Price" ]
                    , th [] [ text "Actions" ]
                    ]
                ]
            , tbody [] (List.map pizzaRow pizzas)
            ]
        ]


pizzaRow : Pizza -> Html Msg
pizzaRow pizza =
    tr []
        [ td [] [ text pizza.id ]
        , td [] [ text pizza.name ]
        , td [] [ text (toString pizza.price) ]
        , td []
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

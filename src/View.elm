module View exposing (..)

import Html exposing (Html, div, text)
import Models exposing (Model, PizzaId)
import Models exposing (Model)
import Msgs exposing (Msg)
import Pizzas.Edit
import Pizzas.List
import RemoteData


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.PizzasRoute ->
            Pizzas.List.view model.pizzas

        Models.PizzaRoute id ->
            pizzaEditPage model id

        Models.NotFoundRoute ->
            notFoundView


pizzaEditPage : Model -> PizzaId -> Html Msg
pizzaEditPage model pizzaId =
    case model.pizzas of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading ..."

        RemoteData.Success pizzas ->
            let
                maybePizza =
                    pizzas
                        |> List.filter (\pizza -> pizza.id == pizzaId)
                        |> List.head
            in
                case maybePizza of
                    Just pizza ->
                        Pizzas.Edit.view pizza

                    Nothing ->
                        notFoundView

        RemoteData.Failure err ->
            text (toString err)


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]

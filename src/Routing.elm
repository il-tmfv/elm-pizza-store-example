module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (PizzaId, Route(..))
import UrlParser exposing (..)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map PizzasRoute top
        , map PizzaRoute (s "pizzas" </> string)
        , map PizzasRoute (s "pizzas")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


pizzasPath : String
pizzasPath =
    "#pizzas"


pizzaPath : PizzaId -> String
pizzaPath id =
    "#pizzas/" ++ id

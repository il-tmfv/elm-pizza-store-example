module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { pizzas : WebData (List Pizza)
    , route : Route
    }


initialModel : Route -> Model
initialModel route =
    { pizzas = RemoteData.Loading
    , route = route
    }


type alias PizzaId =
    String


type alias Pizza =
    { id : PizzaId
    , name : String
    , price : Int
    }


type Route
    = PizzasRoute
    | PizzaRoute PizzaId
    | NotFoundRoute

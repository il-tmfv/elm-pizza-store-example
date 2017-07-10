module Update exposing (..)

import Commands exposing (savePlayerCmd)
import Models exposing (Model, Pizza)
import Msgs exposing (Msg)
import Routing exposing (parseLocation)
import RemoteData


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchPizzas response ->
            ( { model | pizzas = response }, Cmd.none )

        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )

        Msgs.ChangeLevel pizza howMuch ->
            let
                updatedPizza =
                    { pizza | price = pizza.price + howMuch }
            in
                ( model, savePlayerCmd updatedPizza )

        Msgs.OnPizzaSave (Ok pizza) ->
            ( updatePlayer model pizza, Cmd.none )

        Msgs.OnPizzaSave (Err error) ->
            ( model, Cmd.none )


updatePlayer : Model -> Pizza -> Model
updatePlayer model updatedPizza =
    let
        pick currentPizza =
            if updatedPizza.id == currentPizza.id then
                updatedPizza
            else
                currentPizza

        updatePizzaList pizzas =
            List.map pick pizzas

        updatedPizzas =
            RemoteData.map updatePizzaList model.pizzas
    in
        { model | pizzas = updatedPizzas }

module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode as Encode
import Msgs exposing (Msg)
import Models exposing (PizzaId, Pizza)
import RemoteData


fetchPlayers : Cmd Msg
fetchPlayers =
    Http.get fetchPlayersUrl playersDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchPizzas


fetchPlayersUrl : String
fetchPlayersUrl =
    "http://localhost:4000/pizzas"


savePlayerUrl : PizzaId -> String
savePlayerUrl playerId =
    "http://localhost:4000/pizzas/" ++ playerId


savePlayerRequest : Pizza -> Http.Request Pizza
savePlayerRequest player =
    Http.request
        { body = playerEncoder player |> Http.jsonBody
        , expect = Http.expectJson playerDecoder
        , headers = []
        , method = "PATCH"
        , timeout = Nothing
        , url = savePlayerUrl player.id
        , withCredentials = False
        }


savePlayerCmd : Pizza -> Cmd Msg
savePlayerCmd player =
    savePlayerRequest player
        |> Http.send Msgs.OnPizzaSave



-- DECODERS


playersDecoder : Decode.Decoder (List Pizza)
playersDecoder =
    Decode.list playerDecoder


playerDecoder : Decode.Decoder Pizza
playerDecoder =
    decode Pizza
        |> required "id" Decode.string
        |> required "name" Decode.string
        |> required "price" Decode.int


playerEncoder : Pizza -> Encode.Value
playerEncoder player =
    let
        attributes =
            [ ( "id", Encode.string player.id )
            , ( "name", Encode.string player.name )
            , ( "level", Encode.int player.price )
            ]
    in
        Encode.object attributes

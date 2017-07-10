module Msgs exposing (..)

import Models exposing (Pizza)
import RemoteData exposing (WebData)
import Navigation exposing (Location)
import Http


type Msg
    = OnFetchPizzas (WebData (List Pizza))
    | OnLocationChange Location
    | ChangeLevel Pizza Int
    | OnPizzaSave (Result Http.Error Pizza)

module Main where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing ((<~), (~), Address)
import Random exposing (Seed)
import Time exposing (Time)
import Mouse

type alias Model = Int
type Action = Click | NOP

mailbox = Signal.mailbox NOP

view : Model -> (Int, Int) -> (Int, Int) -> Html
view counter (x, y) (top, left) =
  button [style [("position", "absolute"),
                 ("top", toString (y + top) ++ "px"),
                 ("left", toString (x + left) ++ "px")],
                 onClick mailbox.address Click]
         [h1 [] [
           text<<toString <| counter
           ]]

update : Action -> Model -> Model
update action counter =
  case action of
    Click ->
      counter + 1
    NOP ->
      counter

main : Signal Html
main =
  let
      model = Signal.foldp update 0 mailbox.signal
      offset = (randomOffset 10) <~ (Time.every 100)
  in
    view <~ model ~ Mouse.position ~ offset

randomOffset : Int -> Time -> (Int, Int)
randomOffset maxOffset time =
  let
      seed = Random.initialSeed <| round time
  in
    fst <| Random.generate (Random.pair (Random.int -maxOffset maxOffset) (Random.int -maxOffset maxOffset)) seed

module Main where

import Html exposing (..)
import Signal exposing ((<~), (~))
import Mouse
import Keyboard
import Char exposing (fromCode)
import String exposing (fromChar)
import Set exposing (Set, toList)
import List exposing (map)

type alias Position = (Int, Int)
type alias Keys = Set Int

view : Position -> Keys -> Html
view position keys =
  div [] [
    h1 [] [text "X:", text <| toString <| fst position],
    h1 [] [text "Y:", text <| toString <| snd position],
    h1 [] <| text "Key pressed: " :: map (text<<fromChar<<fromCode) (toList keys)
    ]

--Mouse.position : Signal (Int, Int)
--Keyboard.keysDown : Signal (Set Int)
--(view <~ Mouse.position) : Signal (Keys -> Html)

main : Signal Html
main = (view <~ Mouse.position) ~ Keyboard.keysDown

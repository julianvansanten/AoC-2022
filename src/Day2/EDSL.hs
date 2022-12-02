module Day2.EDSL (Draw, Game) where


newtype Draw = Rock | Paper | Scissors
    deriving (Show, Eq)

newtype Game = Game Draw Draw
    deriving (Show, Eq)

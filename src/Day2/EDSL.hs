module Day2.EDSL where


data Draw = Rock | Paper | Scissors
    deriving (Show, Eq)

data Game = Game Draw Draw
    deriving (Show, Eq)

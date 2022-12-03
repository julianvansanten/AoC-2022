module Day2.EDSL (Draw(..), Result(..), Game1(..), Games1(..), Game2(..), Games2(..)) where


data Draw = Rock | Paper | Scissors
    deriving (Show, Eq)


-- | In the second puzzle, X, Y, and Z correspond to losing, drawing and winning
data Result = Loss | Draw | Win
    deriving (Show, Eq)

data Game1 = Game1 Draw Draw
    deriving (Show, Eq)

newtype Games1 = Games1 [Game1]
    deriving (Show, Eq)

data Game2 = Game2 Draw Result
    deriving (Show, Eq)

newtype Games2 = Games2 [Game2]
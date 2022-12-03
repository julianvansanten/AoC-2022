module Day2.PointLogic (
    calculateTotalPoints
) where


import Day2.EDSL


class TotalPoints a where
    calculateTotalPoints :: a -> Int


class GamePoints a where
    gamePoints :: a -> Int


instance TotalPoints Games1 where
    calculateTotalPoints (Games1 gs) = sum $ map gamePoints gs

instance TotalPoints Games2 where
    calculateTotalPoints (Games2 gs) = sum $ map gamePoints gs


instance GamePoints Game1 where
    gamePoints game = calculateGame1Result game + calculateDrawScore1 game

instance GamePoints Game2 where
    gamePoints = gamePoints . toGame1


toGame1 :: Game2 -> Game1
toGame1 (Game2 o r) | r == Draw = Game1 o o
        | o == Rock = if r == Loss then Game1 o Scissors else Game1 o Paper
        | o == Paper = if r == Loss then Game1 o Rock else Game1 o Scissors
        | o == Scissors = if r == Loss then Game1 o Paper else Game1 o Rock



-- | Calculate the points awarded to me when I play a game
calculateGame1Result :: Game1 -> Int
calculateGame1Result (Game1 opponent me) | opponent == me = 3
                                    | opponent == Rock = if me == Paper then 6 else 0
                                    | opponent == Paper = if me == Scissors then 6 else 0
                                    | opponent == Scissors = if me == Rock then 6 else 0


-- | Calculate the points gained from the chosen move
calculateDrawScore1 :: Game1 -> Int
calculateDrawScore1 (Game1 _ me) | me == Rock = 1
                            | me == Paper = 2
                            | me == Scissors = 3
                            | otherwise = error "Undefined draw!"

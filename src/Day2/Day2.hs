module Day2.Day2 (getDaySolutions) where


import Text.ParserCombinators.Parsec

import Day2.EDSL as E

getDaySolutions :: (String -> String, String -> String)
getDaySolutions = (solve1, solve2)


solve1 :: String -> String
solve1 = error "First solution of day 2 not implemented yet!"

solve2 :: String -> String
solve2 = error "Second solution of day 2 not implemented yet!"


calculatePoints :: Game -> Int
calculatePoints game = calculateGameResult game + calculateDrawScore game


calculateGameResult (E.Game opponent me) | opponent == me = 3
                                    | opponent == Rock = if me == Paper then 6 else 0
                                    | opponent == Paper = if me == Scissors then 6 else 0
                                    | opponent == Scissors = if me == Rock then 6 else 0


-- | Calculate the points gained from the chosen move
calculateDrawScore (E.Game _ me) | me == Rock = 1
                            | me == Paper = 2
                            | me == Scissors = 3
                            | otherwise = error "Undefined draw!"
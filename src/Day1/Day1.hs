module Day1.Day1 (getDaySolutions) where


import Data.List (sort)
import Data.List.Split (splitOn)


getDaySolutions :: (String -> String, String -> String)
getDaySolutions = (solve1, solve2)


solve1 :: String -> String
solve1 str = show (maximum $ getWeights str)

solve2 :: String -> String
solve2 = show . getTopThree


-- | Get the weights of all Calories carried by each elf.
getWeights :: String -> [Int]
getWeights = map (sum . (map read . lines)) . splitOn "\n\n"


-- | Get the total weight of the top three elves
getTopThree :: String -> Int
getTopThree = sum . take 3 . reverse . sort . getWeights
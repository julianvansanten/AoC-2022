module Day6.Day6 (getDaySolutions) where
import Data.List (nub)


getDaySolutions :: (String -> String, String -> String)
getDaySolutions = (solve1, solve2)


solve1 :: String -> String
solve1 = show . uniqueAt 4 4

solve2 :: String -> String
solve2 = show . uniqueAt 14 14


-- | Compute at which index in a given list the n amount of units are unique
uniqueAt :: (Eq a) => Int -> Int -> [a] -> Int
uniqueAt _ _ [] = error "Empty list!"
uniqueAt n i str@(_:xs) | length str < n = error "No unique list!"
    | otherwise = if length w == length (nub w) then i else uniqueAt n (i + 1) xs
    where
        w = take n str

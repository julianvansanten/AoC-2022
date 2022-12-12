module Day3.Solution1
    (
            getPriority,
            getPriorities1
    ) where


import Data.Char (ord, isAsciiLower, isAsciiUpper)
import Data.List (intersect)


{- | Get the priority of a character as defined by the problem:

    Lowercase item types a through z have priorities 1 through 26.
    Uppercase item types A through Z have priorities 27 through 52.
-}
getPriority :: Char -> Int
getPriority c | isAsciiLower c = ord c - 96
        | isAsciiUpper c = ord c - 38
        | otherwise = -1


-- | Calculate the intersection of two lists and return the first result.
firstIntersect :: (Eq a) => ([a], [a]) -> a
firstIntersect (xs, ys) = head $ intersect xs ys


-- | Split a list into two lists through the middle.
equalSplit :: [a] -> ([a], [a])
equalSplit xs = (left, right)
    where
        middle = length xs `div` 2
        left = take middle xs
        right = drop middle xs


-- | Get the first intersect from a list
getIntersect :: (Eq a) => [a] -> a
getIntersect = firstIntersect . equalSplit


-- | Convert input to the total priority count
getPriorities1 :: String -> Int
getPriorities1 str = sum $ map (getIntersect . map getPriority) $ lines str
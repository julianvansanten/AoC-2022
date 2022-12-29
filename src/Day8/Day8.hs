module Day8.Day8 (getDaySolutions, scenicScore, scenicScores) where


import Data.List ( transpose )
import Data.Char ( digitToInt )


getDaySolutions :: (String -> String, String -> String)
getDaySolutions = (solve1, solve2)


solve1 :: String -> String
solve1 = show . countNotZero . visMatrix . getMatrix

solve2 :: String -> String
solve2 = show . findMax . scenicMatrix . getMatrix


-- | Convert input string to a matrix of digits
getMatrix :: String -> [[Int]]
getMatrix str =  map (map ((+1) . digitToInt)) (lines str)


-- | Count all non zero elements
countNotZero :: [[Int]] -> Int
countNotZero = sum . map (length . filter (/= 0))


-- | Find the maximum value in a matrix
findMax :: [[Int]] -> Int
findMax = maximum . map maximum


-- | Calculate the scenic scores matrix
scenicMatrix :: [[Int]] -> [[Int]]
scenicMatrix xss = zipWith (zipWith (*)) leftRight upDown
    where
        rightSc = reverse . scenicScores . reverse
        f = map (\xs -> zipWith (*) (scenicScores xs) (rightSc xs))
        leftRight = f xss
        upDown = (transpose . f . transpose) xss


-- | Check the visibility of an entire matrix in all directions
-- The highest visibility will be included in the matrix
visMatrix :: [[Int]] -> [[Int]]
visMatrix xss = zipWith (zipWith max) leftRight upDown
    where
        f = map (\xs -> zipWith max (visLeft xs) (visRight xs))
        leftRight = f xss
        upDown = (transpose . f . transpose) xss


-- | Check hte visibility of trees in the other direction
visRight :: [Int] -> [Int]
visRight = reverse . visLeft . reverse


-- | Check the visibility of trees from one direction
visLeft :: [Int] -> [Int]
visLeft xs = zipWith (\x y -> max (x - y) 0) xs (0 : scanl1 max (take (length xs - 1) xs))


-- | Calculate the scenic scores for all elements in a given list
scenicScores :: [Int] -> [Int]
scenicScores [] = []
scenicScores (x : xs) = scenicScore (x:xs) : scenicScores xs


-- | Calculate the scenic score in one direction for a given list of numbers
-- The scenic score of the first element x in the list is all values less than x,
-- up to and including the first element larger or equal to x
-- The scenic score of a value with no other elements next to it is 0
scenicScore :: [Int] -> Int
scenicScore [] = 0
scenicScore [_] = 0
scenicScore (x : y : xs) | x <= y = 1
    | otherwise = 1 + scenicScore (x : xs)
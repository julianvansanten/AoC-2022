module Day8.Day8 (getDaySolutions) where


import Data.List ( transpose )
import Data.Char ( digitToInt )


getDaySolutions :: (String -> String, String -> String)
getDaySolutions = (solve1, solve2)


solve1 :: String -> String
solve1 = show . countNotZero . visMatrix . getMatrix

solve2 :: String -> String
solve2 = error "Second solution of day 8 not implemented yet!"


-- | Convert input string to a matrix of digits
getMatrix :: String -> [[Int]]
getMatrix str =  map (map ((+1) . digitToInt)) (lines str)


-- | Count all non zero elements
countNotZero :: [[Int]] -> Int
countNotZero = sum . map (length . filter (/= 0))


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

module Day3.Solution2 (getPriorities2) where


import Data.List (intersect)
import Day3.Solution1 (getPriority)


-- | Get a lits of all priorities
getPriorities2 :: String -> Int
getPriorities2 str = sum $ getIntersectList $ map (map getPriority) $ lines str


-- | Get the intersections of three lists combined
getIntersectList :: (Eq a) => [[a]] -> [a]
getIntersectList [] = []
getIntersectList [_] = []
getIntersectList [_, _] = []
getIntersectList (xs:ys:zs:res) = findFirstIntersect xs ys zs : getIntersectList res


-- | Find the first element that is an intersection of three lists
findFirstIntersect :: (Eq a) => [a] -> [a] -> [a] -> a
findFirstIntersect x y z = head $ x `intersect` y `intersect` z
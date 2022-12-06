module Day4.Solution1 (
    countContainedPairs
) where


import Day4.EDSL


-- | Get the count of how many tasks are contained
countContainedPairs :: Pairs -> Int
countContainedPairs (Pairs ps) = sum $ map (fromEnum . containedPair) ps


-- | Check if one pair contains another
containedPair :: Pair -> Bool
containedPair (Pair first second) = contained (fa, fb) (sa, sb)
    where
        (Elf fa fb) = first
        (Elf sa sb) = second


-- | Check if either range contains one another
contained :: (Ord a) => (a, a) -> (a, a) -> Bool
contained f s = firstInSecond f s || firstInSecond s f


-- | Check if first range is fully contained in the second range
firstInSecond :: (Ord a) => (a, a) -> (a, a) -> Bool
firstInSecond (fa, fb) (sa, sb) = sa <= fa && sb >= fb
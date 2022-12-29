module Day4.Solution2 (
    overlappingPairs,
    overlapping
) where


import Day4.EDSL


-- | Calculate how many pairs have overlapping sections for all pairs
overlappingPairs :: Pairs -> Int
overlappingPairs (Pairs ps) = length $ filter (0/=) (map overlappingPair ps)


-- | Calculate number of overlapping sections for a given pair
overlappingPair :: Pair -> Int
overlappingPair (Pair first second) = overlapping (fa, fb) (sa, sb)
    where
        (Elf fa fb) = first
        (Elf sa sb) = second


-- | Calculate number of overlapping sections
overlapping :: (Int, Int) -> (Int, Int) -> Int
overlapping (fa, fb) (sa, sb) = max 0 $ min fb sb + 1 - max fa sa
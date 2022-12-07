module Day5.Converter (convert) where


import Day5.EDSL
import Day5.CrateLogic (Stack(..))

import Data.List (transpose)


-- | Convert an ElvenCrates to a tuple with a list of Stacks and a list of Moves.
convert :: ElvenCrates -> ([Stack], [Move])
convert (ElvenCrates cs ms) = (stacks, ms)
    where
        stacks = getStacks cs


-- | Generate a list of stacks from a matrix of Crates
getStacks :: [[Crate]] -> [Stack]
getStacks cs = Stack <$> transposed
    where
        transposed = transpose cs

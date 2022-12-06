module Day4.Solution1 (
    run1
) where


import Day4.Parser
import Day4.EDSL


-- | Find the solution
run1 :: String -> Int
run1 = countContainedPairs . getPairs


-- | Get the parsed Pairs, if parseError just error the program
getPairs :: String -> Pairs
getPairs str = do
    let res = parseStr str
    case res of
        (Left err) -> error $ show err
        (Right pairs) -> pairs


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
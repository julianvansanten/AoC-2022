module Day4.Day4 (getDaySolutions) where


import Day4.Solution1
import Day4.Solution2
import Day4.EDSL
import Day4.Parser


getDaySolutions :: (String -> String, String -> String)
getDaySolutions = (solve1, solve2)


solve1 :: String -> String
solve1 = show . run1

solve2 :: String -> String
solve2 = show . run2


-- | Find the first solution
run1 :: String -> Int
run1 = countContainedPairs . getPairs


-- | Find the second solution
run2 :: String -> Int
run2 = overlappingPairs . getPairs


-- | Get the parsed Pairs, if parseError just error the program
getPairs :: String -> Pairs
getPairs str = do
    let res = parseStr str
    case res of
        (Left err) -> error $ show err
        (Right pairs) -> pairs

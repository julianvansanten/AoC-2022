module Day5.Day5 (getDaySolutions) where


import Day5.CrateLogic ( getTopChars, executeMoves )
import Day5.Parser (parseFile)


getDaySolutions :: (String -> String, String -> String)
getDaySolutions = (solve1, solve2)


solve1 :: String -> String
solve1 = run1

solve2 :: String -> String
solve2 = run2


-- | Run the parser, convert the EDSL structure and calculate the end result
run1 :: String -> String
run1 str = getTopChars $ executeMoves id moves stacks
    where
        (stacks, moves) = parseFile str


-- | Run the same parser, but evaluate without reversing the order of the crates
run2 :: String -> String
run2 str = getTopChars $ executeMoves reverse moves stacks
    where
        (stacks, moves) = parseFile str

module Day5.Day5 (getDaySolutions) where


import Day5.Parser ( runElvenCrates )
import Day5.CrateLogic
import Day5.Converter (convert)


getDaySolutions :: (String -> String, String -> String)
getDaySolutions = (solve1, solve2)


solve1 :: String -> String
solve1 = run1

solve2 :: String -> String
solve2 = error "Second solution of day 5 not implemented yet!"


-- | Run the parser, convert the EDSL structure and calculate the end result
run1 :: String -> String
run1 str = getTopChars $ executeMoves moves stacks
    where
        (stacks, moves) = convert $ runElvenCrates str
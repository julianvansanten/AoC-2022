module Day3.Day3 (getDaySolutions) where


import Day3.Solution1 (getPriorities1)
import Day3.Solution2 (getPriorities2)


getDaySolutions :: (String -> String, String -> String)
getDaySolutions = (solve1, solve2)


solve1 :: String -> String
solve1 = show . getPriorities1

solve2 :: String -> String
solve2 = show . getPriorities2

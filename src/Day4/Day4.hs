module Day4.Day4 (getDaySolutions) where


import Day4.Solution1


getDaySolutions :: (String -> String, String -> String)
getDaySolutions = (solve1, solve2)


solve1 :: String -> String
solve1 = show . run1

solve2 :: String -> String
solve2 = error "Second solution of day 4 not implemented yet!"

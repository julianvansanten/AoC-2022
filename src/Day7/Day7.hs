module Day7.Day7 (getDaySolutions) where


import Day7.Parser
import Day7.TreeBuilder
import Day7.Evaluator

getDaySolutions :: (String -> String, String -> String)
getDaySolutions = (solve1, solve2)


solve1 :: String -> String
solve1 = show . calculateSum . evalTree . buildTree . parseFile

solve2 :: String -> String
solve2 = error "Second solution of day 7 not implemented yet!"

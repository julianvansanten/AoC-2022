module Day9.Day9 (getDaySolutions) where


import Day9.Parser ( parseFile )
import Day9.RopePhysics (doScanMoves, countTailPositions)


getDaySolutions :: (String -> String, String -> String)
getDaySolutions = (solve1, solve2)


solve1 :: String -> String
solve1 = show . countTailPositions . doScanMoves . parseFile

solve2 :: String -> String
solve2 = error "Second solution of day 9 not implemented yet!"
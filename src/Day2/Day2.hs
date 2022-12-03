module Day2.Day2 (getDaySolutions) where


import Day2.EDSL
import Day2.Parser
import Day2.PointLogic (calculateTotalPoints)


getDaySolutions :: (String -> String, String -> String)
getDaySolutions = (solve1, solve2)


solve1 :: String -> String
solve1 = show . calculateTotalPoints . getGames1

solve2 :: String -> String
solve2 = show . calculateTotalPoints . getGames2


getGames1 :: String -> Games1
getGames1 str = do
    let x = runGames1 str
    case x of
        (Left err) -> error $ show err 
        (Right games) -> games

getGames2 :: String -> Games2
getGames2 str = do
    let x = runGames2 str
    case x of
        Left pe -> error $ show pe
        Right ga -> ga

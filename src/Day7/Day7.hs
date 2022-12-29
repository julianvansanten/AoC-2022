module Day7.Day7 (getDaySolutions) where


import Day7.Parser ( parseFile )
import Day7.TreeBuilder ( buildTree, Tree )
import Day7.Evaluator ( evalTree, calculateSum, findMin )

getDaySolutions :: (String -> String, String -> String)
getDaySolutions = (solve1, solve2)


solve1 :: String -> String
solve1 = show . calculateSum . getTree
solve2 :: String -> String
solve2 = show . findMin . getTree


getTree :: String -> Tree
getTree = evalTree . buildTree . parseFile
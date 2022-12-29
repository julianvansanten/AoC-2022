module Day7.Day7Spec where


import Test.Hspec ( Spec, describe, it, shouldBe )

import Day7.EDSL ( Command(..), Listing(..) )
import Day7.Parser (parseFile)
import Day7.TreeBuilder
import Day7.Evaluator


spec :: Spec
spec = do
    test1
    test2


test1 :: Spec
test1 = describe "Day7.Parser.parseFile" $ do
            it "Should result in a list of Commands for correct input" $ do 
                calculateSum (evalTree (buildTree (parseFile input))) `shouldBe` sb


test2 :: Spec
test2 = describe "solve2" $ do
    it "no test for day 7 implemented yet!" True


input :: String
input = "$ cd /\n" ++
    "$ ls\n" ++
    "dir a\n" ++
    "14848514 b.txt\n" ++
    "8504156 c.dat\n" ++
    "dir d\n" ++
    "$ cd a\n" ++
    "$ ls\n" ++
    "dir e\n" ++
    "29116 f\n" ++
    "2557 g\n" ++
    "62596 h.lst\n" ++
    "$ cd e\n" ++
    "$ ls\n" ++
    "584 i\n" ++
    "$ cd ..\n" ++
    "$ cd ..\n" ++
    "$ cd d\n" ++
    "$ ls\n" ++
    "4060174 j\n" ++
    "8033020 d.log\n" ++
    "5626152 d.ext\n" ++
    "7214296 k"

sb :: Int
sb = 95437
module Day9.Day9Spec where


import Test.Hspec ( Spec, describe, it, shouldBe, context )
import Day9.Day9 (getDaySolutions)
import Day9.Parser (parseFile)
import Day9.RopePhysics (doScanMoves, grabTail)
import Data.List (nub)


spec :: Spec
spec = do
    test1
    test2


test1 :: Spec
test1 = 
    describe "Day9" $ do
        describe "RopePhysics.grabTail" $ do
            it "Should produce a list of tail positions for the given example" $ do
                (nub . map grabTail . doScanMoves . parseFile) input `shouldBe` []
        describe "Day9.solve1" $ do
            it "Should give the correct result for the given example" $ do
                fst getDaySolutions input `shouldBe` "13"

test2 :: Spec
test2 = describe "solve2" $ do
    it "no test for day 9 implemented yet!" True


input :: String 
input = "R 4\n" ++
    "U 4\n" ++
    "L 3\n" ++
    "D 1\n" ++
    "R 4\n" ++
    "D 1\n" ++
    "L 5\n" ++
    "R 2\n"
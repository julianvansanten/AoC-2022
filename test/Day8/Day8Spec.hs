module Day8.Day8Spec where


import Test.Hspec ( Spec, describe, it, shouldBe )

import Day8.Day8 ( getDaySolutions )

spec :: Spec
spec = do
    test1
    test2

test1 :: Spec
test1 = describe "Day8.Day8.solve1" $ do
    it "should give the correct number of visible trees" $ do
        fst getDaySolutions input `shouldBe` "21"

test2 :: Spec
test2 = describe "Day8.Day8.solve2" $ do
    it "should give the correct scenic score for the given example" $ do
        snd getDaySolutions input `shouldBe` "8"


input :: String
input = "30373\n" ++
    "25512\n" ++
    "65332\n" ++
    "33549\n" ++
    "35390"
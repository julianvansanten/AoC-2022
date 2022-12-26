module Day7.Day7Spec where


import Test.Hspec ( Spec, describe, it, shouldBe )

import Day7.EDSL ( Command(..), Listing(..) )
import Day7.Parser (parseFile)


spec :: Spec
spec = do
    test1
    test2


test1 :: Spec
test1 = describe "Day7.Parser.parseFile" $ do
            it "Should result in a list of Commands for correct input" $ do 
                parseFile input `shouldBe` sb


test2 :: Spec
test2 = describe "solve2" $ do
    it "no test for day 7 implemented yet!" True


input :: String
input = "$ cd /\n$ cd ..\n$ ls\ndir test\n500 test.fil\ndir another"

sb :: [Command]
sb = [Change "/", Change "..", List [Folder "test", File 500 "test.fil", Folder "another"]]
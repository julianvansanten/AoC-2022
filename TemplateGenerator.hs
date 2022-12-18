module TemplateGenerator (main) where


import System.Directory (createDirectoryIfMissing)


main :: IO ()
main = do
    makeFolders
    makeDayFiles
    makeGetSolutions
    makeSolves
    makeSolutionsCollector
    makeTestFolders
    makeDayTestFiles
    makeSpec
    makeIndividualTests


-- Make 31 folders for each day of the week
makeFolders :: IO ()
makeFolders = mapM_ (\x -> createDirectoryIfMissing True ("./src/Day" ++ show x)) [1..31]

-- Fill each folder with a DayX.hs file
makeDayFiles :: IO ()
makeDayFiles = mapM_ (\x -> writeFile ("./src/Day" ++ show x ++ "/Day" ++ show x ++ ".hs") ("module Day" ++ show x ++ ".Day" ++ show x ++ " (getDaySolutions) where\n\n\n")) [1..31]

-- Fill each DayX.hs file with a getSolutions function that returns a tuple with two functions from String to String
makeGetSolutions :: IO ()
makeGetSolutions = mapM_ (\x -> appendFile ("./src/Day" ++ show x ++ "/Day" ++ show x ++ ".hs") ("getDaySolutions :: (String -> String, String -> String)\ngetDaySolutions = (solve1, solve2)\n\n\n")) [1..31]

makeSolves :: IO ()
makeSolves = mapM_ (\x -> appendFile ("./src/Day" ++ show x ++ "/Day" ++ show x ++ ".hs") 
        ("solve1 :: String -> String\nsolve1 = error \"First solution of day " 
        ++ show x ++ " not implemented yet!\"\n\nsolve2 :: String -> String\nsolve2 = error \"Second solution of day " ++ show x ++ " not implemented yet!\"")) [1..31]

-- Make a SolutionsCollector.hs file that takes all the getSolutions functions from each module DayX/DayX.hs and puts them in a list
makeSolutionsCollector :: IO ()
makeSolutionsCollector = do
    writeFile "./src/SolutionsCollector.hs" "module SolutionsCollector (getSolutions, getDay) where\n\n\n"
    mapM_ (\x -> appendFile "./src/SolutionsCollector.hs" ("import Day" ++ show x ++ ".Day" ++ show x ++ " as Day" ++ show x ++ "\n")) [1..31]
    appendFile "./src/SolutionsCollector.hs" "\n\n-- | List of all solutions for each day"
    appendFile "./src/SolutionsCollector.hs" "\ngetSolutions :: [(String -> String, String -> String)]\ngetSolutions = [\n"
    mapM_ (\x -> appendFile "./src/SolutionsCollector.hs" ("    Day" ++ show x ++ ".getDaySolutions, \n")) [1..30]
    appendFile "./src/SolutionsCollector.hs" ("    Day" ++ show 31 ++ ".getDaySolutions\n    ]\n\n\n")
    appendFile "./src/SolutionsCollector.hs" "-- | Get solutions for a given day\ngetDay :: Int -> (String -> String, String -> String)\ngetDay x = getSolutions !! (x - 1)\n\n"


-- Make 31 test folders for each day of the week
makeTestFolders :: IO ()
makeTestFolders = mapM_ (\x -> createDirectoryIfMissing True ("./test/Day" ++ show x)) [1..31]


-- Fill each folder with a DayX.hs file
makeDayTestFiles :: IO ()
makeDayTestFiles = mapM_ (\x -> writeFile ("./test/Day" ++ show x ++ "/Day" ++ show x ++ "Spec.hs") ("module Day" ++ show x ++ ".Day" ++ show x ++ "Spec where\n\n\n")) [1..31]


makeSpec :: IO ()
makeSpec = mapM_ (\x -> appendFile ("./test/Day" ++ show x ++ "/Day" ++ show x ++ "Spec.hs")
        "import Test.Hspec ( Spec, describe, it )\n\n\nspec :: Spec\nspec = do\n    test1\n    test2\n\n\n"
    ) [1..31]


makeIndividualTests :: IO ()
makeIndividualTests = mapM_ (\x -> appendFile ("./test/Day" ++ show x ++ "/Day" ++ show x ++ "Spec.hs") 
        ("test1 :: Spec\nsolve1 = describe \"solve1\" $ do\n    it \"no test for day " 
        ++ show x ++ " implemented yet!\" True\n\ntest2 :: Spec\nsolve2 = describe \"solve2\" $ do\n    it \"no test for day " 
        ++ show x ++ " implemented yet!\" True")) [1..31]

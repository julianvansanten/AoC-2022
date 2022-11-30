module TemplateGenerator (main) where


import System.Directory (createDirectoryIfMissing)


main :: IO ()
main = do
    makeFolders
    makeDayFiles
    makeGetSolutions
    makeSolves
    makeSolutionsCollector


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
    writeFile "./src/SolutionsCollector.hs" "module SolutionsCollector (getSolutions) where\n\n\n"
    mapM_ (\x -> appendFile "./src/SolutionsCollector.hs" ("import Day" ++ show x ++ ".Day" ++ show x ++ " as Day" ++ show x ++ "\n")) [1..31]
    appendFile "./src/SolutionsCollector.hs" "\n\n-- | List of all solutions for each day"
    appendFile "./src/SolutionsCollector.hs" "\ngetSolutions :: [(String -> String, String -> String)]\ngetSolutions = [\n"
    mapM_ (\x -> appendFile "./src/SolutionsCollector.hs" ("    Day" ++ show x ++ ".getDaySolutions, \n")) [1..30]
    appendFile "./src/SolutionsCollector.hs" ("    Day" ++ show 31 ++ ".getDaySolutions\n    ]\n\n\n")
    appendFile "./src/SolutionsCollector.hs" "-- | Get solutions for a given day\ngetDay :: Int -> (String -> String, String -> String)\ngetDay x = getSolutions !! (x - 1)\n\n"
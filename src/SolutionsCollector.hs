module SolutionsCollector (getSolutions) where


import Day1.Day1 as Day1
import Day2.Day2 as Day2
import Day3.Day3 as Day3
import Day4.Day4 as Day4
import Day5.Day5 as Day5
import Day6.Day6 as Day6
import Day7.Day7 as Day7
import Day8.Day8 as Day8
import Day9.Day9 as Day9
import Day10.Day10 as Day10
import Day11.Day11 as Day11
import Day12.Day12 as Day12
import Day13.Day13 as Day13
import Day14.Day14 as Day14
import Day15.Day15 as Day15
import Day16.Day16 as Day16
import Day17.Day17 as Day17
import Day18.Day18 as Day18
import Day19.Day19 as Day19
import Day20.Day20 as Day20
import Day21.Day21 as Day21
import Day22.Day22 as Day22
import Day23.Day23 as Day23
import Day24.Day24 as Day24
import Day25.Day25 as Day25
import Day26.Day26 as Day26
import Day27.Day27 as Day27
import Day28.Day28 as Day28
import Day29.Day29 as Day29
import Day30.Day30 as Day30
import Day31.Day31 as Day31


-- | List of all solutions for each day
getSolutions :: [(String -> String, String -> String)]
getSolutions = [
    Day1.getDaySolutions, 
    Day2.getDaySolutions, 
    Day3.getDaySolutions, 
    Day4.getDaySolutions, 
    Day5.getDaySolutions, 
    Day6.getDaySolutions, 
    Day7.getDaySolutions, 
    Day8.getDaySolutions, 
    Day9.getDaySolutions, 
    Day10.getDaySolutions, 
    Day11.getDaySolutions, 
    Day12.getDaySolutions, 
    Day13.getDaySolutions, 
    Day14.getDaySolutions, 
    Day15.getDaySolutions, 
    Day16.getDaySolutions, 
    Day17.getDaySolutions, 
    Day18.getDaySolutions, 
    Day19.getDaySolutions, 
    Day20.getDaySolutions, 
    Day21.getDaySolutions, 
    Day22.getDaySolutions, 
    Day23.getDaySolutions, 
    Day24.getDaySolutions, 
    Day25.getDaySolutions, 
    Day26.getDaySolutions, 
    Day27.getDaySolutions, 
    Day28.getDaySolutions, 
    Day29.getDaySolutions, 
    Day30.getDaySolutions, 
    Day31.getDaySolutions
    ]


-- | Get solutions for a given day
getDay :: Int -> (String -> String, String -> String)
getDay x = getSolutions !! (x - 1)


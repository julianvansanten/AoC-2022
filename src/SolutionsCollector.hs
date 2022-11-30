module SolutionsCollector (getSolutions) where


import Day1
import Day2
import Day3
import Day4
import Day5
import Day6
import Day7
import Day8
import Day9
import Day10
import Day11
import Day12
import Day13
import Day14
import Day15
import Day16
import Day17
import Day18
import Day19
import Day20
import Day21
import Day22
import Day23
import Day24
import Day25
import Day26
import Day27
import Day28
import Day29
import Day30
import Day31


-- | List of all solutions for each day
getSolutions :: [(String -> String, String -> String)]
getSolutions = [
	Day1.getSolutions, 
	Day2.getSolutions, 
	Day3.getSolutions, 
	Day4.getSolutions, 
	Day5.getSolutions, 
	Day6.getSolutions, 
	Day7.getSolutions, 
	Day8.getSolutions, 
	Day9.getSolutions, 
	Day10.getSolutions, 
	Day11.getSolutions, 
	Day12.getSolutions, 
	Day13.getSolutions, 
	Day14.getSolutions, 
	Day15.getSolutions, 
	Day16.getSolutions, 
	Day17.getSolutions, 
	Day18.getSolutions, 
	Day19.getSolutions, 
	Day20.getSolutions, 
	Day21.getSolutions, 
	Day22.getSolutions, 
	Day23.getSolutions, 
	Day24.getSolutions, 
	Day25.getSolutions, 
	Day26.getSolutions, 
	Day27.getSolutions, 
	Day28.getSolutions, 
	Day29.getSolutions, 
	Day30.getSolutions, 
	Day31.getSolutions
	]


-- | Get solutions for a given day
getDay :: Int -> (String -> String, String -> String)
getDay x = getSolutions !! (x - 1)


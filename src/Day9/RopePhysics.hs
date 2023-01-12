module Day9.RopePhysics (
    doMoves
    , doScanMoves
    , countTailPositions
    , grabTail
    , tailPath
) where

import Day9.Rope ( Rope(..) )
import Day9.EDSL ( Move(..), Direction(RLeft, RUp, RDown, RRight) )
import Data.List (nub)


-- | Calculate the total length of the path the tail took
tailPath :: (Int, Int) -> (Int, Int) -> [(Int, Int)]
tailPath (x, y) (a, b) | a == x && y == b = [(a, b)]
        | abs (a-x) == max (abs (a-x)) (abs (b-y)) = [(i, b) | i <- [min x a..max x a - 1]]
        | otherwise = [(a, i) | i <- [min y b..max y b - 1]]


-- | Count the unique tail positions
countTailPositions :: [Rope] -> Int
countTailPositions = length . nub . map grabTail


-- | Grab the tail position from a Rope
grabTail :: Rope -> (Int, Int)
grabTail (Rope _ (a, b)) = (a, b)


-- | Make all moves in a list and store all intermediate rope states in a list, starting with a rope with its head and tail both at @(0,0)@
doScanMoves :: [Move] -> [Rope]
doScanMoves = scanl doMove (Rope (0,0) (0,0))


-- | Make all moves in a list, starting with a rope with its head and tail both at @(0,0)@
{-# DEPRECATED doMoves "Use doScanMoves instead" #-}
doMoves ::[Move] -> Rope
doMoves = foldl doMove (Rope (0,0) (0,0))


-- | Make a move on a rope
-- Any move is equal to rotating coordinates and moving up, then rotating back
doMove :: Rope -> Move -> Rope
doMove (Rope h@(x, y) t) (Move RUp i) = Rope (x, y+i) $ moveTailUp i h t
doMove (Rope h@(x, y) t) (Move RDown i) = Rope (x, y-i) $ rotate180 $ moveTailUp i (rotate180 h) (rotate180 t)
doMove (Rope h@(x, y) t) (Move RRight i) = Rope (x+i, y) $ rotate90CW $ moveTailUp i (rotate90CCW h) (rotate90CCW t)
doMove (Rope h@(x, y) t) (Move RLeft i) = Rope (x-i, y) $ rotate90CCW $ moveTailUp i (rotate90CW h) (rotate90CW t)


-- | Calculate the position of the tail when moving i positions up
-- The result depends on the position of the tail, the number to move and the position of the head
moveTailUp :: Int -> (Int, Int) -> (Int, Int) -> (Int, Int)
moveTailUp i (x, y) (a, b) | b == y = if i <= 1 then (a, b) else (x, b + i - 1)
    | y > b = (x, b + i)
    | otherwise = if i <= 2 then (a, b) else (x, b + i - 2)


-- | Rotate a set of coordinates 90 degrees clockwise
rotate90CW :: (Int, Int) -> (Int, Int)
rotate90CW (x, y) = (y, -x)


-- | Rotate a set of coordinates 180 degrees
rotate180 :: (Int, Int) -> (Int, Int)
rotate180 (x, y) = (-x, -y)


-- | Rotate a set of coordinates 270 degrees clockwise / 90 degrees counterclockwise
rotate90CCW :: (Int, Int) -> (Int, Int)
rotate90CCW (x, y) = (-y, x)
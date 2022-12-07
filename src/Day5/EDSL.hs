module Day5.EDSL (
    Crate(..),
    Move(..),
    ElvenCrates(..)
) where


-- | A crate with a character in it, or an empty crate (only used for parsing)
data Crate = Crate Char | EmptyCrate
    deriving (Eq, Show)


-- | A move with the amount of boxes, a location from where to pick the crates and where to move them to.
data Move = Move Int Int Int
    deriving (Eq, Show)


data ElvenCrates = ElvenCrates [[Crate]] [Move]
    deriving (Eq, Show)
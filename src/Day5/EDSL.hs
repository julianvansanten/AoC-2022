module Day5.EDSL (
    Crate(..),
    CrateMatrix(..),
    Stack(..),
    Move(..)
) where


-- | A crate with a character in it, or an empty crate (only used for parsing)
data Crate = Crate Char | EmptyCrate
    deriving (Eq, Show)


-- | A stack of crates. Has a crate number and a list of crates. Can have any number of crates, as well as no crates.
data Stack = Stack Int [Crate]
    deriving (Eq, Show)


-- | A move with the amount of boxes, a location from where to pick the crates and where to move them to.
data Move = Move Int Int Int
    deriving (Eq, Show)


data CrateMoving = CrateMoving [[Stack]] [Move]
    deriving (Eq, Show)
module Day5.EDSL (
    Crate(..),
    Move(..),
    Stack(..)
) where


-- | A crate with a character in it, or an empty crate (only used for parsing)
data Crate = Crate Char | EmptyCrate
    deriving (Eq)


-- | A move with the amount of boxes, a location from where to pick the crates and where to move them to.
data Move = Move Int Int Int
    deriving (Eq)


newtype Stack = Stack [Crate]
    deriving (Eq)


instance Show Move where
    show (Move c f t) = "move " ++ show c ++ " from " ++ show f ++ " to " ++ show t


instance Show Crate where
    show (Crate c) = "[" ++ show c ++ "]"
    show EmptyCrate = "   "


instance Show Stack where
    show (Stack cs) = "Stack -> {" ++ unwords (map show cs) ++ "}"
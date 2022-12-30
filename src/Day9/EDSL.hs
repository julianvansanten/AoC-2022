module Day9.EDSL
    (
        Move(..)
        , Direction(..)
    )
    where


-- | A direction can be up, down, left or right
data Direction = RUp | RDown | RLeft | RRight
    deriving (Eq)


-- | A move consists of a direction and the amount of steps taken
data Move = Move Direction Int
    deriving (Eq, Show)


instance Show Direction where
    show RUp = "up"
    show RDown = "down"
    show RLeft = "left"
    show RRight = "right"
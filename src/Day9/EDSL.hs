module Day9.EDSL
    (
        Move(..)
        , Direction(..)
    )
    where


data Direction = RUp | RDown | RLeft | RRight
    deriving (Eq)


data Move = Move Direction Int
    deriving (Eq, Show)


instance Show Direction where
    show RUp = "up"
    show RDown = "down"
    show RLeft = "left"
    show RRight = "right"
module Day7.EDSL (
    Listing(..),
    Command(..)
) where


data Listing = File Int String | Folder String
    deriving (Eq, Show)


data Command = Change String | List [Listing]
    deriving (Eq, Show)

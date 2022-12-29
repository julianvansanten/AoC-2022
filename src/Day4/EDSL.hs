module Day4.EDSL (
    Pair(..),
    Elf(..),
    Pairs(..)
) where


data Pair = Pair Elf Elf
    deriving (Eq, Show)


data Elf = Elf Int Int
    deriving (Eq, Show)


newtype Pairs = Pairs [Pair]
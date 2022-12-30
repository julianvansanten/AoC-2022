module Day9.Rope (
    Rope(..)
) where


-- | One rope has two ends
data Rope = Rope (Int, Int) (Int, Int)
    deriving (Eq)


instance Show Rope where
    show (Rope h t) = "Rope Head:" ++ show h ++ ", Tail:" ++ show t
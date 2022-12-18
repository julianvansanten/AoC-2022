module Day7.Evaluator () where


data Unit = File String Int | Folder String [Unit]
    deriving (Eq, Show)


-- instance Show Unit where
--     show (File name size) = name ++ "- (file, size=" ++ show size ++ ")"
--     show (Folder name us) = name ++ "- (dir)" ++ "\n" ++ intercalate "\n" (map (\x -> "  " ++ show x) us)



-- | Recursively calculate the total size of a given Unit
sizeOfUnit :: Unit -> Int
sizeOfUnit (File _ s) = s
sizeOfUnit (Folder _ us) = sum $ map sizeOfUnit us

module Day7.Evaluator () where


data Unit = File String Int | Folder String [Unit]
    deriving (Eq, Show)


data Location = Leaf String | Node String Location


-- | Recursively calculate the total size of a given Unit
sizeOfUnit :: Unit -> Int
sizeOfUnit (File _ s) = s
sizeOfUnit (Folder _ us) = sum $ map sizeOfUnit us


isNamedFolder :: Unit -> String -> Bool
isNamedFolder (File _ _) _ = False
isNamedFolder (Folder name _) target = name == target


isNamedFile :: Unit -> String -> Bool
isNamedFile (File name _) target = name == target
isNamedFile (Folder _ _) _ = False


containsName :: Unit -> String -> Bool
containsName (File _ _) _ = False
containsName (Folder _ us) target = any (\x -> isNamedFolder x target || isNamedFile x target) us


firstInFolder :: Unit -> String -> Unit
firstInFolder (File _ _) _ = error "Not a folder!"
firstInFolder (Folder _ us) target = head $ filter (\x -> isNamedFolder x target || isNamedFile x target) us


-- | Add a given Unit to a Folder at a given Location
addUnit :: Unit -> Unit -> Location -> Unit
addUnit _ (File _ _) _ = error "Cannot add a Unit to a File!"
addUnit unit (Folder fn us) (Leaf tfn) | fn == tfn = Folder fn (us ++ [unit])
    | otherwise = error "Folder does not exist!"
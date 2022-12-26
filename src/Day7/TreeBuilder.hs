module Day7.TreeBuilder (
    buildTree
    , Tree(..)
    ) where


import Day7.EDSL (Listing(..), Command(..))


-- | Data structure storing the folders as nodes and files as trees
data Tree = Node String [Tree] | Leaf String Int
    deriving (Eq, Show)


{- | Build a tree from a list of commands
    Utilizes the list of commands to traverse and fill the tree
-}
-- TODO implement
buildTree :: [Command] -> Tree
buildTree = undefined


-- | Recursively calculate the total size of a given Unit
sizeOfUnit :: Tree -> Int
sizeOfUnit (Leaf _ s) = s
sizeOfUnit (Node _ cs) = sum $ map sizeOfUnit cs


traverseTree :: [String] -> Tree -> Tree
traverseTree [] _ = error "Selection invalid!"
traverseTree (x:xs) t | x == "/" = foldr enterFolder t xs
    | otherwise = error "Selection not starting at root!"


enterFolder :: String -> Tree -> Tree
enterFolder _ (Leaf _ _) = error "Current selection is a file!"
enterFolder str (Node _ cs) = res
    where
        res = head $ filter (\f -> getFolderName f == str) cs


-- | Get the name of a folder, or return an empty string if the given tree is a file
getFolderName :: Tree -> String
getFolderName (Node name _) = name
getFolderName (Leaf _ _) = ""
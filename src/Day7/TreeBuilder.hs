module Day7.TreeBuilder (buildTree) where


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


-- traverseTree :: [String] -> Tree -> Maybe Tree
-- traverseTree _ (Leaf _ _) = Nothing
-- traverseTree [n] t@(Node fn _) | n == fn = Just t
--     | otherwise = Nothing
-- traverseTree [] _ = Nothing
-- traverseTree (n:next) (Node fn cs) | n == fn = Just res
--     | otherwise = Nothing
--     where
        


-- findNode :: [String] -> Tree -> Maybe Tree
-- findNode (n:next) (Node fn cs) | fn == n = Just res
--     | otherwise = Nothing
--     where
--         res = head $ filter (\(Node a _) -> a == nextname) cs
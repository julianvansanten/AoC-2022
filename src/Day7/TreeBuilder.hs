{-# OPTIONS_GHC -Wincomplete-patterns #-}
module Day7.TreeBuilder (
    buildTree
    , Tree(..)
    ) where


import Day7.EDSL (Listing(..), Command(..))


-- | Data structure storing the folders as nodes and files as trees
data Tree = Node String Int [Tree] | Leaf String Int
    deriving (Eq, Show)


{- | Build a tree from a list of commands
    Utilizes the list of commands to traverse and fill the tree
-}
buildTree :: [Command] -> Tree
buildTree cs = buildTree' [] cs $ Node "/" (-1) []


buildTree' :: [String] -> [Command] -> Tree -> Tree
buildTree' _ [] t = t
buildTree' loc (c@(Change _):xs) t = buildTree' (applyChange loc c) xs t
buildTree' loc (c@(List _):xs) t = buildTree' loc xs (addListing loc c t)


-- | Convert the EDSL to the tree structure IR
convert :: Listing -> Tree
convert (File i n) = Leaf n i
convert (Folder n) = Node n (-1) []


-- | Get the name of a folder, or return an empty string if the given tree is a file
getFolderName :: Tree -> String
getFolderName (Node name _ _) = name
getFolderName (Leaf _ _) = ""


-- | Apply a change in directory to the current location list
applyChange :: [String] -> Command -> [String]
applyChange loc (List _) = loc
applyChange loc (Change fol) | fol == ".." = let x = init loc in if null x then ["/"] else x
    | fol == "/" = ["/"]
    | otherwise = loc ++ [fol]


-- | Add the contents of a listing at a given location to a given tree
addListing :: [String] -> Command -> Tree -> Tree
addListing _ (Change _) t = t
addListing [] _ _ = error "Invalid folder!"
addListing [n] (List ls) (Node m s cs) | n == m = Node m s (cs ++ map convert ls)
        | otherwise = error $ "Folder " ++ n ++ " does not exist!"
addListing (x:y:xs) list (Node m s cs) | x /= m = error $ "Folder " ++ x ++ " does not exist!"
    | otherwise = Node m s (others ++ [addListing (y:xs) list change])
    where
        change = head $ filter (\f -> getFolderName f == y) cs
        others = filter (\f -> getFolderName f /= y) cs
addListing _ _ _ = error "Something went wrong!"
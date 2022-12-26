module Day7.Evaluator () where


import Day7.EDSL (Command(..))
import Day7.TreeBuilder ( Tree(..) )


-- | Apply a change in directory to the current location list
applyChange :: [String] -> Command -> [String]
applyChange loc (List _) = loc
applyChange loc (Change fol) | fol == ".." = init loc
    | fol == "/" = ["/"]
    | otherwise = loc ++ [fol]


-- | Add the contents of a listing at a given location to a given tree
addListing :: [String] -> Command -> Tree -> Tree
-- TODO finish implementation
addListing _ (Change _) t = t
addListing _ _ _ = undefined

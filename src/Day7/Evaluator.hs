module Day7.Evaluator (
    evalTree
    , calculateSum
    , findMin
) where


import Day7.TreeBuilder ( Tree(..) )


-- | Find the minimal size of a folder to delete from a given tree
-- Assume the root node of the tree to be the entire filesystem
findMin :: Tree -> Int
findMin t = findMinFolder (requiredSpace t) t


-- | Find the minimal size of a folder to delete
-- Include the current folder in the search if the folder satisfies the size criteria
-- Give the required folder size as the first argument
findMinFolder :: Int -> Tree -> Int
findMinFolder _ (Leaf _ _) = maxBound :: Int
findMinFolder req (Node _ sz cs) | sz >= req = minimum $ sz : map (findMinFolder req) cs
    | otherwise = minimum $ map (findMinFolder req) cs


-- | Calculate the required space for the update to succeed
-- A file will always return the max int value, as it should not be chosen for deletion
-- Required size = size of the update - free storage already available
requiredSpace :: Tree -> Int
requiredSpace (Leaf _ _) = maxBound :: Int
requiredSpace (Node _ sz _) = updateSize - (fsSize - sz)


-- | The size of the file system
fsSize :: Int
fsSize = 70000000


-- | The size of the update
updateSize :: Int
updateSize = 30000000


-- | Traverse the tree and add all folders where the size is at most 100000
-- Ignore single files
calculateSum :: Tree -> Int
calculateSum (Leaf _ _) = 0
calculateSum (Node _ sz cs) | sz >= 0 && sz <= 100000 = sz + children
    | otherwise = children
    where children = sum $ map calculateSum cs


-- | Evaluate the size of all folders and add to each Node its size
evalTree :: Tree -> Tree
evalTree c@(Leaf _ _) = c
evalTree c@(Node n s cs) | s == -1 = Node n (sum (map size evaluated)) evaluated
    | otherwise = c
    where evaluated = map evalTree cs


-- | Grab the size attribute of the given Node or Leaf
size :: Tree -> Int
size (Leaf _ s) = s
size (Node _ s _) = s
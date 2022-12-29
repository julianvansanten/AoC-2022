module Day7.Evaluator (
    evalTree
    , calculateSum
) where


import Day7.TreeBuilder ( Tree(..) )



-- | Calculate the required space for the update to succeed
-- Required size = size of the update - free storage already available
-- The answer is the folder for which the required space is the minimal value
requiredSpace :: Tree -> Int
requiredSpace (Leaf _ _) = error "Cannot store an update in a file!"
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